Getting Started
===============

Plugins are open source and are submitted via a pull request to the Boundary github plugin repository. Once a plugin is accepted into the repository it appears in the Plugins tab of the Settings dialog. After a plugin is installed into your account you will need to go to Relays tab in order to install plugin instances on corresponding host(s).

Plugin Development Tasks
------------------------

Creation of meter plugin consists of the following steps:

1. Creating a public GitHub repository
2. Develop and test a script that polls the entity or system to be monitored and outpus metric values
3. Design an `icon.png` to be displayed with your plugin
4. Define a  `plugin.json` file that describes your meter plugin

## Example Plugin

To get started we are going to walk through the contents of an existing plugin and deploy a meter plugin into a Boundary account.

The steps are as follows
1. Make a copy of an existing plugin repository which contains a complete plugin
2. Stage the plugin into a Boundary account
3. Add the plugin into a Boundary account.
4. View metric values on Dashboard

Before proceeding with the steps outlined above the following prerequisites must be satisfied:
1. [GitHub](https://github.com/) account
2. Command line installation of Git, [download]()
2. Administrative login for a Boundary account. You can create a free account [here]()
3. A meter deployed on a Linux system.

#### Copying an Existing Meter Plugin Repository


#### Stage Plugin Into Boundary Account


#### Add Plugin Into a Boundary Account


#### Deploy the Plugin into a Meter


### Observe Metric Values on Dashboard


