.PHONY: all init build start stop

all: up build start

up:
	vagrant up

pull-riak:
	git clone git@github.com:drewkerrigan/docker-riak-simple.git images/riak

pull-bench:
	git clone git@github.com:drewkerrigan/docker-basho-bench.git images/bench

build-riak:
	vagrant ssh -c "cd /vagrant/images/riak && make build"
build-bench:
	vagrant ssh -c "cd /vagrant/images/bench && make build"
build: build-riak build-bench

start-riak:
	vagrant ssh -c "cd /vagrant/images/riak && make start"
start-bench:
	vagrant ssh -c "cd /vagrant/images/bench && make start TESTS=$TESTS"
start: start-riak start-bench
	
stop-riak:
	vagrant ssh -c "cd /vagrant/images/riak && make stop"
stop-bench:
	vagrant ssh -c "cd /vagrant/images/bench && make stop"
stop: stop-riak stop-bench

debug-bench:
	vagrant ssh -c "cd /vagrant/images/bench && make debug"

snapshot-riak:
	vagrant ssh -c "cd /vagrant/images/riak && make snapshot"
snapshot-bench:
	vagrant ssh -c "cd /vagrant/images/bench && make snapshot"

status-riak:
	vagrant ssh -c "cd /vagrant/images/riak && make status"
status-bench:
	vagrant ssh -c "cd /vagrant/images/bench && make status"
status: status-riak status-bench

destroy:
	vagrant destroy