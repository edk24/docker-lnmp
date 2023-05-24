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
http://localhost:3001
```

## 目录结构

```bash
.
├── README.md
├── config                          配置文件
│   ├── php-fpm.conf                    fpm配置
│   └── vhost.conf                      nginx配置
├── docker-compose.yml
├── dockerfile                      dockerfile
├── makefile
├── runtime                         运行时目录
│   └── log                             日志
│       └── nginx                           nginx日志
│           ├── access.log
│           └── error.log
└── src                             网站目录 (可以自己修改 .env 中的 APP_PATH)
    └── index.php
```

## 快速跑通

1.  复制 `.env.sample` 到 `.env` 文件
2.  执行 `make` 或 `docker-compose up -d` 启动
3.  访问 `http://localhost:3001`

## 基本命令

```bash
# 启动
$ make

# 停止
$ make down

# 重新编译 dockerfile 并启动
$ make buildup

# 验证 nginx
$ make test

# 重载 nginx 配置
$ make reload

# 查看 nginx 日志
$ make log

# 进入 nginx 容器终端
$ make sh

# 启动 redis cli 终端
$ make redis
```
