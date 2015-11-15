Meter Plugin Sends Measurement
==============================

A running meter\'s output can be observed to ensure that output is as expected.

### Meter Plugin File Descriptor

Meter Plugin sends measurements to standard output. Standard output is _file descriptor_ `1` and using `lsof` we are able to see the file descriptor. Typical output is the following:

```
...
boundary- 24931 boundary    0r  FIFO                0,8      0t0  94785 pipe
...
```

### Viewing Meter Plugin Output

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

