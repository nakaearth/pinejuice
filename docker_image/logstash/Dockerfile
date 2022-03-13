FROM docker.elastic.co/logstash/logstash:7.10.1

RUN rm -rf /usr/share/logstash/config
RUN rm -rf /usr/share/logstash/pipeline
COPY config /usr/share/logstash/config
COPY pipeline /usr/share/logstash/pipeline
COPY mysql-connector-8.0.17.jar /usr/share/logstash/mysql-connector-8.0.17.jar