Tracing Measurement Flow
========================

We use the voltage meter analogy, testing for voltage along a circuit, to similiarly trace the flow of a measurement from the meter plugin to the TrueSight Pulse cloud.

__NOTE:__ Measurement flow tracing techniques described here are currently only applicable to UNIX/Linux environments where system tools exist that provide the ability to trace the measurement flow.

## Measurement Pathway

The pathway for measurements sent to TrueSight Pulse are:

_Click on the topical link for details_

1. [Meter Plugin Sends A Measurement]() - Meter plugin sends measurements to standard output via [protocol](measurements.md). Runtime observation of the meter plugin sending measurements is described in []().

2. [Plugin Manager Receives A Measurement]() - Plugin Manager (___pluginmgr___) reads the standard out from the meter plugin. Receipt of the measurement from a meter plugin is describe in []()

3. [Plugin Manager Sends Measurement]() - Plugin Manager writes the measurement to the meter via the Meter(___boundary-meter___) [JSON RPC](https://en.wikipedia.org/wiki/JSON-RPC) channel

4. [Meter Receives A Measurement]() - Meter receives an JSON RPC call sent by the Plugin Manager.

5. [Meter Sends A Measurement]() - Meter sends the measurement to TrueSight Pulse via an HTTPS Rest call.



