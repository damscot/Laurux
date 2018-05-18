#
# Laurux Dockerfile
#

# Pull base image.
ARG DISTRIB_VERSION="20.04"
ARG DISTRIB_NAME="ubuntu"
FROM ${DISTRIB_NAME}:${DISTRIB_VERSION}

# Copy FR /etc/default/keyboard into container
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm
COPY keyboard /etc/default/keyboard

# Install GAMBAS and Server dependencies
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -y update && \
  apt-get -y install apt-utils && \
  apt-get -y install software-properties-common && \
  apt-get install -y mysql-server evince evince lpr cups-pdf sqlite wget vim build-essential git && \
  rm -rf /var/lib/apt/lists/*

#Force update package to multiverse source
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get -y update
    
# Install locales
RUN apt-get -y install locales locales-all && \
    sed -i -e 's/# fr_FR.UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen fr_FR.UTF-8 && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=fr_FR.UTF-8

ENV LANG="fr_FR.UTF-8"
ENV LC_CTYPE="fr_FR.UTF-8"
ENV LC_NUMERIC="fr_FR.UTF-8"
ENV LC_TIME="fr_FR.UTF-8"
ENV LC_COLLATE="fr_FR.UTF-8"
ENV LC_MONETARY="fr_FR.UTF-8"
ENV LC_MESSAGES="fr_FR.UTF-8"
ENV LC_PAPER="fr_FR.UTF-8"
ENV LC_NAME="fr_FR.UTF-8"
ENV LC_ADDRESS="fr_FR.UTF-8"
ENV LC_TELEPHONE="fr_FR.UTF-8"
ENV LC_MEASUREMENT="fr_FR.UTF-8"
ENV LC_IDENTIFICATION="fr_FR.UTF-8"

##use gambas ppa or legacy packages
RUN \
  #add-apt-repository -y ppa:gambas-team/gambas3 && \
  #apt-get -y update && \
  #apt-get -y upgrade && \
  apt-get install -y gambas3 gambas3-gb-sdl-sound gambas3-gb-form-print

# Or install local packages archives
#RUN \
#  mkdir /local_packages && \
#  cd /local_packages && \ 
#  wget https://www.laurux.fr/package/gambas/3.10.0/Gambas3_3.10.0_local_packages.tar.gz && \
#  tar -zxvf Gambas3_3.10.0_local_packages.tar.gz

#MYSQL Configuration
RUN mkdir -p /var/run/mysqld && \
  mkdir -p /var/lib/mysql && \
  mkdir -p /var/log/mysql && \
  chown -R mysql:mysql /var/lib/mysql && \
  chown -R mysql:mysql /var/run/mysqld && \
  chown -R mysql:mysql /var/log/mysql

# create linux and mysql user
ARG USER=laurux

RUN sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
  sed -i 's/^# \(port\s.*=\)\s.*3306/\1 3306/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=5 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'CREATE USER \"${USER}\";'" >> /tmp/config && \
  echo "mysql -e 'SET password FOR \"${USER}\" = \"${USER}\";'" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"${USER}\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

#From Docker desktop
# Installing the environment required: xserver, xdm, flux box, roc-filer and ssh
RUN apt-get install -y xpra rox-filer openssh-server pwgen xserver-xephyr x11-apps xterm xdm fluxbox xvfb net-tools dbus-x11 python-numpy
# Configuring xdm to allow connections from any IP address and ssh to allow X11 Forwarding.
RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess

# Fix PAM login issue with sshd
RUN sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql"]

# Create USER and Path
ARG USER_ID=1000
ARG USER_GID=1000

# ADD USER
RUN apt-get install -y sudo && \
    echo "USER: ${USER}" && \
    echo "USER_ID: ${USER_ID}" && \
    echo "USER_GID: ${USER_GID}" && \
    groupadd --gid "${USER_GID}" "${USER}" && \
    useradd \
      --uid ${USER_ID} \
      --gid ${USER_GID} \
      --create-home \
      --shell /bin/bash \
      ${USER} && \
    usermod -aG sudo ${USER} && \
    usermod -aG xpra ${USER} && \
    usermod -aG mysql ${USER} && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#USER PATH and CHMOD
RUN mkdir -p /run/xpra
RUN mkdir -p /run/user/${USER_ID}/xpra
RUN chown -R ${USER}:xpra /run/xpra
RUN chmod 775 /run/xpra
RUN chown -R ${USER}:${USER} /run/user/${USER_ID}

#Now Laurux Stuff
ARG LAURUX_REPO=Laurux
ARG LAURUX_BRANCH=master
ARG LAURUX_SHA1=HEAD
ARG LAURUX_POS_BRANCH=master
ARG LAURUX_POS_SHA1=HEAD
#Fetch
RUN echo Laurux build sha1: $LAURUX_SHA1 && cd /home/${USER}/ && TERM=xterm git clone https://github.com/${LAURUX_REPO}/Laurux.git
RUN echo Laurux-Pos build sha1: $LAURUX_POS_SHA1 && cd /home/${USER}/ && TERM=xterm git clone https://github.com/${LAURUX_REPO}/Laurux-Pos.git
#Checkout Version
RUN cd /home/${USER}/Laurux && TERM=xterm git checkout -f -B ${LAURUX_BRANCH} ${LAURUX_SHA1}
RUN cd /home/${USER}/Laurux-Pos && TERM=xterm git checkout -f -B ${LAURUX_POS_BRANCH} ${LAURUX_POS_SHA1}
#Compile
RUN cd /home/${USER}/Laurux && make clean && make && make package
RUN cd /home/${USER}/Laurux-Pos && make clean && make && make package
RUN mkdir -p /home/${USER}/.config/gambas3
COPY Laurux.conf /home/${USER}/.config/gambas3/
RUN sed -i -e 's/Login="laurux"/Login="'${USER}'"/' /home/${USER}/.config/gambas3/Laurux.conf
COPY Laurux-Pos.conf /home/${USER}/.config/gambas3/
RUN sed -i -e 's/Login="laurux"/Login="'${USER}'"/' /home/${USER}/.config/gambas3/Laurux-Pos.conf
RUN echo "pcm.!default = null;" >> /home/${USER}/.asoundrc

#SSH Access
RUN mkdir -p /home/${USER}/.ssh
RUN chmod 700 /home/${USER}/.ssh
#Set Laurux user right
RUN chown -R ${USER}:${USER} /home/${USER}/Laurux
RUN chown -R ${USER}:${USER} /home/${USER}/Laurux-Pos
RUN chown -R ${USER}:${USER} /home/${USER}/.config
RUN chown -R ${USER}:${USER} /home/${USER}/.ssh
RUN chown ${USER}:${USER} /home/${USER}/.asoundrc
COPY user-mapping.sh /
RUN chmod u+x /user-mapping.sh
# Define default command.
#CMD ["/bin/bash"]
COPY entrypoint.sh /
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Define working directory.
WORKDIR /home/${USER}
ENV USER=${USER}
ENV HOME=/home/${USER}

#SSH CONF
COPY sshd_config /etc/ssh/sshd_config

# Expose ports.
EXPOSE 3306
EXPOSE 22

#BUILD Docker Image
#docker build . -t laurux_master

## USE Docker Container with bash shell and remote X
# docker run --name laurux-master -p 13306:3306 -p 10022:22 --rm -it -e HOST_USER_ID=$(id -u) -e HOST_USER_GID=$(id -g) laurux_master /bin/bash
# ssh-keygen -f /home/$USER/.ssh/known_hosts -R '[localhost]:10022'  ## when you have change the docker image
# ssh-copy-id -p 10022 laurux@localhost
# ssh -X -p 10022 laurux@localhost bash -c "/home/laurux/Laurux/Laurux"

## OR RUN DIRECTLY XPRA 

# docker run --name laurux-master -p 13306:3306 -p 10022:22 --rm -it -e HOST_USER_ID=$(id -u) -e HOST_USER_GID=$(id -g) laurux_master bash -c "xpra start :100 --start-child=/home/laurux/Laurux/Laurux --daemon=no --exit-with-children --exit-with-client=yes"
# then
# xpra attach ssh/laurux@localhost:10022/100

