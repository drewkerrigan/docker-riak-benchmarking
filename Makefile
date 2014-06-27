.PHONY: all init build start stop

all: up build start

up:
	vagrant up

pull-docker-riak:
	git clone git@github.com:hectcastro/docker-riak.git images/docker-riak
	cp -R images/common/common-bin images/docker-riak/common-bin
	cp images/common/Makefile images/docker-riak/Makefile
pull-docker-riak2.0:
	git clone git@github.com:hectcastro/docker-riak.git images/docker-riak
	cd images/docker-riak && git checkout riak20 && cd ../../
	cp -R images/common/common-bin images/docker-riak/common-bin
	cp images/common/Makefile images/docker-riak/Makefile

pull-docker-basho-bench:
	git clone git@github.com:drewkerrigan/docker-basho-bench.git images/docker-basho-bench

build-docker-riak:
	vagrant ssh -c "cd /vagrant/images/docker-riak && make build bench/riak"
build-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make build"
build: build-docker-riak build-docker-basho-bench

start-docker-riak:
	vagrant ssh -c "cd /vagrant/images/docker-riak && make start bench/riak 8098 ping OK '-P --name \"riak\" -d'"
start-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make start $TESTS"
start: start-docker-riak start-docker-basho-bench
	
stop-docker-riak:
	vagrant ssh -c "cd /vagrant/images/docker-riak && make stop bench/riak"
stop-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make stop"
stop: stop-docker-riak stop-docker-basho-bench

debug-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make debug"

snapshot-docker-riak:
	vagrant ssh -c "cd /vagrant/images/docker-riak && make snapshot bench/riak"
snapshot-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make snapshot"

status-docker-riak:
	vagrant ssh -c "cd /vagrant/images/docker-riak && make status bench/riak 8098 ping OK"
status-docker-basho-bench:
	vagrant ssh -c "cd /vagrant/images/docker-basho-bench && make status"
status: status-docker-riak status-docker-basho-bench

destroy:
	vagrant destroy