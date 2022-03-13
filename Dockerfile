FROM ruby:2.7.5

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
WORKDIR /pinejuice

COPY . .
RUN gem install bundler:2.2.2

RUN bundle install --jobs=4
