FROM ruby:2.6.2-alpine

RUN apk add --no-cache \
  bash \
  build-base \
  libxml2-dev \
  libxslt-dev \
  mongodb \
  tzdata

RUN gem update bundler

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["rails", "server"]
