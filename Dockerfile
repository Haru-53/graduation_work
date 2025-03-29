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
    sqlite3 \
    libsqlite3-dev \
    nodejs \
    yarn

# Rails app lives here
WORKDIR /rails

# Set default environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test" \
    NODE_ENV="production"

# Create rails user and group for application ownership
RUN groupadd -r rails
RUN useradd -m -d /rails -u 1000 -g rails rails

# Install gems needed for building assets (in a separate stage to cache)
FROM base as builder
WORKDIR /rails
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# Precompile assets
COPY . .
COPY package.json yarn.lock ./
RUN yarn install --check-files
RUN rails assets:precompile

# Final stage for app image
FROM base
WORKDIR /rails
COPY --from=builder /rails /rails

# Set ownership for important directories
RUN chown -R rails:rails /rails

# Switch to non-root user
USER rails:rails

# Entrypoint prepares the database and starts the server
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0"]
