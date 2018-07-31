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


chipsd only


sudo docker run -it -p 57777:57777 -p 57776:57776 --mount src=/home/me/docker-chipsd-lightning/node,target=/home/chips3,type=bind chipsd
