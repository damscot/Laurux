# Écoute TCP locale pour ZebraTest/DymoTest : port libre écrit dans argv[2], octets reçus dans argv[1].
import socket, sys
s = socket.socket()
s.bind(("127.0.0.1", 0))
s.listen(1)
s.settimeout(10)
with open(sys.argv[2] + ".tmp", "w") as f:
    f.write(str(s.getsockname()[1]))
import os
os.rename(sys.argv[2] + ".tmp", sys.argv[2])
c, _ = s.accept()
c.settimeout(10)
data = b""
while True:
    try:
        b = c.recv(65536)
    except socket.timeout:
        break
    if not b:
        break
    data += b
with open(sys.argv[1], "wb") as f:
    f.write(data)
open(sys.argv[1] + ".ok", "w").close()
