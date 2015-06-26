# Meter Plugin Development Overview

A Boundary Meter Plugin is a small application written in [lua](https://en.wikipedia.org/wiki/Lua_(programming_language)) that regularly reports arbitrary metrics that may optionally include one or more dashboards.

## Anatomy of a Meter Plugin

The contents of a meter plugin are housed in a GitHub repository so that the can readily versioned and shared with the Boundary service (optional). All plugins are open source so the repository is required to be made public (note: github supports public repositories free of charge).

A typically plugin consists of:

__init.lua__

User created lua program that continuously loops and collects metric values and then sends to the _Meter Plugin Manager_ via standard out.

__plugin.json__

Meter plugin manifest that contains metadata about the meter plugin: command to run to start the plugin, inputs to the plugin, metric values created by the plugin, dashboard definitions, as a partial list.

__metrics.json__

Meter plugin manifest that contains metadata about the meter plugin: command to run to start the plugin, inputs to the plugin, metric values created by the plugin, dashboard definitions, as a partial list.

__param.json__

Created by the _Meter Plugin Manager_ at runtime to provide specific configuration to the plugin.

__README.md__

Documentation that describes that platforms supported by the plugin, along with any dependent software and/or configuration required for the plugin to run.

__icon.png__

Path to an icon to display next to the plugin when browsing plugins in the Boundary settings dialog.

__Other Files__

Any other files, configuration, or specific libraries required by your meter plugin to run.

Details on the plugin contents will be discussed in greater detail later in this guide.

## Measurement Sampling

There are two possible ways to perform polling within meter plugin:

__Looping__
a technique whereby the process that does the polling does not exit by itself but instead polls metrics in a loop with a builtin delay between polls (minimum of 1 second). This technique is preferred as it removes any extra overhead incurred by stopping/starting a process for every poll.

__Non-looping__
the simplest technique whereby the plugin performs a single poll of metrics. The Boundary relay will launch the plugin repeatedly on the polling interval to gather metrics. While this method continues to be supported by the meter manager, it is highly recommended that all new plugins be developed using the __looping__ polling method.

## Tools

Boundary provides other open source tools that assist in the development of meter plugins see [Tools](tools.md)

