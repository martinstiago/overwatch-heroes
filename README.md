# Overwatch Heroes

[![CircleCI](https://circleci.com/gh/martinstiago/overwatch-heroes.svg?style=svg)](https://circleci.com/gh/martinstiago/overwatch-heroes)
[![codecov](https://codecov.io/gh/martinstiago/overwatch-heroes/branch/master/graph/badge.svg)](https://codecov.io/gh/martinstiago/overwatch-heroes)
[![Maintainability](https://api.codeclimate.com/v1/badges/fdf5a610be62ee72d41d/maintainability)](https://codeclimate.com/github/martinstiago/overwatch-heroes/maintainability)

API with information about Overwatch heroes and their abilities.

To run the application locally

Without docker:
```
bundle install
rails heroes:persist
rails s
```

With docker:
```
docker-compose up -d
docker-compose run app rails heroes:persist
```

[Application URL](https://martinstiago-overwatch-heroes.herokuapp.com)
