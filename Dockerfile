FROM ruby:2.6.5
ENV LANG C.UTF-8

RUN mkdir /app
WORKDIR /app

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# nodejsとyarnはwebpackをインストールする際に必要
# Node.js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install nodejs
# yarnパッケージ管理ツール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
