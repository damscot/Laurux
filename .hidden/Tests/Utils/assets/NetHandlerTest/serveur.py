#!/usr/bin/env python3
"""Serveur TCP de test de NetHandler (NETHANDLER-T01 à T06).

Usage : serveur.py <répertoire>
Écoute sur 127.0.0.1, port libre choisi par le système, écrit ce port dans <répertoire>/port puis enregistre
dans <répertoire>/recu les octets reçus (toutes connexions confondues, écriture immédiate). S'arrête seul
après 30 s.
"""
import os
import select
import socket
import sys
import time

rep = sys.argv[1]
srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
srv.bind(("127.0.0.1", 0))
srv.listen(5)
with open(os.path.join(rep, "recu"), "wb"):
    pass
tmp = os.path.join(rep, "port.tmp")
with open(tmp, "w") as f:
    f.write(str(srv.getsockname()[1]))
os.rename(tmp, os.path.join(rep, "port"))
socks = [srv]
fin = time.time() + 30
while time.time() < fin:
    lus, _, _ = select.select(socks, [], [], 0.2)
    for s in lus:
        if s is srv:
            c, _ = srv.accept()
            socks.append(c)
        else:
            data = s.recv(65536)
            if not data:
                socks.remove(s)
                s.close()
                continue
            with open(os.path.join(rep, "recu"), "ab") as f:
                f.write(data)
