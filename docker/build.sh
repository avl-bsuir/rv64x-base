GITROOT=`git rev-parse --show-toplevel`
pushd $GITROOT/docker > /dev/null
docker build -f $GITROOT/docker/Dockerfile -t rv64x-dev .
popd > /dev/null
