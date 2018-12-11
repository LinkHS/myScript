安装
```
sudo apt-get update
sudo apt-get install python-gevent python-pip
pip install shadowsocks --user
pip install libsodium-dev --user

sudo apt-get install python-m2crypto
pip install https://github.com/shadowsocks/shadowsocks/archive/master.zip -U --user
```

---
配置 shadowsocks.json
```
{
    "server":"0.0.0.0",
    "server_port":443,
    "local_address":"127.0.0.1",
    "local_port":1080,
    "password":"YANG&SOCKS5",
    "timeout":300,
    "method":"chacha20-ietf-poly1305",
    "fast_open":false
}
```

---
启动
```
ssserver -c shadowsocks.json 
```
