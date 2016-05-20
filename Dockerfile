FROM dduportal/bats:0.4.0

MAINTAINER devops@cchaudier.fr


RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y --force-yes build-essential curl git
RUN apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean

# Install rbenv and ruby-build
ENV RBENV_ROOT /usr/share/rbenv
ENV PATH $RBENV_ROOT/bin:$PATH
ENV RUBY_VERSION 2.3.1
ENV CONFIGURE_OPTS --disable-install-doc
RUN git clone https://github.com/sstephenson/rbenv.git $RBENV_ROOT
RUN git clone https://github.com/sstephenson/ruby-build.git $RBENV_ROOT/plugins/ruby-build
RUN git clone https://github.com/sstephenson/rbenv-gem-rehash.git $RBENV_ROOT/plugins/rbenv-gem-rehash
WORKDIR $RBENV_ROOT/plugins/ruby-build
RUN ./install.sh
WORKDIR /root
RUN echo 'export RBENV_ROOT=/usr/share/rbenv' > /etc/profile.d/rbenv.sh
RUN echo 'export PATH=$RBENV_ROOT/bin:$PATH' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/bash.bashrc

#Install ruby
RUN rbenv install $RUBY_VERSION
RUN rbenv global $RUBY_VERSION
RUN rbenv rehash

RUN echo 'install: --no-document' > ~/.gemrc
RUN echo 'update: --no-document' >> ~/.gemrc
#RUN dircolors -p > /etc/dircolors
RUN bash -l -c 'gem install bundler'

#My app
ADD . /app/bats-tests
WORKDIR /app/bats-tests
RUN bash -l -c 'bundle install'

ENTRYPOINT bash -l -c 'bundle exec guard'
