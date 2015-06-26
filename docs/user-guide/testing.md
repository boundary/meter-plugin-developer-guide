Testing Methods
---------------

This section describes tips on testing your plugins to make them production ready, including:

* Platform Support
* Test Deployment
* Debugging
* Troubleshooting

## Platform Support

These are the tier 1 platforms and versions that the plugins are required to run on to be certified. These represent the minimum number of platforms that a plugin should be tested against before considering a plugin Generally Available (GA).

#### Linux
* Centos 5.10
* Centos 6.5
* Amazon Linux AMI release 2014.03
* Ubuntu 12.04 LTS
* Ubuntu 14.04.1 LTS

#### Windows
* Windows 2012
* Windows 2008R2

## Test Deployment

Plugins are able to be deployed in a sandbox account which allows end to end testing. It is highly recommended that a plugin be end to end tested so to ensure correct operation and deployment of a plugin in a production environment.

### Prerequisites
* Trial or Paid account (Free accounts are not able to use plugins)
* A test meter for the target platform
* Existing GitHub repository with a plugin to be tested
* Boundary CLI tools installed (see [Tools](tools.md))


### Deploying a Plugin for Testing

Deploying a plugin for testing consists of:

1. Exposing the plugin to an account
2. Installing the plugin into the account
3. Deploying to a test meter



### Plugin Debugging



### Plugin Troubleshooting

On the linux platforms

Using `strace`
