# Meter Plugin Development Overview

A Boundary Meter Plugin is a small application written in any language that regularly reports arbitrary metrics that may optionally include one or more dashboards.


## Anatomy of a Meter Plugin

The contents of a meter plugin are housed in a GitHub repository so that the can readily versioned and shared with the Boundary service (optional). All plugins are open source so the repository is required to be made public (note: github supports public repositories free of charge).

A typical plugin consists of:

**README.md**
Documentation that describes that platforms supported by the plugin, along with any dependent software and/or configuration required for the plugin to run.

**plugin.json**
Meter plugin manifest that contains metadata about the meter plugin: command to run to start the plugin, inputs to the plugin, metric values created by the plugin, dashboard definitions, as a partial list.

** icon.png **
Path to an icon to display next to the plugin when browsing plugins in the Boundary settings dialog.

**Your Program or Script**
User created program or script that collects metric values on regular basis and outputs the values to standard out.

**Other Files**
Any other files required by your meter plugin to run.

Details on the plugin contents will be discussed in greater detail later in this guide.

## Programming Languages

Meter Plugins can be created in any programming or scripting language that can write output to standard out. Boundary's meter version 4.0 or later includes a [lua](http://en.wikipedia.org/wiki/Lua_(programming_language)) interpreter which eliminates the need for installing NodeJS, Python, or other interpreter your plugin depends upon.

## Tools

Boundary provides other open source tools that assist in the development of meter plugins see [Tools](tools.md)

