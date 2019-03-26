FROM ruby:2.6.2

RUN apt-get update && apt-get install -y mongodb nodejs

RUN gem update bundler

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["rails", "server"]
