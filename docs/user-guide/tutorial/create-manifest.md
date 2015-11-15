Create Meter Plugin Manifest
============================

The meter plugin manifest defines metadata about the plugin configuration such configuration
parameters and the script to run to start the plugin. The Meter plugin manifest is
defined in a file named ___plugin.json___. Details on the contents of plugin.json is
described in [Manifest](../reference/manifest.md)

### Adding plugin.json

Add the _plugin.json_ file to your repository by the running the following:

```
$ git checkout step2
```

### View Contents Of plugin.json

```json
$ cat plugin.json
{
   "name": "Tutorial Meter Plugin",
   "version": "1.0.0",
   "meterVersionRequired": "4.2.0-611",
   "unsupportedPlatforms": [],
   "tags" : "tutorial"
   "description": "Meter Plugin Tutorial",
   "icon": "true-site.png",
   "command": "python init.py",
   "postExtract": "",
   "metrics": [
       "TUTORIAL_METRIC"
    ],
   "dashboards": [
      {
        "name": "Tutorial",
        "layout": "d-w=1&d-h=1&d-pad=5&d-light=1&d-bg=none&d-g-TUTORIAL_METRIC=0-0-1-1"
      }
    ],
   "paramSchema": [
     {
       "title": "Source",
       "name": "source",
       "description": "Source to use for measurements",
       "type": "string",
       "default": "Tutorial",
       "required": true
     },
     {
       "title": "Interval",
       "name": "interval",
       "description": "How often to send measurement in seconds",
       "type": "int",
       "default": "5",
       "required": true
     }
   ]
}
```

