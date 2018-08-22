# Notes
Webpage http://tools.netsa.cert.org/

This image contains SiLK 3.17.2.

Manual Use: 
```
docker run -it certcc/silklive bash
```

This repo will always contain the latest stable SiLK release for training.

To be used with the following project: [ISLET](https://github.com/jonschipp/ISLET)


# Image Details

The image has the following additional software installed over the base ubuntu docker image:
1. SiLK 3.17.2
2. Fixbuf 2.1.0
3. NetSA Python 1.5
4. Rayon 1.4.3
5. yaf 2.10.0
6. super_mediator 1.6.0
6. Analysis Pipeline 4.5.1
7. gawk, wget, & curl
8. tmux & screen
9. vim, emacs, & nano
10. MySQL server & client
11. tcpdump, netcat, and scapy
12. R
13. man-pages

SiLK has been compiled with the root directory for the SiLK repository set to /data.  This can be changed by setting the SILK_DATA_ROOTDIR environment variable.  See [Environment](http://tools.netsa.cert.org/silk/silk.html#ENVIRONMENT) in the SiLK documentation for more information.  

# Reference Data

Example reference data for SiLK can be found [here](http://tools.netsa.cert.org/silk/referencedata.html).  After downloading, unpack the files with:

```
gzip -d -c FCCX-silk.tar.gz | tar xf -
```

For manual use, run:
```
docker run -it -v [full_path]/FCCX-silk:/data:ro certcc/silklive bash 
```

If using with ISLET silklive.conf, move the unpacked data to the /data/ folder on the Docker host.

# License

Copyright 2016 Carnegie Mellon University
This material is based upon work funded and supported by Flocon - which is funded by Cost Recovery Dollars under Contract No. FA8721-05-C-0003 with Carnegie Mellon University for the operation of the Software Engineering Institute, a federally funded research and development center sponsored by the United States Department of Defense.
Any opinions, findings and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of Flocon - which is funded by Cost Recovery Dollars or the United States Department of Defense.
NO WARRANTY. THIS CARNEGIE MELLON UNIVERSITY AND SOFTWARE ENGINEERING INSTITUTE MATERIAL IS FURNISHED ON AN “AS-IS” BASIS. CARNEGIE MELLON UNIVERSITY MAKES NO WARRANTIES OF ANY KIND, EITHER EXPRESSED OR IMPLIED, AS TO ANY MATTER INCLUDING, BUT NOT LIMITED TO, WARRANTY OF FITNESS FOR PURPOSE OR MERCHANTABILITY, EXCLUSIVITY, OR RESULTS OBTAINED FROM USE OF THE MATERIAL. CARNEGIE MELLON UNIVERSITY DOES NOT MAKE ANY WARRANTY OF ANY KIND WITH RESPECT TO FREEDOM FROM PATENT, TRADEMARK, OR COPYRIGHT INFRINGEMENT.
[Distribution Statement A] This material has been approved for public release and unlimited distribution. Please see Copyright notice for non-US Government use and distribution.
DM-0004288