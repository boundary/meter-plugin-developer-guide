Add README
==========

Each meter plugin includes a file named __README.md__ that is displayed in the Plugin Configuration
dialog that provides documentation regarding the plugins requirements, setup instructions, configuration parameters,
metrics, dashboards, and any other information needed for the operation of the meter plugin.

Content that needs to be included in a README is discussed in [Documentation](../reference/documentation.md).

### Adding README.md

Add the _README.md_ file to your repository by the running the following:

```
$ git checkout step6
```

### View Contents Of README.md

```markdown
TrueSight Pulse Tutorial Meter Plugin
=====================================

Meter plugin used in the _Meter Plugin Development Guide_.

### Prerequisites

|     OS    | Linux | Windows | SmartOS | OS X |
|:----------|:-----:|:-------:|:-------:|:----:|
| Supported |   v   |    v    |    v    |  v   |

### Plugin Setup

None

### Plugin Configuration Fields

|Field Name   |Description                             |
|:------------|:---------------------------------------|
|Source       |Source to use for measurements          |
|Interval     |How often to send measurement in seconds|

### Metrics Collected

|Metric Name     |Description                                    |
|:---------------|:----------------------------------------------|
|TUTORIAL\_METRIC|Metric definition for the tutorial meter plugin|

### Dashboards

- Tutorial

### References

None

```

