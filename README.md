# docker-selenium-standalone-server

[![Build Status](https://travis-ci.org/UKHomeOffice/docker-selenium-standalone-server.svg?branch=master)](https://travis-ci.org/UKHomeOffice/docker-selenium-standalone-server)


[![Build Status](https://drone.acp.homeoffice.gov.uk/api/badges/UKHomeOffice/docker-selenium-standalone-server/status.svg)](https://drone.acp.homeoffice.gov.uk/UKHomeOffice/docker-selenium-standalone-server)

Docker container containing Selenium Server

> Selenium automates browsers. That's it! What you do with that power is entirely up to you.
> Primarily, it is for automating web applications for testing purposes, but is certainly not
> limited to just that. Boring web-based administration tasks can (and should!) also be automated as
> well.

## Getting Started

These instructions will cover usage information and for the docker container

### Prerequisities


In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Usage

#### Container Parameters

Parameters passed to the container will be passed onto Selenium Server.

```shell
docker run \
       quay.io/ukhomeofficedigital/selenium-standalone-server:v0.1.2 \
       -your --param=eters
```

Passing no parameters will start Selenium Server

```shell
docker run \
       quay.io/ukhomeofficedigital/selenium-standalone-server:v0.1.2
```

You can also run arbitrary stuff

```shell
docker run \
       quay.io/ukhomeofficedigital/selenium-standalone-server:v0.1.2 \
       bash
```

### Exposes

* `4444` Selenium Server

## Kubernetes

For example Kubernetes files see [/kb8](/kb8)

## Built With

* Chrome Stable
* Firefox
* Selenium Chrome Driver
* Selenium Server Standalone

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the
[tags on this repository][tags].

[tags]: https://github.com/UKHomeOffice/docker-selenium-standalone-server/tags

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors][contrib] who participated in this project.

[contrib]: https://github.com/UKHomeOffice/docker-selenium-standalone-server/contributors

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Lots of this code was stolen from the
  [official Selenium container](https://github.com/SeleniumHQ/docker-selenium).
