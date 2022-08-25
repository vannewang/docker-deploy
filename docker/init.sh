# 1、安装docker
# 解压tar包
tar -zxvf docker-*.tgz
cp docker/* /usr/bin/

touch /etc/systemd/system/docker.service
cat>/etc/systemd/system/docker.service<<EOF
[Unit]

Description=Docker Application Container Engine

Documentation=https://docs.docker.com

After=network-online.target firewalld.service

Wants=network-online.target

[Service]

Type=notify

# the default is not to use systemd for cgroups because the delegate issues still

# exists and systemd currently does not support the cgroup feature set required

# for containers run by docker

ExecStart=/usr/bin/dockerd

ExecReload=/bin/kill -s HUP $MAINPID

# Having non-zero Limit*s causes performance problems due to accounting overhead

# in the kernel. We recommend using cgroups to do container-local accounting.

LimitNOFILE=infinity

LimitNPROC=infinity

LimitCORE=infinity

# Uncomment TasksMax if your systemd version supports it.

# Only systemd 226 and above support this version.

#TasksMax=infinity

TimeoutStartSec=0

# set delegate yes so that systemd does not reset the cgroups of docker containers

Delegate=yes

# kill only the docker process, not all processes in the cgroup

KillMode=process

# restart the docker process if it exits prematurely

Restart=on-failure

StartLimitBurst=3

StartLimitInterval=60s

 

[Install]

WantedBy=multi-user.target
EOF

# 赋执行权限
chmod +x /etc/systemd/system/docker.service

# 开机启动
systemctl enable docker.service

# 启动docker
systemctl start docker

# 查看docker状态
systemctl status docker

# 验证是否成功
docker --version

# 2、安装docker-compose
cp docker-compose /usr/local/bin
chmod +x /usr/local/bin/docker-compose
# 验证是否成功
docker-compose -version
