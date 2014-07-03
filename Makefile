.PHONY: all init build start stop

all: up build start

up:
	vagrant up

pull-docker-riak-simple:
	git clone git@github.com:drewkerrigan/docker-riak-simple.git images/docker-riak-simple

pull-docker-basho-bench:
	git clone git@github.com:drewkerrigan/docker-basho-bench.git images/docker-basho-bench

build-docker-riak-simple:
	vagrant ssh -c "cd /vagrant/images/docker-riak-simple && make build"
build-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make build"
build: build-docker-riak-simple build-docker-basho-bench

start-docker-riak-simple:
	vagrant ssh -c "cd /vagrant/images/docker-riak-simple && make start"
start-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make start TESTS=$TESTS"
start: start-docker-riak-simple start-docker-basho-bench
	
stop-docker-riak-simple:
	vagrant ssh -c "cd /vagrant/images/docker-riak-simple && make stop"
stop-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make stop"
stop: stop-docker-riak-simple stop-docker-basho-bench

debug-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make debug"

snapshot-docker-riak-simple:
	vagrant ssh -c "cd /vagrant/images/docker-riak-simple && make snapshot"
snapshot-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make snapshot"

status-docker-riak-simple:
	vagrant ssh -c "cd /vagrant/images/docker-riak-simple && make status"
status-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make status"
status: status-docker-riak-simple status-docker-basho-bench

destroy:
	vagrant destroy