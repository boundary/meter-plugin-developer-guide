TrueSight Pulse Meter Plugin Development Guide
----------------------------------------------
Documentation on how to develop and deploy TrueSight Pulse meter plugins.

The latest published version of the TrueSight Meter Plugin Developer Guide is located at [http://boundary.github.io/meter-plugin-developer-guide](http://boundary.github.io/meter-plugin-developer-guide)


## Contributing To The Documentation

You an contrubute TrueSight Plugin Development Guide by cloning the respository, installing the required tool set, modifing/updating pages, and then submit a pull request.

### Prerequisites

- Git version 1.7.x or later
- Python 2.7.10 or later, Python 3.3 or later
- Python virtual environment package 13.1.2 or later
- Familiarity with [Markdown](http://daringfireball.net/)

### Fork and Clone the GitHub Repository

1. Visit http://github.com/boundary/plugin-development-guide
2. Fork the GitHub repository
```bash
$ git clone <url to your forked repository>
```

### Install Python Virtual Environment

It is highly recommended that you use the Python virtualenv package to create an alternative python installation and then install additional packages into this alternate python environment. Python can be an integral part of the operating system and installing packages in a separate python environment prevents disturbing the global installation by upgrading to newer packages that may be required by the packages needed to modify and update the TrueSight Pulse Meter Plugin Development Guide

```bash
$ cd <path to clone GitHub repository>
$ virtualenv python
New python executable in /Users/davidg/python/bin/python
Installing setuptools, pip...done.
```

### Activate the new python environment
```bash
$ cd <path to cloned GitHub repository>
$ source python/bin/activate
```

### Install Required Packages
```bash
$ pip install -r requirements.txt
```

## Previewing Web Pages

1. Generate the pages from markdown source
```bash
$ mkdocs --clean build
```
2. Server the pages:
```bash
$ mkdocs serve
```
3. View the web pages with your browser

## Deploying Guide to GitHub Pages

To deploy to GitHub Pages in your own repository run the following:

```bash
$ mkdocs gh-deploy

```



