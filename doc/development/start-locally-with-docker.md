working locally with docker
=================================

To start (and build, if necessary) the containers run

    docker-compose up

Migrate the database:

    docker images -qa
    docker exec -ti imimap-dev rake db:seed


The imimap-dev container starts up unicorn on start, the server can be reached at

    open http://localhost:8080

You can then enter a bash in the imimap-dev container

    docker exec -ti imimap-dev bash

and then run all the commands there that you would usally run, e.g.

    rails db:migrate
    rspec spec

You can also directly migrate and run the tests:

    docker exec -ti imimap-dev rake db:migrate RAILS_ENV=test; rspec spec

or enter the rails console

    docker exec -ti imimap-dev rails c



Start locally with a persistent database
=================================

Use docker-compose-db.yml :

    docker-compose -f docker-compose-db.yml up



Clean up the docker images
=================================

You can check which containers are running with

     docker ps

Remove all containers

    docker rm $(docker ps -aq)

Remove all images

    docker rmi $(docker images -qa)