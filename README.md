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


