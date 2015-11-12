# Meter Plugin Protocol
As mentioned previously meter plugins can be programmed using any language that can write to standard out.

Type types of information are interpreted by the plugin manager:

1. Measurements
2. Events

The Boundary Meter delegates the management of all meter plugins to the plugin manager.

The plugin manager expects a script or program to send metrics via standard output with the given format:

```
<METRIC_IDENTIFIER> <METRIC_VALUE> <METRIC_SOURCE> <METRIC_TIMESTAMP>\n
```

where

_METRIC_IDENTIFIER_ is a reference to a previous defined metric for this measurement
_METRIC_VALUE_ is the measurement value of the metric
_METRIC_SOURCE_ is the source of the measurement
_METRIC_TIMESTAMP_ is the time of the measurement which is either seconds from epoch or milli-seconds from epoch

All of the above fields are not required with suitable defaults being applied for missing values as follows:

- In the case where the `METRIC_TIMESTAMP` is missing the timestamp is set to the receipt time at the meter manager.

- In the case where the `METRIC_SOURCE` and `METRIC_TIMESTAMP` are missing the source defaults to the host where the plugin is running.

- In the unique case where only a `METRIC_VALUE` is provided the `METRIC_IDENTIFIER` is assumed to be the first one in listed in the `metrics` field in the `plugin.json` (see the topic [Manifest](manifest.md)).



