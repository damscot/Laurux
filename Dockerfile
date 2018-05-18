#
# Laurux Dockerfile
#

FROM ubuntu:18.04

# Copy FR /etc/default/keyboard into container
COPY .hidden/keyboard /etc/default/keyboard

# Install GAMBAS and Server dependencies
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -y update && \
  apt-get -y install apt-utils && \
  apt-get -y install software-properties-common && \
  add-apt-repository -y ppa:gambas-team/gambas3 && \
  apt-get -y update && \
  apt-get -y upgrade && \
  useradd -ms /bin/bash laurux && \
  apt-get install -y gambas3 && \
  apt-get install -y mysql-server && \
  apt-get install -y evince wget git && \
  rm -rf /var/lib/apt/lists/*

# Install Local package
#RUN \
#  mkdir /local_packages && \
#  cd /local_packages && \ 
#  wget https://www.laurux.fr/package/gambas/3.10.0/Gambas3_3.10.0_local_packages.tar.gz && \
#  tar -zxvf Gambas3_3.10.0_local_packages.tar.gz

# Install Laurux dependencies
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get -y install xpra

# Set environment variables.
ENV HOME /home/laurux
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Define working directory.
USER laurux
WORKDIR /home/laurux

# Define default command.
ENTRYPOINT ["/bin/bash"]

#HOW to USE
# docker run --rm -it -v $PWD:/home/laurux/Laurux laurux
# docker run --rm -it -v $PWD:/home/laurux/Laurux laurux -v /home/jeanne/.ssh:/home/Laurux/.ssh laurux xpra start :100 --start-child=/home/Laurux/Laurux/Laurux --daemon=no --exit-with-children --exit-with-client=yes
