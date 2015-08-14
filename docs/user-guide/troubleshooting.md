# Troubleshooting Meter Plugins

We use the voltage meter analogy to trace the flow of measurements from the plugin to Boundary.

The pathway for measurements to be sent to Boundary is as follows:

1. Meter plugin sends measurements to standard output via [protocol]()
2. Plugin Manager (`pluginmgr`) reads the standard out from the meter plugin
3. Plugin Manager writes the measurement to the meter via the Meter(`boundary-meter`) RPC channel
4. Meter reads the Meter RPC call sent by the Plugin Manager
5. Meter sends the measurement to Boundary via an HTTPS Rest call

The sections that follow provide tools and techniques to trace the above data flow.

**NOTE:** These techniques are currently only applicable to UNIX/Linux environments where tools are provide to trace the data flow.

## Meter Plugin sends measurements to standard output

Standard output is _file descriptor_ `1` and using `lsof` we are able to see the file descriptor. Typical output is the following:

```
...
boundary- 24931 boundary    0r  FIFO                0,8      0t0  94785 pipe
...
```
To view the output in real time we use `strace` with the following options:

```
$ sudo strace -e write=1 -e trace=write -p <meter plugin pid> -s 256
```

where the _meter plugin pid_ is obtains by running the following:

```
[vagrant@centos-6-6 ~]$ pgrep -flu boundary
24698 /usr/bin/boundary-meter -b /etc/boundary -I boundary-meter -G
24704 pluginmgr --pluginmgr /usr/bin/boundary-meter --basedir /etc/boundary --extdir /etc/boundary --hostname centos-6-6.hsd1.ca.comcast.net
24736 httpcheck --lua init.lua
24931 elasticsearch --lua init.lua
```

The meter plugins are identified by the option `--lua init.lua` and the number on the left indicates the process id.

From our example above, we use the process ID to observe the meter plugins output:

```
[vagrant@centos-6-6 ~]$ sudo strace -e write=1 -e trace=write -p 24931 -s 128
Process 24931 attached
write(22, "GET /_cluster/stats HTTP/1.1\r\nHost: 127.0.0.1:9200\r\nUser-Agent: Boundary Meter <support@boundary.com>\r\nConnection: close\r\n\r\n", 124) = 124
write(1, "ELASTIC_SEARCH_FIELDDATA_MEMORY_SIZE 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\n", 76) = 76
 | 00000  45 4c 41 53 54 49 43 5f  53 45 41 52 43 48 5f 46  ELASTIC_SEARCH_F |
 | 00010  49 45 4c 44 44 41 54 41  5f 4d 45 4d 4f 52 59 5f  IELDDATA_MEMORY_ |
 | 00020  53 49 5a 45 20 30 2e 30  30 30 30 30 30 20 54 45  SIZE 0.000000 TE |
 | 00030  53 54 5f 45 4c 41 53 54  49 43 53 45 41 52 43 48  ST_ELASTICSEARCH |
 | 00040  5f 43 45 4e 54 4f 53 5f  36 5f 36 0a              _CENTOS_6_6.     |
 ...
```
where above output is truncated, when running the command the output will be continuous with each write call by the meter plugins being displayed.


## Plugin Manager reads Meter Plugin

We can use `strace` similarly to see the Plugin Manager read the output from the Meter Plugin. We obtain the pid the
Plugin Manager (`pluginmgr`) process id by :

```
[vagrant@centos-6-6 ~]$ pgrep -flu boundary
24698 /usr/bin/boundary-meter -b /etc/boundary -I boundary-meter -G
24704 pluginmgr --pluginmgr /usr/bin/boundary-meter --basedir /etc/boundary --extdir /etc/boundary --hostname centos-6-6.hsd1.ca.comcast.net
24736 httpcheck --lua init.lua
24931 elasticsearch --lua init.lua
```

And the trace the read system call of the Plugin Manager:

```
[vagrant@centos-6-6 ~]$ sudo strace -p 24704 -e trace=read -s 1024
Process 24704 attached
read(22, "ELASTIC_SEARCH_FIELDDATA_MEMORY_SIZE 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_PRIMARY_SHARDS 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_COMPLETION_SIZE 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_STATUS 1.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_FILTER_CACHE_EVICTIONS 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_DOCUMENT_COUNT 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_STORE_SIZE 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_ID_CACHE_MEMORY_SIZE 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_FIELDDATA_EVICTIONS 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_FILTER_CACHE_MEMORY_SIZE 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_INDEX_COUNT 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_SEGMENT_COUNT 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_TOTAL_SHARDS 0.000000 TEST_ELASTICSEARCH_CENTOS_6_6\nELASTIC_SEARCH_NODE_COUNT 1.000000 TEST_ELASTICSEARCH_CENTOS_6_6\n", 1024) = 981
read(22, 0x7fffed12d370, 1024)          = -1 EAGAIN (Resource temporarily unavailable)
```

## Plugin Manager writes to the Meter

Using the same techniques above we can observe the Meter RPC call:

```
[vagrant@centos-6-6 ~]$ pgrep -flu boundary
24698 /usr/bin/boundary-meter -b /etc/boundary -I boundary-meter -G
24704 pluginmgr --pluginmgr /usr/bin/boundary-meter --basedir /etc/boundary --extdir /etc/boundary --hostname centos-6-6.hsd1.ca.comcast.net
24736 httpcheck --lua init.lua
24931 elasticsearch --lua init.lua
```

And then trace the write call showing the Meter RPC call:

```
[vagrant@centos-6-6 ~]$ sudo strace -p 24704 -e trace=write -s 1024
Process 24704 attached
write(1, "{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_FIELDDATA_MEMORY_SIZE\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}", 179) = 179
write(1, "{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_PRIMARY_SHARDS\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}", 172) = 172
write(1, "{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_COMPLETION_SIZE\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}", 173) = 173
```

## Meter reads the RPC call from the Plugin Manager

```
[vagrant@centos-6-6 ~]$ sudo strace -p 24698 -e trace=read -s 1024 | more
Process 24698 attached
read(20, "{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_FIELDDATA_MEMORY_SIZE\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_PRIMARY_SHARDS\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_COMPLETION_SIZE\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_STATUS\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":1.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_FILTER_CACHE_EVICTIONS\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_DOCUMENT_COUNT\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"v", 1024) = 1024
read(20, "alue\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_STORE_SIZE\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_ID_CACHE_MEMORY_SIZE\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_FIELDDATA_EVICTIONS\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_FILTER_CACHE_MEMORY_SIZE\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_INDEX_COUNT\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_SEGMENT_COUNT\",\"hostname\":\"TEST_ELASTIC", 1024) = 1024
read(20, "SEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_TOTAL_SHARDS\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":0.000000}}{\"jsonrpc\":\"2.0\",\"method\":\"metric\",\"params\":{\"plugin\":\"elasticsearch\",\"metric\":\"ELASTIC_SEARCH_NODE_COUNT\",\"hostname\":\"TEST_ELASTICSEARCH_CENTOS_6_6\",\"value\":1.000000}}", 1024) = 375
read(20, 0x7fff79e5f850, 1024)          = -1 EAGAIN (Resource temporarily unavailable)
```



