Overview
========

Background
Boundary offers an API so you can graph any measurable metric in realtime, however, there is a small amount of work involved in getting the metrics you are measuring to Boundary for display. To help solve this problem we introduced plugins.

A plugin is a tiny application that can be written in any language or script which simply reads the metric you are after and reports its value. The plugin is launched using the Plugin Manager which is built in to the meter, so no further installation is required.

Plugins not only make it very easy to add arbitrary metric monitoring to Boundary but because plugins are kept in a central, public, repository, they can be shared by all.

## Preparation

Before starting on this tutorial it will be assumed that you have the prerequistes.  See [Prerequisites](../prerequisites.md) for information on tools and other items required to start this tutorial.


## High-Level Overview

1. Metrics Definitions



SCM tool - Github usually works in conjunction with a source code management tool installed on your system. For the purposes of this step-by-step we will assume this tool is git but the commands are so simple that you should not have any problem translating these steps for whichever tool you are using.
Step 1 - Define your Metric(s)

The first step in creating any plugin is deciding what metrics you want to track. In Boundary, the idea is that when a type of metric is created, it is given a universal name and is typically associated with a single plugin.

For the purposes of this step-by-step let’s create a plugin that will track CPU usage of individual CPU cores. The default CPU metric that the Boundary Agent collects is only the system wide average CPU so with this plugin we can now dive into individual CPU core usage information.

Creating the metric is simple:

Log into Boundary
Select Settings
Select Metrics
Select Create Metric


On this screen you are prompted to enter some information. Now for a quick word on metic identifiers. Metric identifiers must be globally unique so for the purpose of this step-by-step you will need to come up with a unique metric identifier. Try just appending your user name to CPU_CORE (ex: CPU_CORE_BOB99). If the name exists you will be told and you can change it.

Go ahead and enter the following:

Name: Per core CPU utilization
Short name: CPU Core
Identifier: CPU_CORE_… (the name you created above)
Description: Per core CPU utilization
Unit: Percentage
Default Aggregate: Average
Click Save and your new metric should show up in the list.
Note: A plugin can provide several metrics if desired

Step 2 - Create the plugin

Now the easy part, creating the actual plugin. As noted above all plugins are simply Github repositories so to start off we need to create a new repository. Log in to Github and click on New Repository

On the next screen you are asked for some information. Enter the following:

Repository name: boundary-plugin-cpu-core
Public: Yes
Initialize this repository with a README:
Add .gitignore: Node
Add a license: Apache v2 License
Now click Create repository.

At this point we have a new repository and Github has been kind enough to initialize it with some files. Let’s clone the repository locally. The easiest way to do this is to first copy the github URL to the clipboard by clicking the clipboard icon on right side of your new repository page.

Note: We have chosen SSH for this step-by-step

Now we just use git from the command line to bring it down:


$ git clone git@github.com:<your github username>/graphdat-plugin-cpu-core.git
Go into the folder..


$ cd graphdat-plugin-cpu-core
..and create a new file called index.js. In this file paste the following code:

https://gist.githubusercontent.com/pdiemert/6979264/raw/gistfile1.js

For convenience, here is a copy/paste:


var _os = require('os');
var _source = _os.hostname();
var _interval = parseInt(process.argv[1]) || 1000;
var _last; function poll()
{
   var cpus = _os.cpus();
   for(var idx = 0; idx < cpus.length; idx++)
   {
       var e = cpus[idx];
       e.total = 0;
       for(var t in e.times)
           e.total += e.times[t];
   }

   if (_last)
       {
           for(var idx = 0; idx < cpus.length; idx++)
           {
               var e = cpus[idx];
               var l = _last[idx];
               var user = (e.times.user - l.times.user) /
                          (e.total - l.total);

               console.log('CPU_CORE %d %s-%d', user, _source, idx + 1);
           }
       }
       _last = cpus;
       setTimeout(poll, _interval);
   }

poll();
In the code above we used CPU_CORE as the metric name. You should replace this with the metric name you created from above.

Note: Although not applicable in this step-by-step, you may choose to pass configuration information to your plugin for testing purposes. To do this, simply create a file called param.json in this directory that contains a JSON object with the parameters/value pairs you require. During normal operation the Meter will overwrite this file with the settings that are chosen in the Settings / Meters / Plugins screen. See the section on paramSchema in the plugin documentation on how to define configuration parameters.

Now give your plugin a try from the command line..


$ node index.js
Now, assuming all is working up to this point, you should now be seeing some output of your CPU core percentages, reported once a second. That is all the coding you will need to do for this plugin! Press CTRL+C to stop the plugin.

Next, we need to create a description of this plugin. Create another file in the same directory called plugin.json. In this file paste the following:

{
 "description" : "Provides per core CPU utilization",
 "command" : "node index.js $(pollInterval)",
 "metrics" : ["CPU_CORE"]
}
As before, you should replace CPU_CORE with the name of your metric.

That’s it! You have created a minimal plugin. Before we can deploy it make sure to check it into Github:

******************************************************

git add .
git commit -m “added source files”
git push

******************************************************

Step 3 - Testing the deployment

Before submitting your plugin to Boundary for inclusion in the list of available plugins you will want to first test installing the plugin into your own account. At the command line:

******************************************************

$ curl https://premium-api.boundary.com/v1/plugins/private/<plugin name>/<your github username>/<public plugin folder> -X PUT -u <your email>:<your API key>

 

******************************************************

You will now see the plugin listed when browsing all available plugins from Settings / Plugins / Get Plugins:

******************************************************



******************************************************

Click "Install" to add this plugin to your account. Next you will need to have installed the Boundary Meter on the machine you wish to monitor. The Meter will act as a Plugin Manager and communicate the measurements back to Boundary. If you need help installing the Meter these articles can help

You should now be able to see the Meter in your Settings / Meter tab. Click on the Meter to see the plugins it is running. Next click to add the cpu-core plugin:

******************************************************



******************************************************

Once you select the plugin you will be taken to the plugin configuration screen. We don’t need to change any settings so just click Save. As soon as you save the plugin configuration you will next be shown the Meter console. If we wait a few moments we will see the Meter install the Plugin:

******************************************************



******************************************************

 

The plugin is now running! For this step-by-step we have chosen not to add a new dashboard, instead, we'll add the metric graph to our dashboard using the dashboard editor.

Open the dashboard editor, it's the pencil icon in the main menu
Notice that in the toolbox we can see our new metric
Drag and drop this metric onto the dashboard and click Save
Done. On your dashboard you should now be seeing the per-core CPU performance being graphed!

If you were building your own plugin you’d probably be making further changes to the plugin before release. You can simply repeat the steps above (from the point of pushing your changes to github) and you will notice an ‘Apply update’ link next to the plugin from the Settings / Meters / (Meter) tab.

Step 4 - Submit to Boundary

When you are happy with your plugin and are ready to submit it to Boundary for inclusion in the public repository just follow the steps outlined in the plugin documentation to create a Github pull request. Once submitted, we'll review your plugin quickly and soon everyone will be able to enjoy your shiny new Boundary plugin!
