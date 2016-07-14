
# [<img src=".bluebeluga.png" height="100" width="200" style="border-radius: 50%;" alt="@fancyremarker" />](https://github.com/blue-beluga/docker-ruby) bluebeluga/ruby

[![Circle CI](http://circle.bluebeluga.io/gh/blue-beluga/docker-ruby.svg?style=svg)](http://circle.bluebeluga.io/gh/blue-beluga/docker-ruby)

The Ruby programming language, on Docker.

## Installation and Usage

```
docker pull bluebeluga/ruby
docker run bluebeluga/ruby [options]
```

## Available Tags

* `latest`: Currently 2.3
* `2.3`:
* `2.2`:
* `2.1`:

## Tests

Tests are run as part of the `Makefile` build process. To execute them run the following command:

```
make test
```

## Deployment

To push the Docker image to the registry, run the following command:

```
make push
```
