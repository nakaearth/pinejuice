FROM ruby:2.7.6

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
RUN mkdir /pinejuice
WORKDIR /pinejuice
COPY Gemfile /pinejuice/Gemfile
COPY Gemfile.lock /pinejuice/Gemfile.lock
RUN gem install bundler:2.2.2
RUN bundle install
COPY . /pinejuice

# Add a script to be executed every time the container starts.
COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]