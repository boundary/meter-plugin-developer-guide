Measurements
============

A meter plugin communicates measurements to the plugin manager using the following format:

```
<Metric> <Value> <Source> <Timestamp>\n
```
where each of the fields are described below.

### Metric

Name of defined metric (see [Metrics](metrics.md))

### Value

The value of the measurement from the service, application, etc.

### Source

String identifying the source of the measurement. _NOTE_: No spaces are allowed in sources.

### Timestamp

Time of the measurement ocurrence, in either seconds from epoch or milli-seconds from epoch.

### Optional Fields

All of the field are not required to be present suitable defaults being applied for missing values as follows:

- In the case where the `TIMESTAMP` is missing the timestamp is set to the receipt time at the plugin manager.

- In the case where the `SOURCE` and `METRIC_TIMESTAMP` are missing the source defaults to the host where the plugin is running.

- In the unique case where only a `METRIC_VALUE` is provided the `METRIC_IDENTIFIER` is assumed to be the first one in listed in the `metrics` field in the `plugin.json` (see the topic [Manifest](manifest.md)). __NOTE:__ It is not recommended to send measurements in this format, it is only mentioned here for backward compatability.

### Examples

- A measurement with a source ___myhost___ on ___Sat Nov 14 03:30:49 UTC 2015___ with a metric of ___CPU___ a value of 80% percent (assuming the metric unit is _percent_, See [Metrics](metrics.md)):

```
CPU 0.80 myhost 1447471849
```

- A measurement with a source ___myhost___ with a metric of ___NETRB___ (Network Inbound) a value of 5,028 bytes with the timestamp assigned upon receipt by the plugin manager.

```
NETRB 5028 myhost
```

- A measurement with a source of the ___hostname___ where the plugin is running with a metric of ___DISKW___ (Disk Writes) a value of 8,197 bytes with a timestamp assigned upon receipt by the plugin manager.

```
DISKW 5028
```
