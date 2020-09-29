# qt-docker

`DOCKER_BUILDKIT=1 docker build --progress plain  --build-arg FROMIMAGE=nvcr.io/nvidia/l4t-base:r32.4.3 -t docker.pkg.github.com/dreamfortek/qt-docker/jetson-nano-qt:5.13.2 . -f qt.Dockerfile`
`docker build --build-arg FROMIMAGE=nvcr.io/nvidia/l4t-base:r32.4.3 -t docker.pkg.github.com/dreamfortek/qt-docker/jetson-nano-qt:5.15.0 . -f qt.Dockerfile`