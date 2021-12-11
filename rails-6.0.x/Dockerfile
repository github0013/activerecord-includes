FROM ruby:2.7.1-alpine
ENV LANG C.UTF-8

# system update
RUN apk update && apk upgrade
# build-essential
RUN apk add --update-cache --no-cache \
  build-base \
  curl-dev \
  linux-headers \
  libxml2-dev \
  libxslt-dev \
  ruby-dev \
  yaml-dev \
  zlib-dev

# basic commands
RUN apk add --update-cache --no-cache \
  bash \
  git \
  openssh \
  ruby-json \
  tzdata \
  yaml \
  sqlite-dev \
  nodejs

# .gemrc
RUN echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc

ENV RUBYOPT='-W:no-deprecated -W:no-experimental'
WORKDIR /app
COPY . .
RUN bundle
