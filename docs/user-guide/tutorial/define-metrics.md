Define Metrics
==============

The tutorial meter plugin has but a single metric that needs to be defined.
Meter plugin metrics are defined in a file name ___metrics.json___.

Details on the contents of metrics.json is described in [Metrics](../reference/metrics.md)

### Adding metrics.json

Add the _metrics.json_ file to your repository by the running the following:

```
$ git checkout step1
```

### View Contents Of metrics.json

```json
$ cat metrics.json
{
    "TUTORIAL_METRIC": {
        "defaultAggregate": "AVG",
        "defaultResolutionMS": 1000,
        "description": "Metric definition for the tutorial meter plugin",
        "displayName": "Tutorial Metric",
        "displayNameShort": "Tut. Metric",
        "isDisabled": false,
        "unit": "number"
    }
}
```

### Add Metrics To Pulse Account

Metric definitions can be added to your account in several ways (see [Metrics](../reference/metrics.md))
in this tutorial we use the [TrueSight Pulse CLIs](http://boundary.github.io/pulse-api-cli/).

To add the metric definitions we need to first, obtain your TrueSight Pulse account e-mail and API token from
Settings => Account. Next we run the following command:

```
metric-create-batch -e <your-email@example.com> -t <your API Token> -f metrics.json
```
