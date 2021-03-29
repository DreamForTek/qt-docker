# qt-docker

## 

` //sudo chcpu --disable 6-11 `

` //sudo chcpu --enable 6-11 `

`BUILDKIT_STEP_LOG_MAX_SIZE=10000000 DOCKER_BUILDKIT=1 docker build --platform linux/arm64 --progress plain -t docker-dtek.servebbs.org/dreamfortek/qt-docker/qt:5.15.2 . -f qt.Dockerfile`