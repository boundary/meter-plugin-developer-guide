Deploying Meter Plugins
=======================

Once the contents of the meter plugin have been defined we can deploy the meter plugin into our account.

To add the newly created meter plugin once again we will use the
[TrueSight Pulse CLIs](http://boundary.github.io/pulse-api-cli/).

## Adding the Tutorial Meter Plugin To Your Account

To run the command to add the plugin we must have your TrueSight Pulse account e-mail and API token from
Settings => Account. Additionally the name of your GitHub account is required. We then run the following
command to add the plugin to your account.

```
$ plugin-add -e <email@example.com> -t <API Token> -n tutorial -o <GitHub User name> -r <repository name>
```

## Installing the Plugin

Make the plugin active in your account by running the following command:

```
$ plugin-install -e <email@example.com> -t <API Token> -n tutorial
```








