GITROOT=`git rev-parse --show-toplevel`
MOUNTS="-v $GITROOT:/home/user/repo"
PORTS="-p 2222:22 -p 8080:80 -p 5900:5900 -p 5901:5901"

docker \
  run -ti --rm \
  $MOUNTS $PORTS \
  -e DISPLAY=$DISPLAY \
  -h $HOSTNAME \
  rv64x-dev

