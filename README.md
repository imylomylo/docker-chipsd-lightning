```
git clone <thisrepo>

cd <thisrepo>

mkdir node

sudo docker build -t chipsd-20180727 .
```

When it's built you can see it with `sudo docker images` and before starting you want to put as much of `~/.chips` as you want in `./node` - blocks and chainstate and chips.conf are good.  Sync blocks and chainstate from another switched off node with `rsync` to expedite the process.
```
sudo docker run -it -p 57777:57777  --mount src=/home/me/docker-chipsd-lightning/node,target=/home/chips3,type=bind chipsd-20180727
```
You then end up at a shell ready to start the chipsd daemon with whatever is in your `./node` dir made above in the `pwd` of the container.
```
/chips3/src/chipsd -datadir=./ -daemon
```
Wait for it to load the blocks, then you can issue
```
/chips3/src/chips-cli -datadir=./ getinfo
```
Start lightning
```
/lightning/lightningd/lightningd --alias friendlyalias --ipaddr=xxx.xxx.xxx.xxx --rgb aabbcc --log-level=debug
```
**Troubleshooting**
```
bitcoin-cli not found. Is bitcoin-cli (part of Bitcoin Core) available in your PATH?

Make sure you have bitcoind running and that bitcoin-cli is able to connect to bitcoind.

You can verify that your Bitcoin Core installation is ready for use by running:

    $ chips-cli echo 'hello world'

```
This needs chips-cli in the path.


**Notes**
```
HISTORY
    6  cp chips.conf /root/.chips/
    7  chipsd --help
    8  ln -sf /chips3/src/chips-cli /usr/local/bin/
    9  chipsd -conf /root/.chips/chips.conf -datadir=./ 
   10  chipsd --help | more
   11  chipsd -conf=/root/.chips/chips.conf -datadir=./ 
   12  chips-cli getinfo
   13  /lightning/lightningd/lightningd --alias=friendlyalias --ipaddr=62.210.81.14  --rgb=555555 --log-level=debug
   14  ifconifg
   15  /lightning/lightningd/lightningd --alias=friendlyalias --ipaddr=62.210.81.14  --rgb=555555 --log-level=debug &
   16  /lightning/lightningd/lightning getinfo | jq
   17  /lightning/cli/lightning-cli getinfo | jq
   18  /lightning/cli/lightning-cli ge  
   19  /lightning/cli/lightning-cli getnewaddress
   20  /lightning/cli/lightning-cli getnewaddress | jq
   21  /lightning/cli/lightning
   22  /lightning/cli/lightning-cli newaddr | jq
   23  /lightning/cli/lightning-cli listfunds
   24  /lightning/cli/lightning-cli connect 0256124bcee83d67d0a0e781509ec5b8b58eb374d46dd93f811575b6c8268e4616  185.62.57.207
   25  /lightning/cli/lightning-cli connect 025612
   26  /lightning/cli/lightning-cli connect 02851a6b619adb7f9c4876a3d90b68b0dc0caf7140b9fd3cf9bb8eb7060e03958f 185.62.57.25
   27  /lightning/cli/lightning-cli fundchannel  02851a6b619adb7f9c4876a3d90b68b0dc0caf7140b9fd3cf9bb8eb7060e03958f 200000
   28  /lightning/cli/lightning-cli connect 0256124bcee83d67d0a0e781509ec5b8b58eb374d46dd93f811575b6c8268e4616  185.62.57.207
   29  /lightning/cli/lightning-cli fundchannel 0256124bcee83d67d0a0e781509ec5b8b58eb374d46dd93f811575b6c8268e4616  50000
   30  /lightning/cli/lightning-cli connect 0256124bcee83d67d0a0e781509ec5b8b58eb374d46dd93f811575b6c8268e4616  185.62.57.207
```
