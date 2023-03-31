DOCKER_NETWORK = docker-hadoop-master_default
ENV_FILE = hadoop.env
current_branch = master
build:
	docker build -t bde2020/hadoop-base:$(current_branch) ./base
	docker build -t bde2020/hadoop-namenode:$(current_branch) ./namenode
	docker build -t bde2020/hadoop-datanode:$(current_branch) ./datanode
	docker build -t bde2020/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t bde2020/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t bde2020/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t bde2020/hadoop-submit:$(current_branch) ./submit

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount hdfs dfs -copyFromLocal -f /user-input/tekstbestand.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount hdfs dfs -rm -r /input

woord:
	# docker build -t hadoop-wordcount ./submit
	docker exec -it namenode "hdfs dfs -mkdir -p /input/"
	docker cp ./input/tekstbestand.txt namenode:/user-input/"
	docker exec -it namenode "hdfs dfs -copyFromLocal -f /user-input/tekstbestand.txt /input/"
	docker exec -it namenode "hadoop-wordcount"
	docker exec -it namenode "hdfs dfs -cat /output/*"
	docker exec -it namenode "hdfs dfs -rm -r /output"
	docker exec -it namenode "hdfs dfs -rm -r /input"
