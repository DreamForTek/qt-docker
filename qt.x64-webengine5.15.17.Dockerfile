# syntax = docker/dockerfile:experimental

ARG FROMIMAGE=ubuntu:bionic

FROM nvidia/cuda:11.0-devel-ubuntu20.04 as build

LABEL maintainer="rui.sebastiao@dreamforit.com"
LABEL stage=build


ENV TZ=Europe/Lisbon
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# RUN printenv

WORKDIR /tmp
# # Needed in both builder and qt stages, so has to be defined here
ENV QT_PREFIX=/opt/qt5

# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	ca-certificates \
	curl \
	python \
	gperf \
	bison \
	flex \
	build-essential \
	pkg-config \
	libgl1-mesa-dev \
	libicu-dev \
	firebird-dev \
	libmysqlclient-dev \
	libpq-dev \
	# bc suggested for openssl tests
	bc \
	libssl-dev \
	# git is needed to build openssl in older versions
	git \
	libgles2-mesa-dev \
	# xcb dependencies
	libfontconfig1-dev \
	libfreetype6-dev \
	libx11-dev \
	libxext-dev \
	libxfixes-dev \
	libxi-dev \
	libxrender-dev \
	libxcb1-dev \
	libx11-xcb-dev \
	libxcb-glx0-dev \
	libxkbcommon-x11-dev \
	# bash needed for argument substitution in entrypoint
	bash \
	# since 5.14.0 we apparently need libdbus-1-dev and libnss3-dev
	libnss3-dev \
	libdbus-1-dev \
	libjpeg-dev \
	libjpeg8-dev \
	libjpeg-turbo8-dev \
	libpng-dev \
	libegl1-mesa-dev \
	libxcomposite-dev \
	libxcomposite-dev \
	libxcursor-dev \
	libxtst-dev \
	libdrm-dev \
	libxrandr-dev \
	libxdamage-dev libfontconfig1-dev libxss-dev \
	wget \
	libxcb-util-dev libxcb-xfixes0-dev \
	libxcb-xinerama0-dev \
	libxcb-xinput-dev \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*




# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	ca-certificates \
	curl \
	python \
	gperf \
	bison \
	flex \
	build-essential \
	pkg-config \
	libgl1-mesa-dev \
	libicu-dev \
	firebird-dev \
	libmysqlclient-dev \
	libpq-dev \
	# bc suggested for openssl tests
	bc \
	libssl-dev \
	# git is needed to build openssl in older versions
	git \
	libgles2-mesa-dev \
	# xcb dependencies
	libfontconfig1-dev \
	libfreetype6-dev \
	libx11-dev \
	libxext-dev \
	libxfixes-dev \
	libxi-dev \
	libxrender-dev \
	libxcb1-dev \
	libx11-xcb-dev \
	libxcb-glx0-dev \
	libxkbcommon-x11-dev \
	libxkbcommon-dev \
	bash \
	# bash needed for argument substitution in entrypoint
	# since 5.14.0 we apparently need libdbus-1-dev and libnss3-dev
	libnss3-dev \
	libdbus-1-dev \
	libjpeg-dev \
	libjpeg8-dev \
	libjpeg-turbo8-dev \
	libpng-dev \
	libxcomposite-dev \
	libxcomposite-dev \
	libxcursor-dev \
	libxtst-dev \
	libxrandr-dev \
	libfontconfig1-dev \
	libfreetype6-dev \
	libx11-dev \
	libx11-xcb-dev \
	libxext-dev \
	libxfixes-dev \
	libxi-dev \
	libxrender-dev \
	libxcb1-dev \
	libxcb-glx0-dev \
	libxcb-keysyms1-dev \
	libxcb-image0-dev \
	libxcb-shm0-dev \
	libxcb-icccm4-dev \
	libxcb-sync0-dev \
	libxcb-xfixes0-dev \
	libxcb-shape0-dev \
	libxcb-randr0-dev \
	libxcb-render-util0-dev \
	libxkbcommon-dev \
	libxkbcommon-x11-dev \
	libxdamage-dev libfontconfig1-dev libxss-dev \
	libegl1-mesa-dev \
	libxcb-util-dev \
	libxcb-xinerama0-dev \
	libxcb-xinput-dev \    
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*

# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	unzip \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip && unzip ninja-linux.zip -d /usr/local/bin/ && update-alternatives --install /usr/bin/ninja ninja /usr/local/bin/ninja 1 --force 


# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	dbus \
	fontconfig libdrm-dev \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*


#RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-3.22.0-linux-x86_64.sh && chmod +x ./cmake-3.22.0-linux-x86_64.sh && ./cmake-3.22.0-linux-x86_64.sh

RUN wget -qO- "https://cmake.org/files/v3.22/cmake-3.22.0-linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local 

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - 
RUN apt-get install -y nodejs


# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	xscreensaver \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*

# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	libxshmfence-dev \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*



RUN apt-get update && apt-get -y --no-install-recommends install \
	libxkbfile-dev \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*






WORKDIR /tmp





RUN --mount=type=cache,target=/tmp/ ls -l && rm -rf qt_build && mkdir qt_build && cd qt_build && rm -rf qt5 && git clone https://github.com/qt/qt5.git

#wget https://mirrors.dotsrc.org/qtproject/archive/qt/5.15/5.15.2/single/qt-everywhere-src-5.15.2.tar.xz

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git checkout 5.15.2

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtbase 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtconnectivity 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtdeclarative

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtimageformats

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtlocation

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtmultimedia

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtquickcontrols 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtquickcontrols2

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtscript

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtqa 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtscxml 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtsensors 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtserialport 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtsvg 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtsystems  

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtwebchannel

# RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && ls && rm -rf qtwebengine 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtwebengine

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtwebsockets
 
RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtwebview 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtxmlpatterns 


RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtx11extras 

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5  && git submodule update --recursive --init qtgraphicaleffects 



# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	libxcb-dri3-dev \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*


RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5 && ./configure -opensource -recheck-all -confirm-license -prefix $QT_PREFIX -nomake examples -nomake tests -skip qtwayland -skip qtvirtualkeyboard -skip qtcharts -skip qtdatavis3d 
#&& rm -rf qtdoc && ls && ./configure -prefix $QT_PREFIX -nomake examples -nomake tests -skip qtwayland -skip qtvirtualkeyboard -skip qtquick3d -skip qtcharts -skip qtdatavis3d

#RUN sadsasdsd

# RUN asdasd
RUN --mount=type=cache,target=/tmp/ cd qt_build &&  cd qt5 &&  make -j4
# # install it
RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt5 && make install


RUN --mount=type=cache,target=/tmp/ ls /opt/qt5/lib/

# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# # resulting image with environment
# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FROM nvidia/cuda:11.0-runtime-ubuntu20.04 as qt

# ENV ENTRYPOINT_DIR=/usr/local/bin
# ENV APP_BUILDDIR=/var/build

ENV QT_PREFIX=/opt/qt5

COPY --from=build ${QT_PREFIX} ${QT_PREFIX}

# # the next copy statement failed often. My only guess is, that the extra dependencies are not existent and somehow that
# # triggers a failure here.... A workaround for similar issues is to put an empty run statement in between: https://github.com/moby/moby/issues/37965
# RUN true
# COPY --from=builder /opt/extra-dependencies /opt/extra-dependencies

# #for modifications during configuration
ENV LD_LIBRARY_PATH=/opt/qt5/lib:${LD_LIBRARY_PATH}
ENV PATH=/opt/qt5/bin:${PATH}

# # the next copy statement failed often. My only guess is, that the extra dependencies are not existent and somehow that
# # triggers a failure here.... A workaround for similar issues is to put an empty run statement in between: https://github.com/moby/moby/issues/37965
# RUN true
# # COPY entrypoint.sh ${ENTRYPOINT_DIR}

# # RUN chmod +x ${ENTRYPOINT_DIR}/entrypoint.sh

# VOLUME ["${APP_BUILDDIR}"]

# USER ${QT_USERNAME}

# # ENTRYPOINT ["entrypoint.sh"]
