# Overwatch Heroes

Administrative Panel and API with information about Overwatch heroes and their abilities.

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

[Administrative Panel URL](https://martinstiago-overwatch-heroes.herokuapp.com/)   
[API URL](https://martinstiago-overwatch-heroes.herokuapp.com/api)
