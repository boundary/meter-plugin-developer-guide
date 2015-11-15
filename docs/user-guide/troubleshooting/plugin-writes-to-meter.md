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