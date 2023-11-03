This is a set of recepies for custom taylor Docker images

## building
docker build --no-cache --rm --tag udovicic/echo:apache-php8.1-alternate .

  - if [[ "${TRAVIS_TAG}" != "" ]]; then
    docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD";
    docker tag udovicic/magepack:2.8 udovicic/magepack:latest;
    docker tag udovicic/magepack:2.8 udovicic/magepack:${TRAVIS_TAG};
    docker push udovicic/magepack:2.8;
    docker push udovicic/magepack:latest;
    docker push udovicic/magepack:${TRAVIS_TAG};
    fi
