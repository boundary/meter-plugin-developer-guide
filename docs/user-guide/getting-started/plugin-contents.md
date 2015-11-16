Meter Plugin Contents
=====================

A meter plugin consists of the following artifacts in a (GitHub)[github.md] repository:

- plugin.json
- metrics.json
- README.md
- icon.png
- collection script or program
- param.json

### plugin.json

Meter plugin manifest that contains metadata and configuration information about the plugin. See [Manifest](../reference/manifest.md) for details.

### metrics.json

Metric definitions used by the meter plugin. Details on the contents of the `meterics.json` How to configure plugin metrics  are described in [Metrics](../reference/metrics.md)

### README.md

Contains a description and configuration information about the meter plugin. Recommendations on what to include in the read me is in [Documentation](../reference/documentation.md).

### icon.png

Icon that is used by Pulse Web Interface to graphically represent a meter plugin in the user interface. See[Manifest](../reference/manifest.md#icon).

### script or program

Script or program that is responsible for collecting measurements from a service or application and then sends to standard out in the [Measurement](../reference/measurements.md) format.

### param.json

Runtime configuration provided by the plugin manager to meter plugin.




