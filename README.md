docker-riak-benchmarking
==================

This is a set of Docker images and scripts to allow easy benchmarking of the Riak and other applications that depend on Riak

### Setup

##### Download the project

```
https://github.com/drewkerrigan/docker-riak-benchmarking
cd docker-riak-benchmarking
```

##### Download the Riak and Basho Bench images

```
make pull-docker-riak
# You can also test Riak 2.0 pre-release with: make pull-docker-riak2.0
make pull-docker-basho-bench
```

##### Start the Vagrant VM

```
make up
```

#### Build the Docker Images

```
make build
```

or

```
make build-docker-riak
make build-docker-basho-bench
```

### Creating Test Configurations

Use the examples at [https://github.com/basho/basho_bench/tree/master/examples](https://github.com/basho/basho_bench/tree/master/examples) to create your desired Basho Bench tests. Place your basho_bench configuration files in the `images/docker-basho-bench/files/config/` directory. For example:

`images/docker-basho-bench/files/config/preload.config`:

```
{mode, max}.
{duration, 1}.
{concurrent, 1}.
{driver, basho_bench_driver_http_raw}.
{key_generator, {partitioned_sequential_int, 50000}}.
{value_generator, {fixed_bin, 10000}}.
{http_raw_ips, ["127.0.0.1"]}.
{http_raw_port, 8098}.
{operations, [{insert, 1}]}.
```

`images/docker-basho-bench/files/config/http10read1write.config`:

```
{mode, max}.
{duration, 1}.
{concurrent, 1}.
{driver, basho_bench_driver_http_raw}.
{key_generator, {uniform_int, 50000}}.
{value_generator, {fixed_bin, 10000}}.
{http_raw_ips, ["127.0.0.1"]}.
{http_raw_port, 8098}.
{operations, [{get, 1},{insert, 1}]}.
```

### Running Tests

```
make start
```

or

```
make start-docker-riak
make start-docker-basho-bench TESTS="preload.config http10read1write.config"
```

The `start-basho-bench` container continues to run after the test is complete because it serves an html report via a python webserver. The location should be noted in the output of the test, but can also be found with the following:

```
make status
```

This should result in output similar to this:

```
A container with image=bench/riak is currently running at [http://localhost:49154/ping]
Basho Bench is currently serving a report at [http://localhost:49156/reports/current/]
```

The test report files are also copied at the end of each test to the host machine. They can be found like so:

```
$ ls images/docker-basho-bench/reports/
1403641275
1403641898

$ ls images/docker-basho-bench/reports/1403641898/
preload.config
http10read1write.config
index.html

$ ls images/docker-basho-bench/reports/1403641898/http10read1write.config/
console.log
error.log
get_latencies.csv
put_latencies.csv
log.sasl.txt
summary.png
crash.log
errors.csv
http10read1write.config	
summary.csv
```

### Cleaning Tests

Running the following will stop and remove all running containers

```
make stop
```
