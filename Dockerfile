FROM ruby:2.4.9
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
COPY scripts/launch.sh /usr/bin/
RUN chmod +x /usr/bin/launch.sh
EXPOSE 3333
# Start the main process.
ENTRYPOINT ["launch.sh"]


