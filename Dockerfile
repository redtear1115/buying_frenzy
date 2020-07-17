FROM ruby:2.6.6
# Install dependencies:
# - nodejs: js runtime
RUN apt-get update && apt-get install -qq -y nodejs \
  --fix-missing --no-install-recommends

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ARG RAILS_ENV=development
ENV RAILS_ENV $RAILS_ENV

# This sets the context of where commands will be ran in and is documented
# on Dockers website extensively.
WORKDIR /buying_frenzy

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

# unmark following line if you don't want to cp db to image
# RUN rm -f db/*.sqlite3

# expose port
EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-b", "0.0.0.0"]
