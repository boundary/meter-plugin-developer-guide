Add Configuration
=================

When the meter plugin is deployed, the Plugin Manager provides plugin configuration information that
was defined in the Plugin Configuration dialog in a file named ___param.json___. We add a
param.json file so we can test the plugin from the command line.

Details on the contents of param.json is described in [Parameters](../reference/parameters.md)

### Adding metrics.json

Add the _param.json_ file to your repository by the running the following:

```
$ git checkout step4
```

### View Contents Of param.json

```json
$ cat param.json
{
  "source": "MeterPluginTutorial",
  "interval": 10
}
```
