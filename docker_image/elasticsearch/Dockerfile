## Elasticsearch6
# FROM docker.elastic.co/elasticsearch/elasticsearch:6.8.5 AS es6
# RUN elasticsearch-plugin install analysis-kuromoji
# RUN elasticsearch-plugin install analysis-icu
# ADD elasticsearch-example-plugin-6.8.5.zip /usr/share/elasticsearch/elasticsearch-example-plugin-6.8.5.zip
# RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///usr/share/elasticsearch/elasticsearch-example-plugin-6.8.5.zip

## Elasticsearch7
FROM docker.elastic.co/elasticsearch/elasticsearch:7.9.0 AS es7
RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu
#ADD elasticsearch-example-plugin-7.8.0.zip /usr/share/elasticsearch/elasticsearch-example-plugin-7.8.0.zip
#RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install file:///usr/share/elasticsearch/elasticsearch-example-plugin-7.8.0.zip
