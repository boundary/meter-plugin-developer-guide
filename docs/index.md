Boundary Plugin Development Guide
=================================

Boundary offers an API so you can graph any measurable metric in realtime, however, there is a small amount of work involved in getting the metrics you are measuring to Boundary for display. To help solve this problem we introduced plugins.

A plugin is a tiny application that can be written in any language or script which simply reads the metric you are after and reports its value. The plugin is launched using the Plugin Manager which is built in to the meter, so no further installation is required.

Plugins not only make it very easy to add arbitrary metric monitoring to Boundary but because plugins are kept in a central, public, repository, they can be shared by all.

