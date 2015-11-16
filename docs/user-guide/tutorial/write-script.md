Write Meter Plugin Script
=========================

The meter plugin script is responsible for collect measurements and outputing the measurement
values to standard out according to the format defined in [Measurements](../reference/measurements.md).

For this tutorial we are using the Python scripting language and meter plugin scripts is
in a file named ___init.py___.

### Adding Python Script init.json

Add the _init.py_ file to your repository by the running the following:

```
$ git checkout step3
```

### View Contents Of init.py

```python
$ cat init.py
#!/usr/bin/env python

# Required for parsing JSON
import json
# Use to generate random measurement values
import random
# Generate current timestamp values
import time

# Open the param.json file and parse JSON.
with open("param.json") as f:
    parameters = json.load(f)

# Extract the plugin configuration
source = parameters["source"]
interval = parameters["interval"]

# Metric identifier
metric = 'TUTORIAL_METRIC'

# Run in a continuous loop sending measurements to standard out
while True:
    # Get the current timestamp
    timestamp = int(time.time())

    # Generate a random value
    value = random.randrange(0, 99)

    # Format measurement string and write to standard out
    print("{0}, {1}, {2}, {3}".format(metric, source, value, timestamp))

    # Wait for the next interval
    time.sleep(interval)

```

