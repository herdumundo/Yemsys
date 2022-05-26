@echo off
call mvn clean package
call docker build -t com.maehara/Yemsys .
call docker rm -f Yemsys
call docker run -d -p 9080:9080 -p 9443:9443 --name Yemsys com.maehara/Yemsys