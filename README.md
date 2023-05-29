# DockerLnmp

一个简单的 `docker lnmp` 集成环境, 可用于生产环境

**版本**

- php 7.4.33
- nginx 1.24
- mysql (暂时没有集成, 可以连接宿主机的mysql, 主机名用: `host.docker.internal`)
- redis 3.17

**访问地址**

```bash
# 自行在 docker-compose.yml
http://localhost:3000
```

## 目录结构

```bash
├── README.md
├── config                              配置文件
│   ├── php-fpm.conf                        fpm性能调整配置
│   └── vhost.conf                          nginx vhost配置
├── docker                              定制dockerfile
│   ├── nginx
│   │   └── dockerfile
│   └── php
│       └── dockerfile
├── docker-compose.yml
├── makefile
├── runtime
│   └── log
│       └── nginx                   nginx 日志
│           ├── access.log
│           └── error.log
└── src
    └── index.php
```

## 快速跑通

1.  复制 `.env.sample` 到 `.env` 文件
2.  执行 `make` 或 `docker compose up -d` 启动
3.  访问 `http://localhost:3000`

## 基本命令

```bash
# 启动
make
# or
make up

# 重新编译启动
make build-up

# 停止
make down

# 进入 nginx 终端
make nginx-sh

# nginx 重载
make nginx-reload

# nginx 测试
make nginx-test

# 查看 nginx 访问日志
make logs

# 进入 php 终端
make php-sh

# php-fpm 服务存在
make php-reload

# 申请 ssl 正式并配置到 nginx 上
make ssl-apply

# 续签 ssl 证书
make ssl-renew
```

## SSL 证书管理

通常我们一台服务器会需要部署多个服务, 所以我个人不建议一个服务独占 `80/443` 端口

所以建议服务映射固定高位端口 (如: `10080` `3000`), 由宿主机的 `nginx` 反向代理绑定域名设置 `SSL` 证书

> 最佳实践: 如果你一台服务器仅部署一个项目, 可以使用 `make ssl-apply` 申请证书, 记得在 `docker-compose.yml` 中映射 `443` 端口

在此宿主机除了需要安装一个 `nginx` 以外, 还需要安装 `certbot` 来完成 `let's encrypt` 证书管理;

### 安装 certbot

```bash
# alpine
$ sudo apk add certbot certbot-nginx

# centos 
$ sudo yum install epel-release
$ sudo yum install certbot certbot-nginx

# ubuntu
$ sudo apt-get update
$ sudo apt-get install certbot python3-certbot-nginx
```

### 申请证书

```bash
# certbot --nginx -m "邮箱" --agree-tos --no-eff-email -d 域名1 -d 域名2
$ certbot --nginx -m "yuxiaobo64@gmail.com" --agree-tos --no-eff-email -d t3.io.edk24.com
```

### 检查续签所有证书

```bash
# 每日凌晨检查所有证书并续签
$ certbot renew
```

> 最佳实践: 应写成定时任务, 每日凌晨检查所有证书并续签
> 
> `0 0 * * * certbot renew`
