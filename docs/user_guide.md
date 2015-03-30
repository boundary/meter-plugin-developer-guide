Plugin Development Guidelines
This document describes the development guidelines for creating metric plugins.
Programming Language
Plugins should make all attempts to run python 2.6.6 since this the predominant version that is deployed on *NIX environments by default. Plugin should also make attempts to run on 3.x python as well, in most cases there code constructs that can be used to allow running on both versions.

Source Code Management
All source code for plugins is required to be managed by GitHub. The Boundary Plugin Manager extracts the code from GitHub and installs on the target host. This requires that any repository be publicly accessible. 

Although not require, plugins repositories are typically created in the GitHub Boundary organization with the required public access. This allows contributors to fork the repository and submit pull requests with bug fixes and enhancements.

The final step in productization of a plugin is the addition of the plugin repository as a sub-module in this public repository: https://github.com/graphdat/contrib.

Request for final productization should be submitted to (TBD)
Repository Naming Convention
The naming convention of GitHub repositories is the following:

boundary-plugin-<plugin name>

where plugin name is text the summarizes the name of the system or service for which metrics are being collected. Examples of existing repositories are as follows

boundary-plugin-postgresql - Plugin that collects metrics from a PostgreSQL database instance
boundary-plugin-aws-elb - Plugin that collects metrics via Cloud Watch of EC2’s Elastic Load Balancer’s (ELB)
boundary-plugin-cassandra - Plugin that collects metrics from a Cassandra

Code is submitted to the repositories via the standard Pull Request GitHub mechanism.
Requesting a Repository
Requests for new repository should be sent to (TBD)
Platform Support
These are the major platforms and version that the plugins are required to run on to be certified.
Tier 1 Platforms
These represent the minimum number of platforms that a plugin should be tested against before considering a plugin Generally Available (GA). NOTE: This list was derived by using the 3.X meter deployment data.
Linux
Centos 5.10
Centos 6.5
Amazon Linux AMI release 2014.03
Ubuntu 12.04 LTS
Ubuntu 14.04.1 LTS
Windows
Windows 2012
Windows 2008r2
Plugin Modes

Single versus multiple instances

Logging
Use the Boundary Plugin Facade for logging (To Be Developed). Use a supplied wrapper around the default Python logging library. Currently logging is performed to standard error by any means, but future enhancements to plugin manager in the meter may facilitate better handling of plugin logging. Using the Boundary Plugin Facade for logging would allow plugins to take advantage of the new logging facility by only updating the Python Boundary Plugin Framework Library (BPPF).


Testing
In most testing of the metric plugin will be the largest portion of the development process due to several factors including:

Number of platforms a plugin must be tested against (see Platform Support)
Setup and configuration of the system to be monitored on each of the platforms.
Development of test scripts or procedures to have the system that plugin is monitoring generate all of the metrics that it collects.
Metric Naming Conventions
This describes the conventions used for naming and describing metrics.
Metric Name
The metric name is a global immutable string identifier which is the unique identifier for a metric and its associated metadata which includes:

Display Name
Short Display Name
Description
Unit
Aggregate

All metric names need to be upper case when included in the plugin.json file.
Metric names from the same plugin should have a prefix to group similar metrics (e.g. AWS_ELB_LATENCY
Metric names that are prefixed with BOUNDARY_ should be considered reserved for Boundary’s internal use.
Display Name
The metric display name is the actual text shown in the Alarms, Dashboards, etc.

Specifically the display name is used:
For the label on each graph

The display name should be prefix that identifies the system to be monitored. This is best illustrated by examples:

ELB - Healthy Host Count

where ELB stands for Elastic Load Balancer

or another example

RabbitMQ - Queue Total Messages

The intention of having a prefix is so that like metrics will be grouped together when they list of metrics is sorted. Also to exploit a future search capability in the UI as shown in this mock up which shows an ability to filter by text:



Short Display Name
The short display name is used as a:
In the list of available metrics when editing a dashboard.
Label when selecting a data point on a dashboard.

There should be an associated prefix similar to the display names as mentioned previously.
Description
Should be a concise definition that describes the metric, if the metric is a rate, what are the units of the metric (e.g. x/second),etc.

The description is as:

Tool tip on graph labels (Display Name)
Unit
Describes the quantity being measured:

Count Of Bytes
Percentage
Duration
Number
Aggregate
The default aggregate can be one of the following:

Average
Sum
Maximum
Minimum

Metric Definitions
Each plugin is required to have metrics.json file includes the metric definitions for the plugin
Documentation
This section describes the documentation deliverables,bundled with the plugin, and other artifacts of the development process.
Deliverables
Metric Plugin Cut Sheet
README.md that is included in the GitHub
Description of the metrics (discussed in an earlier section, Metric Naming Conventions)

Documentation Details
Provides additional details and guidance on each of the documentation deliverables.
Metric Plugin Cut Sheet
This document is a summary of the service or application metrics that are sampled and collected by a plugin. It describes at a high level description of the method used to collected, along with descriptions of the metrics to be collected and the internal names to be used within in Boundary Premium. Since the the internal metric names are global having this information up front can avoid name collisions when the metric plugin is deployed.
A check off list of the items that need to be included in a Metric Plugin Cut Sheet:
List of the metrics, their definitions, and internal metric names.
Summary of the means by which these metrics can be obtained from a local host or remotely.
URL of the GitHub repository with all of the artifacts of the development including source code that implements the plugin, testing code, and internal and external documentation (End-User, Development).
TBD
Add a reference to a template that can use to develop a Metric Plugin Cut Sheet.
Format of the Metric Plugin Cut Sheet, should it be a google document or Markdown that is included.
A completed Metric Plugin Cut Sheet that implements a simple plugin and references a live GitHub repository with the required contents.
README.md
This file, which is located in the GitHub repository where the plugin code resides, use is multiple  purpose:
The landing page when visiting the GitHub repository where the plugin code resides
Description that is displayed when adding a plugin to Boundary Premium instance (see below)

The README.md should include the following in this order:

Title of the form: Boundary Plugin <Plugin Name>
Current status of plugin which is one of:
In Development
Awaiting Certification
Boundary Certified
Prerequisites - Lists the requirements to run this plugin on the target host
Metrics - Table that lists the metrics with the plugin. The table columns include: metric name, metric identifier, and description.
Dashboard - List the names of the dashboards that are installed with this plugin.

End-User
This document describes the metrics that are collected by the metric plugin along with the the input fields used to configure the metric plugin. The language and wording as such should contain the minimal amount domain information to get the plugin up and running in a short period of time. At a minimum it should contain a simple walk with appropriate screen shots showing how to configure the metric plugin.
Developer
This document provides a description of the internal workings of the plugin, going into detail how the metrics are collected and potential conditions under which the metric plugin can fail. It should contain troubleshooting information so that support personnel can address the first level.


Fire event when you starting up.  

Ticketing
This section describes the process by which bugs, enhancements requests are to be handled by the plugins.

Options
JIRA (Internal Boundary Ticketing)
GitHub Ticketing




Appendix A - Metric Plugin Manifest Reference
The plugin.json file includes various pieces of metadata required by the plugin. This appendix documents the fields within the JSON document.

The following is an example of sample plugin.json that describes an example plugin that can report on stock market price and volume:

{
    "description": "Collects price and volume of a traded stock",
    "icon" : "ticker.png",
    "command" : "python plugin.py",
    "ignore" : "config",
    "metrics" : [ "BOUNDARY_STOCK_PRICE", "BOUNDARY_STOCK_VOLUME"],
    "dashboards" : [
        {
         "name": "Stocks", "layout": "d-w=1&d-h=2&d-pad=15&d-bg=none&d-g-BOUNDARY_STOCK_PRICE=0-0-1-1&d-g-BOUNDARY_STOCK_VOLUME=0-1-1-1"
        }
    ],
    "postExtract" : "python post-extract.py",
    "paramArray": { "itemTitle": [ "ticker" ], "schemaTitle": "Stock" },
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

A description of each of the JSON objects and their function will be described in kind in the sections below.

description
Provides a summary of the functions of the plugin. When a list of plugins is shown the text of the description shows below the name of the plugin as shown here:







icon
A string with a relative path to an icon in the GitHub repository to be display in any view that lists plugins.
command
A string with a relative path to the command to run to get the metrics from the plugin.
metrics
A string array of the metric identifiers that are created when the plugin is installed. As part of the plugin guidelines these should always be in uppercase with words separated by underscores.



dashboard
An object array with a name and layout fields. The name field is a string represents the text that is displayed as the title for the dashboard. The layout field is a string that contains url obtained by editing the dashboard and then clicking on the clipboard icon, , which is then copied to your clipboard.

postExtract
A string with the relative path in the GitHub repository of a script or command that is executed by the plugin manager after the plugins files have been copied to the target system.

paramArray
An object array with a itemTitle and schemaTitle. The itemTitle is what is displayed to identify multiple configurations


paramSchema
An object array with the following:
title
name
description
type
default
required

Details on each of the fields follow.



title
The title is the label used to describe a plugin configuration. For plugins with multiple configurations it appears in the configuration dialog.
name
Unique string identifier that identifies a plugin configuration parameter. The name is used as the field in the param.json file which is discussed in Appendix B - Metric Plugin Runtime Configuration Reference.
description
Provides details about the plugin configuration parameter. In the configuration dialog the description appears as tooltip when the mouse is held over the input field.
type
Indicated the data type of the configuration field which can one of the following:
array
boolean
enum
password
string

{
            "title": "Protocol",
            "name": "protocol",
            "description": "The protocol of the endpoint",
            "type" : { "enum" : [["HTTP", "http"], ["HTTPS", "https"]]},
            "required": true
        },


{
            "title": "Virtual Hosts",
            "name": "virutalHosts",
            "description": "Include individual VHosts in your graphs",
            "type" : "array",
            "items" : {
                "type" : "string"
            }
        }


default

required

Appendix B - Metric Plugin Runtime Configuration Reference
This appendix documents the format of the runtime configuration provide to a plugin. At runtime the plugin manager (graphdat relay in the old school, and the 3.0 meter in the new school) provides a file, param.json with the configuration data provided by the user via the plugin configuration dialogs. The name, type, title, and mandatory fields are described by the
Metric Plugin Manifest as described in Appendix A - Metric Plugin Manifest Reference


Appendix C - Plugin Testing Score Sheet
This appendix is guide of testing tasks to ensure a quality experience with your metric plugin.

Deployed


Appendix D - Compilation of Useful Plugin Development Tools
jsonlint

Command line tools for validation of JSON. Requires Nodejs
https://www.npmjs.org/package/jsonlint

Internal Tools to be Developed

Validates that all metric definitions in plugin.json are the the account specified.
Generate MarkDown table from metric definitions

