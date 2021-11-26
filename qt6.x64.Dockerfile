# syntax = docker/dockerfile:experimental

ARG FROMIMAGE=ubuntu:bionic

FROM nvidia/cuda:11.0-devel-ubuntu20.04 as build

LABEL maintainer="rui.sebastiao@dreamforit.com"
LABEL stage=build


ENV TZ=Europe/Lisbon
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# ENV DEBIAN_FRONTEND=noninteractive
# ENV CUDA_HOME="/usr/local/cuda"
# ENV PATH="/usr/local/cuda/bin:${PATH}"
# ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
# ENV LLVM_CONFIG="/usr/bin/llvm-config-9"
# ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/lib/aarch64-linux-gnu/:${LD_LIBRARY_PATH}"
# ARG USER_UID=
# ARG USER_GID=

# # because Nvidia has no keyserver for Tegra currently, we DL the whole BSP tarball, just for the apt key.
# ARG BSP_URI="https://developer.nvidia.com/embedded/dlc/r32-3-1_Release_v1.0/t210ref_release_aarch64/Tegra210_Linux_R32.3.1_aarch64.tbz2"
# ARG BSP_SHA512="13c4dd8e6b20c39c4139f43e4c5576be4cdafa18fb71ef29a9acfcea764af8788bb597a7e69a76eccf61cbedea7681e8a7f4262cd44d60cefe90e7ca5650da8a"

# RUN printenv

WORKDIR /tmp

# # install apt key and configure apt sources
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         ca-certificates \
#         wget \
#     && BSP_SHA512_ACTUAL="$(wget --https-only -nv --show-progress --progress=bar:force:noscroll -O- ${BSP_URI} | tee bsp.tbz2 | sha512sum -b | cut -d ' ' -f 1)" \
#     && [ ${BSP_SHA512_ACTUAL} = ${BSP_SHA512} ] \
#     && echo "Extracting bsp.tbz2" \
#     && tar --no-same-permissions -xjf bsp.tbz2 \
#     && cp Linux_for_Tegra/nv_tegra/jetson-ota-public.key /etc/apt/trusted.gpg.d/jetson-ota-public.asc \
#     && chmod 644 /etc/apt/trusted.gpg.d/jetson-ota-public.asc \
#     && rm * -rf \
#     && rm -rf /var/lib/apt/lists/*

# # This determines what <SOC> gets filled in in the nvidia apt sources list:
# # putting it here so there's a common layer for all boards and build_all.sh builds faster
# # valid choices: t210, t186, t194 
# ARG SOC="t210"

# RUN echo "deb https://repo.download.nvidia.com/jetson/common r32.4 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list \
#     && echo "deb https://repo.download.nvidia.com/jetson/${SOC} r32.4 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list \
#     && apt-get update \
#     && rm -rf /var/lib/apt/lists/*


# # Needed in both builder and qt stages, so has to be defined here
ENV QT_PREFIX=/opt/qt6

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





WORKDIR /tmp

#https://mirrors.dotsrc.org/qtproject/archive/qt/5.14/5.15.2/single/qt-everywhere-src-6.2.0.tar.xz


# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	libxcb-dri3-dev \
	# cmake \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*


RUN --mount=type=cache,target=/tmp/ rm -rf qt_build && mkdir qt_build && cd qt_build && wget https://mirrors.dotsrc.org/qtproject/archive/qt/6.2/6.2.0/single/qt-everywhere-src-6.2.0.tar.xz


# # Install all build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	unzip \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip && unzip ninja-linux.zip -d /usr/local/bin/ && update-alternatives --install /usr/bin/ninja ninja /usr/local/bin/ninja 1 --force 

RUN --mount=type=cache,target=/tmp/ cd qt_build && rm -rf qt-everywhere-src-6.2.0 && tar -xpf qt-everywhere-src-6.2.0.tar.xz



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

# RUN apt-get update && apt-get -y --no-install-recommends install \
# 	ninja-build \
# 	&& apt-get -qq clean \
# 	&& rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt-everywhere-src-6.2.0 && ./configure -prefix $QT_PREFIX -nomake examples -nomake tests -skip qtwayland -skip qtvirtualkeyboard -skip qtquick3d -skip qtcharts -skip qtdatavis3d

#RUN --mount=type=cache,target=/tmp/ ls /tmp/qt_build/qt-everywhere-src-6.2.0/

#RUN bresss


RUN apt-get update && apt-get -y --no-install-recommends install \
	libxkbfile-dev \
	&& apt-get -qq clean \
	&& rm -rf /var/lib/apt/lists/*

RUN --mount=type=cache,target=/tmp/ cd qt_build &&  cd qt-everywhere-src-6.2.0 && cmake --build . --parallel
# # install it
RUN --mount=type=cache,target=/tmp/ cd qt_build && cd qt-everywhere-src-6.2.0 && cmake --install .


RUN --mount=type=cache,target=/tmp/ ls /opt/qt5/plugins/platforms/

# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# # resulting image with environment
# # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FROM nvidia/cuda:11.0-runtime-ubuntu20.04 as qt

# ENV ENTRYPOINT_DIR=/usr/local/bin
# ENV APP_BUILDDIR=/var/build

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
