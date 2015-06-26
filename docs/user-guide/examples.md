Examples
--------

This section provides a discussion of example plugins created in lua. Although, meter plugins can be created in other languages, lua is considered the lingua franca of meter plugins due to a lua interpreter built into the meter itself. Additionally, the built in lua interperter includes luvit which provides a rich API for integrating and collect metrics from foreign sources using HTTP(S) protocol, log files, etc.

An overview of each of the examples is described below.

## Hello World

The quinessential example program is the _Hello World_ program that is included in nearly every programming language, examples of said programs are listed [here](http://en.wikipedia.org/wiki/List_of_Hello_world_program_examples). This initial examples demonstrates the mechanics of developing and deploying a meter plugin.

[Go To _HelloWorld_](example-hello-world.md)

## Hello World [part deux](http://en.wikipedia.org/wiki/Hot_Shots!_Part_Deux)

This example is a redux of the example Hello World plugin but uses the [Boundary Lua Plugin Framework](framework.md) for its implementation

[Go To _HelloWorld_](example-hello-world2.md)

## Give it a REST

This example shows how to collect measurement information from a RESTful interface using the [Boundary Lua Plugin Framework](framework.md)

## The Meter and Me, and the Plugin makes Three

Demonstrates a plugin that use the meter [JSON RPC](http://en.wikipedia.org/wiki/JSON-RPC) interface to extract measurements collected by the meter into a meter plugin.

## ["Yes Log, all kids love log"](http://nicktoons.nick.com/videos/clip/stimpys-big-day-log-song-1.html)

Plugin that monitors a log (Syslog or other application) and uses regular expressions to parse measurements from the content.