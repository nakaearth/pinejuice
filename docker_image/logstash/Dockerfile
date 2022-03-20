FROM docker.elastic.co/logstash/logstash:7.10.1

RUN rm -rf logstash/config
RUN rm -rf logstash/pipeline
COPY config logstash/config
COPY pipeline logstash/pipeline
COPY mysql-connector-java-8.0.17.jar logstash/mysql-connector-java-8.0.17.jar