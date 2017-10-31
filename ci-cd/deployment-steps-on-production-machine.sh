#!/bin/bash
exit_on_error () {
  sshexit=$1
  if [ $sshexit -eq 0 ]; then
    echo "step ok"
  else
      echo "ERROR: step failed with exit code $sshexit"
      echo "ERROR: deployment failed"
      exit $sshexit
  fi
}
echo "+++ pulling and starting docker containers"
docker-compose -f docker-compose-production.yml up -d
exit_on_error $?

echo "+++ Clean assets "
rm -rf nginx-assets
mkdir -p nginx-assets
echo "+++ copy assets from container to dir on host"
docker cp imimap:/usr/src/app/public/assets nginx-assets
exit_on_error $?

# echo "+++ Asset precompilation "
# docker-compose -f docker-compose-production.yml exec imimap rake assets:precompile
# exit_on_error $?

# echo "+++ instead copy the precompiled assets to new dir"
#       - ./rails/public:/usr/src/app/nginx-assets
# rm -rf ./rails/public # clear out assets directory from host,
# then copy assets to mounted dir to make them accessible from outside the container.
# docker-compose -f docker-compose-production.yml exec imimap cp -r ./public/assets ./nginx-assets
# exit_on_error $?

echo "+++ Wait for postgres"
docker-compose -f docker-compose-production.yml exec imimap ./ci-cd/wait-for-db-connection.sh
exit_on_error $?

echo "+++ Database Migration"
docker-compose -f docker-compose-production.yml exec imimap bundle exec rake db:migrate
exit_on_error $?