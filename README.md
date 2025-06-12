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

## 源代码挂载与开发工作流程

Docker容器已配置为支持挂载多个源代码目录，使您可以在容器内同时处理多个项目：

```yaml
volumes:
  # 源码挂载 - 可以添加多个源码目录
  - /home/binyang/RuoYi-Vue3-FastAPI:/workspace/RuoYi-Vue3-FastAPI
  # - /path/to/another/project:/workspace/another-project
  # - /path/to/third/project:/workspace/third-project
environment:
  # 设置默认项目目录，可以根据需要修改
  - DEFAULT_PROJECT=RuoYi-Vue3-FastAPI
```

### 配置多个源码目录

要添加更多源码目录，只需在`docker-compose.yml`文件中的`volumes`部分添加新的挂载配置：

```yaml
volumes:
  - /path/to/your/project:/workspace/project-name
```

格式为：`宿主机路径:容器内路径`

### 设置默认项目

您可以通过修改`DEFAULT_PROJECT`环境变量来设置容器启动时自动进入的项目目录：

```yaml
environment:
  - DEFAULT_PROJECT=project-name
```

其中`project-name`应与容器内的项目目录名称匹配（即`/workspace/`后面的部分）。

### 开发工作流程

1. 启动Docker容器：
   ```bash
   docker-compose up -d
   ```

2. 进入容器：
   ```bash
   docker-compose exec dev bash
   ```

3. 在容器内，您将自动进入默认项目目录（由`DEFAULT_PROJECT`环境变量指定）。

4. 切换项目：
   ```bash
   cd /workspace/another-project
   ```

5. 查看所有可用项目：
   ```bash
   ls -la /workspace
   ```

6. 所有在容器内对源代码的修改都会实时同步到宿主机，反之亦然。

### 添加新项目

要添加新项目，请按照以下步骤操作：

1. 编辑`docker-compose.yml`文件，添加新的源码目录挂载：
   ```yaml
   volumes:
     - /path/to/new/project:/workspace/new-project
   ```

2. 如果希望将新项目设为默认项目，修改环境变量：
   ```yaml
   environment:
     - DEFAULT_PROJECT=new-project
   ```

3. 重启容器以应用更改：
   ```bash
   docker-compose down
   docker-compose up -d
   ```

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