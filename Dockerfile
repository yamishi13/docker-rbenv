FROM ubuntu:14.04

MAINTAINER Roberto C Martinez <roberto.mtzarriaga@gmail.com>

RUN apt-get update

RUN apt-get -q -y install software-properties-common

RUN add-apt-repository ppa:webupd8team/java \
  && apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | \
    sudo debconf-set-selections \
  && echo debconf shared/accepted-oracle-license-v1-1 seen true | \
    sudo debconf-set-selections \
  && DEBIAN_FRONTEND=noninteractive apt-get -q -y install git subversion \
    autoconf bison build-essential libssl-dev libyaml-dev wget \
    libreadline6 libreadline6-dev zlib1g zlib1g-dev oracle-java7-installer \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv \
  && rm -r ~/.rbenv/.git

RUN git clone https://github.com/sstephenson/ruby-build.git \
    ~/.rbenv/plugins/ruby-build \
  && rm -r ~/.rbenv/plugins/ruby-build/.git

RUN git clone https://github.com/sstephenson/rbenv-gem-rehash.git \
    ~/.rbenv/plugins/rbenv-gem-rehash \
  && rm -r ~/.rbenv/plugins/rbenv-gem-rehash/.git

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile \
  && echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
