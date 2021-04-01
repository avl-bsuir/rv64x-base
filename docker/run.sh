GITROOT=`git rev-parse --show-toplevel`
MOUNTS="-v $GITROOT:/home/user/repo"
PORTS="-p 2222:22 -p 8080:80"

docker \
  run \
  $MOUNTS $PORTS \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  -h $HOSTNAME \
  -v $HOME/.Xauthority:/home/user/.Xauthority \
  -v /run/user/1000:/run/user/1000 \
  -v /tmp:/tmp \
  -it rv64x-dev

