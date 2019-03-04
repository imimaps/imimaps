FROM ruby:2.6.1-alpine3.9

ENV APP_HOME /usr/src/app
ENV IMIMAPS_ENVIRONMENT docker

EXPOSE 80

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

# general dependencies
RUN apk update
RUN set -ex \
  && apk add --no-cache git libpq imagemagick nodejs bash

# poltergeist, see https://github.com/Overbryd/docker-phantomjs-alpine/releases
RUN apk add --no-cache fontconfig curl && \
  mkdir -p /usr/share && \
  cd /usr/share \
  && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
  && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
  && phantomjs --version

# build dependencies
RUN set -ex \
   && apk add --no-cache --virtual builddependencies \
#  && apk add --no-cache  \
       linux-headers \
       libpq \
       tzdata \
       build-base \
       postgresql-dev \
       imagemagick-dev \
   && bundle install

#  && apk del builddependencies
CMD ["bundle", "exec", "unicorn", "--port", "80"]
