FROM ruby:2.7.2

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
WORKDIR /pinejuice

COPY . .

RUN bundle install --jobs=4
