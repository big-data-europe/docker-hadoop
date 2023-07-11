DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t khalibre/hadoop:base-$(current_branch) ./base
	docker build -t khalibre/hadoop:namenode-$(current_branch) ./namenode
	docker build -t khalibre/hadoop:datanode-$(current_branch) ./datanode
	docker build -t khalibre/hadoop:resourcemanager-$(current_branch) ./resourcemanager
	docker build -t khalibre/hadoop:nodemanager-$(current_branch) ./nodemanager
	docker build -t khalibre/hadoop:historyserver-$(current_branch) ./historyserver
