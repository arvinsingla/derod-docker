#!/bin/sh
curl -s https://api.github.com/repos/deroproject/derohe/releases/latest \
| grep "dero_linux_amd64" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
tar xfz dero_linux_amd64.tar.gz --strip-components=1