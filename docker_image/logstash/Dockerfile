FROM docker.elastic.co/logstash/logstash:7.17.1
RUN rm -rf logstash/config
RUN rm -rf logstash/pipeline
COPY --chmod=755 config /user/share/logstash/config
COPY --chmod=755 pipeline /user/share/logstash/pipelin
COPY --chmod=755 mysql-connector-java-8.0.17.jar /user/share/logstash/mysql-connector-java-8.0.17.jar
# RUN bin/logstash-plugin install logstash-output-elasticsearch
# RUN bin/logstash-plugin install logstash-integration-jdbc