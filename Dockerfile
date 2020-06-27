FROM maven:3.6-jdk-8-openj9 AS builder
MAINTAINER tommylikehu <tommylikehu@gmail.com>

COPY . /fscrawler
RUN apt -y update && apt install -y zip
RUN cd /fscrawler && mvn package -DskipIntegTests=true
RUN cd /fscrawler/distribution/es7/target && unzip fscrawler-es7-2.7-SNAPSHOT.zip

FROM openjdk:latest
COPY --from=builder /fscrawler/distribution/es7/target/fscrawler-es7-2.7-SNAPSHOT/ /fscrawler
ENV PATH="/fscrawler/bin:${PATH}"
ENTRYPOINT ["fscrawler"]
