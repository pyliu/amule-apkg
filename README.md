amule-apk
=========

aMule ASUSTOR package

This document is very, very spartan right now

# Build amule package #
ToDo


## TCP and UDP ports ##

Taken from [Wikipedia](https://en.wikipedia.org/wiki/Amule#TCP_and_UDP_ports):

According to the aMule official FAQ, these are the default ports. Server ports 4661 TCP and 4665 UDP are only used by the EDonkey network. Therefore, the Kad Network will only use 4662 TCP and 4672 UDP. The traffic direction is from client perspective:

* [not sure if used?] 4661 TCP (outgoing): Port on which an eDonkey server listens for connection (port number may vary depending on eDonkey server used).
* 4662 TCP (outgoing and incoming): Client to client transfers.
* 4665 UDP (outgoing and incoming): Used for global eDonkey server searches and global source queries. This is always Client TCP port + 3.
* 4672 UDP (outgoing and incoming): Extended aMule protocol, Queue Rating, File Reask Ping
* 4711 TCP: WebServer listening port. Used if aMule is accessed through the web.
* 4712 TCP: internal Connection port. Used to communicate aMule with other applications such as aMule WebServer or aMuleCMD.

## How-To create password ##
echo -n <your password here> | md5sum | cut -d ' ' -f 1
then replace the Password hash in amule.conf with the one you get above
