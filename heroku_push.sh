#/bin/sh
cat > ~/.netrc <<EOF
machine api.heroku.com
  login ${email}
  password ${api_key}
machine git.heroku.com
  login ${email}
  password ${api_key}
EOF
docker login --username=_ --password=$HEROKU_AUTH_TOKEN registry.heroku.com
docker build --rm=false -t registry.heroku.com/${HEROKU_APP_NAME}/web .
docker push registry.heroku.com/${HEROKU_APP_NAME}/web
heroku login
heroku git:remote --app ${HEROKU_APP_NAME}
heroku container:push web --app ${HEROKU_APP_NAME}
heroku container:release web --app ${HEROKU_APP_NAME}
