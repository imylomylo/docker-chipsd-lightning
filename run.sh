#!/bin/bash
#curl --user chipsuser --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:57776/
echo "sudo docker run -it -p 57777:57777 -p 57776:57776 --mount src=/home/mylo/docker-chips/node,target=/root/.chips,type=bind chipsd"
echo "curl --user chipsuser --data-binary '{"jsonrpc": "1.0", "id":"curltest", "method": "getinfo", "params": [] }' -H 'content-type: text/plain;' http://127.0.0.1:57776/"
sudo docker run -it -p 57777:57777 -p 127.0.0.1:57776:57776  --mount src=/home/${USER}/docker-chips/node,target=/root/.chips,type=bind chipsd
#sudo docker run -it -p 127.0.0.1:7771:7771 --mount src=/home/${USER}/docker-komodod-smartcontracts/node,target=/root/.komodo,type=bind --mount src=/home/${USER}/.zcash-params,target=/root/.zcash-params,type=bind kmd-cc

#sudo docker stop $(sudo docker ps -a -q)
#sudo docker ps -a
#sudo docker rm $(sudo docker ps -a -q)
