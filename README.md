# Docker开发环境

这是一个集成了MySQL 8.0、Python 3.11、Node.js、Yarn和Redis的Docker开发环境。

## 目录结构

```
.
├── app/                  # 应用代码目录
├── config/               # 配置文件目录
│   ├── my.cnf            # MySQL配置
│   └── redis.conf        # Redis配置
├── data/                 # 数据持久化目录
│   ├── mysql/            # MySQL数据
│   └── redis/            # Redis数据
├── .env                  # 环境变量
├── docker-compose.yml    # Docker Compose配置
├── Dockerfile            # 开发环境Dockerfile
└── README.md             # 说明文档
```

## 快速开始

### 启动环境

```bash
docker-compose up -d
```

### 进入开发环境容器

```bash
docker-compose exec dev-env bash
```

### 停止环境

```bash
docker-compose down
```

## 服务访问信息

### MySQL

- **主机**: localhost
- **端口**: 3306
- **用户名**: devuser
- **密码**: devpassword
- **数据库**: devdb
- **Root密码**: rootpassword

### Redis

- **主机**: localhost
- **端口**: 6379
- **密码**: redispassword

## 开发环境

开发环境容器包含以下工具:

- Python 3.11
- Node.js
- Yarn
- Git
- 基本构建工具

## 依赖管理

### Python依赖

项目的Python依赖在`requirements.txt`文件中管理。该文件已经挂载到容器中，因此您可以轻松地更新依赖。

#### 添加新依赖

1. 编辑`requirements.txt`文件，添加您需要的依赖
2. 在容器内运行以下命令安装新依赖:

```bash
pip install -r /requirements.txt
```

#### 更新依赖

如果您修改了`requirements.txt`文件，可以在容器内运行以下命令更新依赖:

```bash
pip install --upgrade -r /requirements.txt
```

#### 导出当前依赖

如果您在开发过程中安装了新的依赖，可以将它们导出到`requirements.txt`文件:

```bash
pip freeze > /requirements.txt
```

## 自定义配置

可以通过修改以下文件来自定义配置:

- `.env`: 环境变量
- `config/my.cnf`: MySQL配置
- `config/redis.conf`: Redis配置
- `Dockerfile`: 开发环境配置

## 数据持久化

所有数据都存储在`data/`目录中:

- MySQL数据: `data/mysql/`
- Redis数据: `data/redis/`