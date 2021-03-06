# Metric Definitions

Metric definitions in TrueSight Pulse provide metadata about measurements input
to the TrueSight Pulse monitoring system. This page provides details on metric definitions including:

- How to define metrics
- Best practices with respect to their naming.

A _metric definition_ consists of 7 values:

- _Name_ - unique metric identifier
- _Display Name_ - Label used within the web interface.
- _Short Display Name_ - Shortened label used with the web interface.
- _Description_ - Text that describes the metric.
- _Default Aggregate_ - Type of aggregate displayed by default
- _Unit_ - Quantity measured by this metric
- _Default Resolution_ - Expected frequency of measurement update

### Name

Metric identifiers are unique immutable keys within a TrueSight Pulse account.
Metric identifiers are referenced in the plugin manifest (see [Plugin Manifest](manifest.md))
and when a plugin is deployed in an account other then where the metric definitions were created, they are _copied_ into the new account.

Metric identifiers are case insensitive but by convention they are always
in upper case letters (A-Z) with allowance for a underscore (_) or dash(-) between logical words. This convention should be adhered to when defining or referencing a metric.

Metric identifiers from the same plugin should have a prefix to
group similar metrics (e.g. `AWS_ELB_LATENCY`). Metric names that are prefixed with `PULSE`
should be considered reserved for TrueSight Pulse’s internal use.

### Display Name
Display name is the primary label used by web user interface to reference a metric
and/or its measurement. The display name appears in the following locations within
the web user interface:

* Headings of graphs in dashboards
* List of items with the _metrics settings_ dialog
* Drop down list when defining an _Alarm_

Each display name should have a common prefix so that similar metrics are grouped together and provides a hint of the system or identity to be monitored (e.g. `APACHE_BYTES_PER_REQUEST`).

### Short Display Name

The short display name is used in cases where using there is limited space to
use the display name as a label. For example the short display name is used as:

* List of items available metrics when editing a dashboard (_Settings_ => _Dashboards_).
* Label when selecting a data point on a dashboard.

The short display name should be limited to 20 characters or less.

### Description
Should be a concise definition that describes the metric. The description should
indicate if the metric is a rate, what are the units of the metric (e.g. x/second),etc.

When building a dashboard using the dashboard editor,
the [tool tip](http://en.wikipedia.org/wiki/Tooltip) associated with each item
in the list of available metrics is the description.

### Default Aggregate

Default aggregate indicates which type of aggregate is displayed in dashboards by default.
The following aggregates are supported:

- _avg_
- _max_
- _min_
- _sum_

### Unit

A metric quantity is described by a unit which is one of the following:

- _bytecount_
- _duration_
- _number_
- _percentage_

### Default Resolution
Default resolution describes how often measurements for this metric will be updated.
This value is used to extend the line on a dashboard to provide better visualization,
instead of drawing single points.

## Defining Metrics

Metric definitions are defined in TrueSight Pulse using either:

1. Web user interface
2. REST APIs
3. Command line utilities.

Details on the use of the REST APIs for metric definition can be found [here](http://premium-documentation.boundary.com/metrics). The remaining methods are described in the next sections.

### Defining Metrics Using the Web User Interface

1. Login into TrueSight Pulse
2. Display the settings dialog by clicking on the _settings icon_ in the menu: ![](../../img/settings_icon.png)
3. Click on _Metrics_ in the left hand side of the dialog which then displays
the _Metrics_ dialog:

![](../../img/metrics_dialog.png)
4. Click on the _Create Metric_ button which displays a form to define a new metric.
Fill out the form as shown here:

![](../../img/create_metric.png)
5. Click on the _Save_ button to create the metric.
6. Click on the _Close_ button to dismiss the dialog.

### Defining Metrics Using Command Line Utilities

1. [Install](http://boundary.github.io/pulse-api-cli/install/) the TrueSight Pulse API CLI.
2. Create the metric using `metric-create`:
```bash
$ metric-create -n PULSE_FOO_METRIC_IN -d "Pulse Foo Metric In" -s "Foo In" -i "Tracks the Pulse Foo Metric" -g AVG -i number -r 1000
{
  "result": {
    "success": true
  }
}
```

### Batch Definition of Metrics Using Command Line Utilities

1. [Install](http://boundary.github.io/pulse-api-cli/install/) the TrueSight Pulse API CLI, if not already installed, and configure according to instructions [here](https://github.com/boundary/boundary-api-cli)
2. Define metrics in a JSON file named `metrics.json`:
```json
{
    "PULSE_METRIC_ONE": {
        "defaultAggregate": "AVG",
        "defaultResolutionMS": 2000,
        "description": "Example metric one for my meter plugin",
        "displayName": "Metric One",
        "displayNameShort": "Metric #1",
        "isDisabled": 0,
        "unit": "number"
    },
    "PULSE_METRIC_TWO": {
        "defaultAggregate": "MAX",
        "defaultResolutionMS": 5000,
        "description": "Example metric two for my meter plugin",
        "displayName": "Metric Two",
        "displayNameShort": "Metric #2",
        "isDisabled": 0,
        "unit": "percent"
    }
    ...
}
```
3. Create the metric definitions using `metric-create-batch` command:

```bash
$ metric-create-batch -f metrics.json
{
  "result": {
    "success": true
  }
}
```
