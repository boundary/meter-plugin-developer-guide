# Getting Started

This page will provide an introduction to meter plugin development by outlining the development
tasks required to create a meter plugin. Next you will be walked through an existing plugin and
its contents and deploy the meter plugin into your TrueSight Pulse account.

Overview
========

TrueSight Pulse offers an API so you can graph any measurable metric in realtime, however, there is a small amount of work involved in getting the metrics you are measuring to Boundary for display. To help solve this problem we introduced plugins.

A plugin is a tiny application that can be written in any language or script which simply reads the metric you are after and reports its value. The plugin is launched using the Plugin Manager which is built in to the meter, so no further installation is required.

Plugins not only make it very easy to add arbitrary metric monitoring to Boundary but because plugins are kept in a central, public, repository, they can be shared by all.

## Meter Plugin Development Tasks

1. Identify the metrics to be collected
2. Determine how the metrics are collected
3. Create the Meter Plugin
4. Deploy and Test
5. Submit for Inclusion in Product (optional)




