# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.4.5
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

# postgresql-client と libpq-dev をインストールするコマンドを追加
RUN sudo apt-get update && sudo apt-get install -y postgresql-client libpq-dev