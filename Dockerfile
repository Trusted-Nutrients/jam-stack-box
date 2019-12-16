FROM ubuntu:18.04

LABEL maintainer="@alexanderhorl"

ENV LANGUAGE en_US:en
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get -y update && \
  apt-get install -y --no-install-recommends software-properties-common language-pack-en-base apt-transport-https && \
  echo 'Acquire::Languages {"none";};' > /etc/apt/apt.conf.d/60language && \
  echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
  echo 'LANGUAGE="en_US:en"' >> /etc/default/locale && \
  locale-gen en_US.UTF-8 && \
  update-locale en_US.UTF-8 && \
  add-apt-repository -y ppa:git-core/ppa && \
  add-apt-repository -y ppa:rwky/graphicsmagick && \
  add-apt-repository -y ppa:deadsnakes/ppa && \
  apt-get -y update && \
  apt-get install -y --no-install-recommends \
  advancecomp \
  apache2-utils \
  autoconf \
  automake \
  bison \
  build-essential \
  bzr \
  cmake \
  curl \
  doxygen \
  elixir \
  expect \
  fontconfig \
  fontconfig-config \
  g++ \
  gawk \
  git \
  git-lfs \
  gifsicle \
  gobject-introspection \
  graphicsmagick \
  graphviz \
  gtk-doc-tools \
  gnupg2 \
  imagemagick \
  jpegoptim \
  jq \
  libasound2 \
  libcurl4 \
  libenchant1c2a \
  libexif-dev \
  libffi-dev \
  libfontconfig1 \
  libgconf-2-4 \
  libgd-dev \
  libgdbm-dev \
  libgif-dev \
  libglib2.0-dev \
  libgmp3-dev \
  libgsl-dev \
  libgtk-3-0 \
  libgtk2.0-0 \
  libicu-dev \
  libimage-exiftool-perl \
  libjpeg-progs \
  libjpeg-turbo8-dev \
  libmagickwand-dev \
  libmcrypt-dev \
  libncurses5-dev \
  libnss3 \
  libreadline6-dev \
  librsvg2-bin \
  libsm6 \
  libsqlite3-dev \
  libssl-dev \
  libtiff5-dev \
  libwebp-dev \
  libxml2-dev \
  libxrender1 \
  libxslt-dev \
  libxss1 \
  libxtst6 \
  libyaml-dev \
  mercurial \
  nasm \
  nginx \
  optipng \
  pngcrush \
  rsync \
  software-properties-common \
  ssh \
  strace \
  swig \
  tree \
  unzip \
  xfonts-base \
  xfonts-75dpi \
  xvfb \
  zip

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g yarn node-gyp

WORKDIR /home

COPY . .

RUN cd server && \
  npm install && \
  yarn build && \
  cd .. && \
  cd frontend && \
  npm install && \
  yarn build

VOLUME [ "/data" ]

EXPOSE 3000

CMD [ "node", "server/dist/index.js" ]