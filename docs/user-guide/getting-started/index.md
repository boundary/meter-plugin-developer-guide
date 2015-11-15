# Getting Started

This page will provide an introduction to meter plugin development by outlining the development tasks to create a custom plugin. Next you will be walked through an existing plugin and its contents and deploy the meter plugin into your Boundary account.

## Development Tasks High Level Overview

These steps
1. Identify the metrics to be collected
2. Determine how the metrics are collected
3. Create the Meter Plugin
4. Deploy and Test
6. Submit for Inclusion in Product (optional)

## Plugin Development Tasks

Development of meter plugin consists of the following tasks:

1. Create a public [GitHub](https://github.com/) repository.
2. Develop a script that polls the entity or system to be monitored and outputs metric values.
3. Define the metrics to be used by the plugin in `metrics.json`.
4. Define the dashboards that will display the measurements from the plugin.
5. Design an `icon.png` to be displayed with your plugin.
6. Define a  `plugin.json` file that describes your meter plugin.
7. Write a README.md file using the perscribed template.
8. Commit all of the plugin content and push to your public GitHub repository.
9. Stage your meter plugin into your account.
10. Deploy the meter plugin into a meter installed on a server.
11. View metric collection on a Boundary dashboard

## Example Meter Plugin

To get started we are going to walk through the contents of an existing plugin and deploy a meter plugin into a Boundary account. This will short cut the number of development tasks outlined earlier so you can gain some initial experience when developing your custom meter plugin. The example meter plugin [boundary-plugin-ticker](https://github.com/boundary/boundary-plugin-ticker) collects stock price and volume from the user configured [ticker symbol](http://en.wikipedia.org/wiki/Ticker_symbol).

The steps to run the meter

1. Make a copy of an existing plugin repository which contains a complete plugin
2. Stage the plugin into a Boundary account
3. Add the plugin into a Boundary account.
4. Add the plugin to a meter
5. View metric values on Dashboard

Before proceeding with the steps outlined above the following prerequisites must be satisfied:

1. [GitHub](https://github.com/) account
2. Command line installation of Git, [download]()
2. Administrative login for a Boundary account. You can create a free account [here]()
3. A meter deployed on a Linux system.

#### Copying an Existing Meter Plugin Repository
To use an existing plugin we need to clone the existing plugin repository into your user/organization.

1. Open a web browser and navigate



#### Stage Plugin Into Boundary Account


#### Add Plugin Into a Boundary Account


#### Deploy the Plugin into a Meter


### Observe Metric Values on Dashboard


