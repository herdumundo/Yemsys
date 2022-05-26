#!/bin/sh
mvn clean package && docker build -t com.maehara/Yemsys .
docker rm -f Yemsys || true && docker run -d -p 9080:9080 -p 9443:9443 --name Yemsys com.maehara/Yemsys