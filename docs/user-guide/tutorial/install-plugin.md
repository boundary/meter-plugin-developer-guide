Deploying A Meter Plugin
=========================

Once the contents of the meter plugin have been defined, we can deploy
the meter plugin into our account.

To add the meter plugin to our account once again we will use the
[TrueSight Pulse CLIs](http://boundary.github.io/pulse-api-cli/).

### Adding the Meter Plugin To Your Account

To run the command to add the plugin we must have your TrueSight Pulse account
e-mail and API token from Settings => Account. Additionally the name of your
GitHub account is required. We then run the following command to add the plugin
to your account.

```
$ plugin-add -e <email@example.com> -t <API Token> -n tutorial -o <GitHub User name> -r meter-plugin-tutorial
```

### Installing the Meter Plugin

Make the plugin active in your account by running the following command:

```
$ plugin-install -e <email@example.com> -t <API Token> -n tutorial
```

### Verify the Meter Plugin is Installed

1. Login into your TrueSite Pulse Account
2. Navigate to Settings => Plugins
3. Scroll the list unit you see a plugin with the name _tutorial_.


For additional details regarding deploying meter plugins see
[Deploying](../reference/deploying.md)




