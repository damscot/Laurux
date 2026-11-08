#
# Laurux — Dockerfile multi-stage
#
#   Étape « db »  : serveur MariaDB 10.11 seul, configuré pour Laurux (utilisateur, jeu de caractères).
#                   C'est l'image des tests de non-régression (voir docker-compose.test.yml).
#   Étape « app » : hérite de « db » et ajoute Gambas, l'environnement X (xpra, ssh) et Laurux / Laurux-Pos.
#                   Remplace l'ancien Dockerfile Ubuntu 20.04 + mysql-server.
#
# Construction :
#   docker build --target db  -t laurux-db  .     # base de test seule
#   docker build --target app -t laurux-app .     # application complète
#

ARG MARIADB_VERSION=10.11

########################################################################################################
# Étape db : serveur MariaDB configuré pour Laurux
########################################################################################################
FROM mariadb:${MARIADB_VERSION} AS db

# Identifiants par défaut (surchargeables au lancement : -e LAURUX_USER=… -e LAURUX_PASSWORD=…).
# Le mot de passe « laurux » correspond au Password="2D0D0D0D0D0D" des Laurux.conf fournis.
ENV LAURUX_USER=laurux \
    LAURUX_PASSWORD=laurux \
    MARIADB_ROOT_PASSWORD=laurux-root

COPY mysql/laurux.cnf /etc/mysql/conf.d/laurux.cnf
COPY mysql/initdb/ /docker-entrypoint-initdb.d/

EXPOSE 3306
# Point d'entrée et commande hérités de l'image officielle (docker-entrypoint.sh mariadbd).

########################################################################################################
# Étape app : application Laurux complète (Gambas + X déporté + ssh), au-dessus de la base « db »
########################################################################################################
FROM db AS app

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm
COPY keyboard /etc/default/keyboard

# Locales françaises (Laurux est en français : formats de dates et de nombres)
RUN apt-get -y update && \
    apt-get -y install locales locales-all && \
    sed -i -e 's/# fr_FR.UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen fr_FR.UTF-8 && \
    update-locale LANG=fr_FR.UTF-8
ENV LANG=fr_FR.UTF-8 \
    LC_ALL=fr_FR.UTF-8

# Gambas 3 (PPA de l'équipe Gambas) et outils d'exécution de Laurux
RUN apt-get -y install software-properties-common gnupg && \
    add-apt-repository -y ppa:gambas-team/gambas3 && \
    apt-get -y update && \
    apt-get -y install gambas3 gambas3-gb-sdl-sound gambas3-gb-form-print \
                       evince lpr cups-pdf sqlite3 wget vim build-essential git sudo

# Environnement X déporté (xpra, xdm) et ssh
RUN apt-get -y install xpra rox-filer openssh-server pwgen xserver-xephyr x11-apps xterm xdm fluxbox xvfb \
                       net-tools dbus-x11 && \
    sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config && \
    sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess && \
    sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd && \
    rm -rf /var/lib/apt/lists/*

# Utilisateur Linux (le même nom que l'utilisateur MariaDB créé par l'étape db)
ARG USER=laurux
ARG USER_ID=1000
ARG USER_GID=1000
RUN (getent group "${USER_GID}" >/dev/null || groupadd --gid "${USER_GID}" "${USER}") && \
    useradd --uid "${USER_ID}" --gid "${USER_GID}" --create-home --shell /bin/bash "${USER}" && \
    usermod -aG sudo,xpra,mysql "${USER}" && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /run/xpra /run/user/${USER_ID}/xpra && \
    chown -R ${USER}:xpra /run/xpra && chmod 775 /run/xpra && \
    chown -R ${USER}:${USER_GID} /run/user/${USER_ID}

# Laurux et Laurux-Pos
ARG LAURUX_REPO=Laurux
ARG LAURUX_BRANCH=master
ARG LAURUX_SHA1=HEAD
ARG LAURUX_POS_BRANCH=master
ARG LAURUX_POS_SHA1=HEAD
RUN cd /home/${USER} && \
    git clone https://github.com/${LAURUX_REPO}/Laurux.git && \
    git clone https://github.com/${LAURUX_REPO}/Laurux-Pos.git && \
    cd /home/${USER}/Laurux && git checkout -f -B ${LAURUX_BRANCH} ${LAURUX_SHA1} && make clean && make && make package && \
    cd /home/${USER}/Laurux-Pos && git checkout -f -B ${LAURUX_POS_BRANCH} ${LAURUX_POS_SHA1} && make clean && make && make package

RUN mkdir -p /home/${USER}/.config/gambas3 /home/${USER}/.ssh && chmod 700 /home/${USER}/.ssh
COPY Laurux.conf Laurux-Pos.conf /home/${USER}/.config/gambas3/
RUN sed -i -e 's/Login="laurux"/Login="'${USER}'"/' /home/${USER}/.config/gambas3/Laurux.conf \
                                                       /home/${USER}/.config/gambas3/Laurux-Pos.conf && \
    echo "pcm.!default = null;" >> /home/${USER}/.asoundrc && \
    chown -R ${USER}:${USER_GID} /home/${USER}

COPY sshd_config /etc/ssh/sshd_config
COPY user-mapping.sh entrypoint.sh /
RUN chmod u+x /user-mapping.sh /entrypoint.sh

WORKDIR /home/${USER}
ENV USER=${USER} \
    HOME=/home/${USER} \
    LAURUX_USER=${USER}

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

## Utilisation de l'étape app (voir README) :
# docker run --name laurux-app -p 13306:3306 -p 10022:22 --rm -it -e HOST_USER_ID=$(id -u) -e HOST_USER_GID=$(id -g) laurux-app /bin/bash
# ssh -X -p 10022 laurux@localhost bash -c "/home/laurux/Laurux/Laurux"
# ou : docker run … laurux-app bash -c "xpra start :100 --start-child=/home/laurux/Laurux/Laurux --daemon=no --exit-with-children --exit-with-client=yes"
