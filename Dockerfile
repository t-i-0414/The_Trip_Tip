FROM ruby:2.6.5-alpine

RUN mkdir /app
WORKDIR /app

RUN apk update && \
  apk upgrade && \
  apk add --update\
  bash \
  build-base \
  fontconfig \
  git \
  linux-headers \
  mysql-dev \
  nodejs \
  npm \
  openssh \
  openssl-dev \
  ruby-dev \
  ruby-json \
  yaml \
  yaml-dev \
  tzdata \
  yarn

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
