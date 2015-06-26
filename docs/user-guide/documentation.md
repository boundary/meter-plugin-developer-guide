Documentation
-------------

This section describes the required documentation to provide with each plugin. The principal documentation is provided in a `README.md` in the top-level directory of the GitHub repository. 

## Requirements Elements within README.md

## Nec aliud mihi suem fronte ensem hinc

The contents of the README.md are displayed within the Boundary Settings => Plugin dialog


Lorem markdownum malis arbusta *maneat*; ut et hinc turribus, tenebat montes
**ius viscera amans**, obstantia. **Pars intremuit** mihi. Surgit diro membris.
Revertar erat gurgite animosa, at ignoto et dato.

## `README.md` Example

The following

```
Boundary Meter Plugin
-------------------------

Collects metrics from a memcached instance. See video [walkthrough](https://help.boundary.com/hc/articles/201816101).

### Prerequisites

|     OS    | Linux | Windows | SmartOS | OS X |
|:----------|:-----:|:-------:|:-------:|:----:|
| Supported |   v   |    v    |    v    |  v   |

|  Runtime | node.js | Python | Java |
|:---------|:-------:|:------:|:----:|
| Required |    +    |        |      |

- [How to install node.js?](https://help.boundary.com/hc/articles/202360701)

### Plugin Setup
None

#### Plugin Configuration Fields

|Field Name|Description                                                |
|:---------|:----------------------------------------------------------|
|Source    |The source to display in the legend for the MEMCACHED data.|
|Port      |The MEMCACHED port.                                        |
|Host      |The MEMCACHED hostname.                                    |

### Metrics Collected
|Metric Name          |Description                       |
|:--------------------|:---------------------------------|
|Memcached Allocated  |Percent of available memory used  |
|Memcached Connections|Number of current connections     |
|Memcached Hits       |Number of cache hits              |
|Memcached Misses     |Number of cache misses            |
|Memcached Items      |Total number of items in cache    |
|Memcached Requests   |Number of requests                |
|Memcached Network In |Number of bytes read from network |
|Memcached Network Out|Number of bytes written to network|
```