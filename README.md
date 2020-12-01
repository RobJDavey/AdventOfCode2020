# Advent of Code 2020

![Swift Version](https://img.shields.io/badge/swift-5.3-orange?logo=swift)
![Swift Version](https://img.shields.io/badge/macOS-supported-green?logo=apple)
![Swift Version](https://img.shields.io/badge/linux-supported-green?logo=linux)

Puzzle solutions to [Advent of Code 2020](https://adventofcode.com/2020) by [@RobJDavey](https://github.com/RobJDavey).

## Docker

[`robjdavey/advent-of-code-2020`](https://hub.docker.com/r/robjdavey/advent-of-code-2020)
![Docker Pulls](https://img.shields.io/docker/pulls/robjdavey/advent-of-code-2020?logo=docker&label=pulls)

### Tags

* [`latest`](https://github.com/RobJDavey/AdventOfCode2020/blob/master/Dockerfile)
![Image Size](https://img.shields.io/docker/image-size/robjdavey/advent-of-code-2020?logo=ubuntu&label=ubuntu%2018.04)

### Examples

#### Simple example

``` shell
docker run --rm robjdavey/advent-of-code-2020 day1
```

This will run the `day1` code with my original input.

#### Run using a custom file input

``` shell
docker run --rm \
    -v <host-path>/input.txt:/data/input.txt:ro \
    robjdavey/advent-of-code-2020 day1 /data/input.txt
```

This will run the `day1` code passing `/data/input.txt` as the input file.

#### Viewing additional parameters

``` shell
docker run --rm robjdavey/advent-of-code-2020 day1 --help
```

Some days also have additional parameters, for example on `day1` it is possible
to use a value other than `2020` as your target.

The output from the command above will be:

``` text
OVERVIEW: Day 1: Report Repair

USAGE: aoc2020 day1 [<input>] [<target>]

ARGUMENTS:
  <input>                 The input to use
  <target>                The target amount (default: 2020)

OPTIONS:
  --version               Show the version.
  -h, --help              Show help information.
```
