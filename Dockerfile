# syntax = docker/dockerfile:1
ARG RUBY_VERSION=3.0.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Install common dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    curl \
    libpq-dev \
    nodejs \
    yarn && \
    rm -rf /var/lib/apt/lists/*

# Rails app lives here
WORKDIR /rails

# Create rails user and group for application ownership
RUN groupadd -r rails
RUN useradd -m -d /rails -u 1000 -g rails rails

# Install gems needed for building assets (in a separate stage to cache)
FROM base as builder
WORKDIR /rails

# Install correct bundler version
RUN gem install bundler:2.5.23

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# Precompile assets
COPY . .
COPY package.json yarn.lock ./
RUN bundle exec rails assets:precompile

# Final stage for app image
FROM base
WORKDIR /rails
COPY --from=builder /rails /rails
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Set ownership for important directories
RUN chown -R rails:rails /rails

# Switch to non-root user
USER rails:rails

# Entrypoint prepares the database and starts the server
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]