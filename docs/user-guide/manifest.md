# Meter Plugin Manifest

The `plugin.json` file contains metadata used for describing the meter plugin. Information contained within this manifest is used to:

- Name the plugin and provide help information when browsing the available meter plugins.
- Indicate the command or script to execute which implements the meter plugin.
- Define the required fields used to configure the meter plugin.

### Example Plugin Manifest

Below is a sample `plugin.json` that is bundled with an example meter plugin that reports measurements on a stock(s) market price and volume. The complete meter plugin for this example is located in the GitHub repository [here](https://github.com/boundary/boundary-plugin-ticker).

```
    {
    "description": "Collects price and volume of a traded stock",
    "icon": "ticker.png",
    "command": "python plugin.py",
    "ignore": "config",
    "metrics": [
      "BOUNDARY_STOCK_PRICE",
      "BOUNDARY_STOCK_VOLUME"
    ],
    "dashboards": [
      {
        "name": "Stocks",
        "layout": "d-w=1&d-h=2&d-pad=15&d-bg=none&d-g-BOUNDARY_STOCK_PRICE=0-0-1-1&d-g-BOUNDARY_STOCK_VOLUME=0-1-1-1"
      }
    ],
    "postExtract": "python post-extract.py",
    "paramArray": {
      "itemTitle": [
        "ticker"
      ],
      "schemaTitle": "Stock"
    },
    "paramSchema": [
        {
          "title": "Ticker",
          "name": "ticker",
          "description": "Stock ticker symbol",
          "type": "string",
          "default": "",
          "required": true
        }
      ]
    }
```

### Single versus Multiple Configuration Items

Meter plugins have either a single or multiple configuration items per plugin. A configuration item is an array of JSON objects that define a database connection, REST API endpoint, or entity or system the meter plugin wishes to extract measurements from.

In most cases, it is perferred that a plugin have multiple configurations, so that a single plugin installed on meter can collect measurements from multiple instances of a managed system, such as database system, running on the same host. A multiple configuration meter plugin enables proxy measurement of multiple entities external to the meter and plugin where the meter is unable to run, such as networking equipment.


### JSON Object Reference

A description of each of the JSON objects contain within the `plugin.json` manifest is described in detail in the sections that follow.

#### `command`

A string representing a path to a command or script, along with arguments, to be executed to run the meter plugin. Although a meter plugin may contain other programs and/or scripts, the path and arguments assigned to the `command` field launches the main process responsible for orchestrating the collection of measurements.

The `command` field accepts _macros_ of the form:

```
$(macro_name)
```

which are replaced prior to execution of by fields defined in the `paramSchema` object array described later. Currently there is a single built in value: `pollInterval`. The meter manager also provides at runtime the same macro values in JSON file `param.json` that can be parsed by the meter plugin. Further discussion of the param.json file is discussed in [parameters](parameters.md)

__NOTE:__ Arguments passed within the `command` field are visible in process listings and as such sensivity such as user names and passwords should not be passed via macros.

As mentioned previously in the [meter plugin overview](metrics.md), measurement polling by meter plugins is either by _looping_ or _non-looping_ method. With the previous the preferred method, due to overhead caused by invoking a operating system process.

#### `description`
Provides a brief summary of the meter plugin function. When a list of plugins is shown in the Boundary plugin dialog, the text of the description shows below the name of the plugin as shown here:

![Screenshot](img/plugin-dialog.png)

#### `icon`
A string with a relative path to an icon in the GitHub repository to be display in any view that lists meter plugins. Icon should be a 48x48 pixel in [Portable Network Graphics (PNG) format](http://en.wikipedia.org/wiki/Portable_Network_Graphics)

#### `command_lua`

Invokes the provide string using the Boundary meter's built in [lua]() interpreter as follows:

```
$ boundary-meter <string value of command_lua>
```

#### `ignore`

A string or array of strings that designates a set of files/directories within the plugin directory to ignore when validating. In order to insure the correct version of a plugin is running, the Boundary plugin manager will compare checksums of all plugin files installed to the ones in the repository. If the plugin generates extra files when installing or executing it should list them here otherwise the Boundary plugin manager will attempt to re-install the plugin. Can be a string or an array of strings.

#### `metrics`

A string array of the metric identifiers associated and used by the meter plugin (see [Metrics](metrics.md)) for a complete description of metric identifiers and their definitions). The metric definitions must exist a head of time or an error will ocurr. See [Metrics](metrics.md) for additional details about metric definitions.

#### `dashboard`
An object array with a `name` and `layout` fields which describe a _dashboard_ definition(s) to be installed into an account when the plugin itself is added to an account.

- `name` a string containg text that is displayed as the title for the dashboard which displays in the dashboard drop down menu.
- `layout` a string that contains the dashboard layout. A layout is obtained using dashboard editor dialog, by clicking on the icon ![Screenshot](img/copyclip.png), next to the _Copy layout_ . This copies the layout definition to your clipboard, which can the subsequently assigned to the `layout` field in the dashboard definition.


__Example Dashboard Definition__

```
    "dashboards" : [
        {
          "name": "Plugin Shell",
          "layout": "d-w=3&d-h=2&d-pad=5&d-bg=none&d-g-BOUNDARY_METRIC_TEST=0-0-3-2"
        },
        ...
    ],
```

#### `postExtract`

A string representing a path to a command or script, and arguments, to be run after the plugin contents are extracted to the local file system where the plugins are stored (typical `/etc/boundary/plugins` for Linux/UNIX systems and `Program Files\Boundary\plugins` for Windows).

#### `postExtract_lua`

Same as the `postExtract` except the value of `postExtract_lua` is invoked using the Boundary meter's built in [lua]() interpreter as follows:

```
$ boundary-meter <string value of postExtract_lua>
```

#### `paramArray`

An object array with a `itemTitle` and `schemaTitle`. The `itemTitle` identifies the field in the `paramSchema` that is displayed to identify multiple configuration items.

```
    "paramArray": {
      "itemTitle": [ "name" ],
      "schemaTitle": "Metric Command"
    }
```

##### `paramaSchema`

An object array with the following:
- title
- name
- description
- type
- default
- required

Details on each of the fields follow.

##### `title`

The title is the label used to describe a plugin configuration. For plugins with multiple configurations it appears in the configuration dialog.

##### `name`

Unique string identifier that identifies a plugin configuration parameter.

The name defines a macro of the form: `$(name)` and also defines a field in the param.json file which is discussed in [parameters](parameters.md).

##### `description`

Provides details about the plugin configuration parameter. In the configuration dialog the description appears as a tooltip when the mouse is held over the input field.

##### `type`

Indicated the data type of the configuration field which can one of the following:

- string
- integer
- boolean
- enum
- password
- array

##### `default`

Initial value to populate the given field.

##### `required`

Boolean indicating that value for this field must be specified. Without a value the configuration cannot be saved to the meter plugin.

##### Example Field Definitions

The following is the `paramArray` and `paramSchema` definitions from the example plugin _boundary-plugin-dialog_ which is located in [this](https://github.com/boundary/boundary-plugin-dialog) GitHub repository.

```
...
    "paramArray": { "itemTitle": [ "string" ], "schemaTitle": "Example Dialog Configuration" },
    "paramSchema": [
        {
            "title": "String Type",
            "name": "string",
            "description": "A simple text field. Can have a default value and be required.",
            "type": "string",
            "default": "hello",
            "required": true
        },
        {
            "title" : "Password Type",
            "name" : "password",
            "description" : "A simple text field that obsecures the text.",
            "type" : "password"
        },
        {
            "title": "Boolean Type",
            "name": "boolean",
            "description": "A checkbox field. Can have a default value and be required",
            "type": "boolean",
            "default": false,
            "required": false
	    },
        {
            "title": "Enum Type",
            "name": "enum",
            "description": "A dropdown list of enumerated values. Can have a default and be required",
            "type" : { "enum" : [["Red", "red"], ["Green", "green"], ["Blue","blue"]] },
            "default" : "red",
            "required": true
        },
        {
            "title": "String Array Type",
            "name": "string_array",
            "description": "",
            "type" : "array",
            "items" : { "type" : "string" }
        },
        {
            "title": "Boolean Array Type",
            "name": "array",
            "description": "",
            "type" : "array",
            "items" : { "type" : "boolean" }
        },
        {
            "title": "Enum Array Type",
            "name": "array",
            "description": "",
            "type" : "array",
            "items" : { "type" : "enum" }
        }
    ]
...
```





