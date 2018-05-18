#
# Laurux Dockerfile
#

# Pull base image.
FROM ubuntu:18.04

# Copy FR /etc/default/keyboard into container
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
COPY keyboard /etc/default/keyboard

# Install GAMBAS and Server dependencies
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -y update && \
  apt-get -y install apt-utils && \
  apt-get -y install software-properties-common && \
  add-apt-repository -y ppa:gambas-team/gambas3 && \
  apt-get -y update && \
  apt-get -y upgrade && \
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

#MYSQL Configuration
RUN mkdir -p /var/run/mysqld && \
  mkdir -p /var/lib/mysql && \
  mkdir -p /var/log/mysql && \
  chown -R mysql:mysql /var/lib/mysql && \
  chown -R mysql:mysql /var/run/mysqld && \
  chown -R mysql:mysql /var/log/mysql
RUN sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=5 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'CREATE USER \"Laurux\";'" >> /tmp/config && \
  echo "mysql -e 'SET password FOR \"Laurux\" = password(\"Laurux\");'" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"Laurux\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

#Force update package
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get -y update

#BUILD Utilities
RUN apt-get install -y build-essential
#EDITOR
RUN apt-get install -y vim

#EXTRA Package Installation
RUN apt-get install -y evince lpr cups-pdf
RUN apt-get install -y sqlite

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

# Create USER ENV and Path
ENV USER=laurux USER_ID=1001 USER_GID=1001

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
    usermod -aG sudo $USER && \
    usermod -aG xpra $USER && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#USER PATH and CHMOD
RUN mkdir -p /run/xpra
RUN mkdir -p /run/user/${USER_ID}
RUN chown -R ${USER}:xpra /run/xpra
RUN chmod 775 /run/xpra
RUN chown -R ${USER}:${USER} /run/user/${USER_ID}

#Now Laurux Stuff
#Fetch
RUN cd /home/${USER}/ && TERM=xterm git clone https://github.com/Laurux/Laurux.git
RUN cd /home/${USER}/ && TERM=xterm git clone https://github.com/Laurux/Laurux-Pos.git
#Checkout Version
#RUN cd /home/${USER}/Laurux && TERM=xterm git checkout -b v3.68.1 refs/tags/v3.68.1
#RUN cd /home/${USER}/Laurux-Pos && TERM=xterm git checkout -b v3.25.1 refs/tags/v3.25.1
#Compile
RUN cd /home/${USER}/Laurux && make clean && make
RUN cd /home/${USER}/Laurux-Pos && make clean && make
RUN mkdir -p /home/${USER}/.config/gambas3
#SSH Access
RUN mkdir -p /home/${USER}/.ssh
RUN chmod 700 /home/${USER}/.ssh
#Set Laurux user right
RUN chown -R ${USER}:${USER} /home/${USER}/Laurux
RUN chown -R ${USER}:${USER} /home/${USER}/Laurux-Pos
RUN chown -R ${USER}:${USER} /home/${USER}/.config
RUN chown -R ${USER}:${USER} /home/${USER}/.ssh

COPY user-mapping.sh /
RUN chmod u+x /user-mapping.sh
# Define default command.
#CMD ["/bin/bash"]
COPY entrypoint.sh /
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Define working directory.
WORKDIR /home/${USER}
#USER ${USER}
ENV HOME=/home/${USER}

#SSH CONF
COPY sshd_config /etc/ssh/sshd_config

# Expose ports.
#EXPOSE 3306
EXPOSE 22

#BUILD Docker Image
#docker build . -t laurux

#USE Docker Container
# docker run --rm -it -e HOST_USER_ID=$(id -u) -e HOST_USER_GID=$(id -g) laurux /bin/bash

# docker run --rm -it -v /home/$(id -u)/.ssh:/home/laurux/.ssh -e HOST_USER_ID=$(id -u) -e HOST_USER_GID=$(id -g) laurux xpra start :100 --start-child=/home/Laurux/Laurux/Laurux --daemon=no --exit-with-children --exit-with-client=yes
# then
# xpra attach ssh/Laurux@172.17.0.2/100

