Meter Plugin Protocol
=====================

Meter plugins can be programmed using any language that can write to standard out.

Two types of information are interpreted by the plugin manager are:

1. Measurements
2. Events

## Measurements

Time series data collected from a service, application, or managed object. Details of the format are explained in [Measurements](measurements.md).

## Events

Notification describing informational or error conditions about the service, application, managed object, or the meter plugin itself. A description of the format and fields that are supported are described in [Events](events.md).







