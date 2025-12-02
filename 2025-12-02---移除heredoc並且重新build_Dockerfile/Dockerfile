# 選擇 ubuntu的基礎映像檔
FROM ubuntu:24.04
#FROM ubuntu:18.04

#維護者
LABEL maintainer="WaitingL"

# 設置工作目錄，WORKDIR 是 Dockerfile 的指令，用來設置在容器內部用於存儲應用程式檔案的目錄。
#WORKDIR /usr/src/app
WORKDIR /root

# 首先複製build_draft.sh到工作目錄
#COPY build_draft.sh ./

# 安裝套件
# RUN 指令用於在映像檔構建階段執行命令，並創建新的層。每個 RUN 指令都會在當前映像檔的頂部創建一個新的層並提交更改，進而形成新的映像檔。
#RUN pwd
#RUN ./build_draft.sh
#RUN <<EOF
#apt-get update
#apt-get install -y curl
#EOF

#安裝工具
RUN  apt-get update -y && \
     apt-get install -y \
      iputils-ping \
      wget \
      vim \
      build-essential \
      zlib1g-dev  

#安裝開發環境
  #apt-get install -y build-essential

#RUN <<EOF
#安裝Python
#apt install software-properties-common
#add-apt-repository ppa:deadsnakes/ppa
#apt install python3.11.9
#RUN wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz && tar xzf Python-3.11.4.tgz
#RUN tar xzf Python-3.11.4.tgz
RUN wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz && tar xzf Python-3.11.4.tgz && cd Python-3.11.4/ && \
./configure --enable-optimizations && \
make -j $(nproc) && \
make install && \
rm -rf ./../Python-3.11.4 ./../Python-3.11.4.tgz /var/cache/apk/*


#RUN ./configure --enable-optimizations
#RUN make -j $(nproc)
#make altinstall
#RUN make install
#alias python="python3.11"
#RUN  apt-get update -y && apt install -y \
#python3-pip 

#apt install -y python3.12-venv
#apt-get install -y python3.12-dev python3.12-venv
#RUN cd ~
#RUN virtualenv --python="/usr/bin/python3" python-virtualenv

#移除所下載的apk
#RUN rm -rf Python-3.11.4 \
#Python-3.11.4.tgz \
#/var/cache/apk/*
RUN apt-get update -y && \
     apt-get install -y virtualenv &&\
virtualenv --python="/usr/bin/python3" python-virtualenv && \
apt clean && rm -rf /var/lib/apt/lists/*




# 複製應用程式程式碼到工作目錄
#COPY ./build_draft.sh

# 建立 Swagger 文件
#RUN npm run swagger

# 暴露應用程式所使用的端口
#EXPOSE 3000 

# 啟動您的應用程式
# CMD 指令用於指定一個容器啟動時需要執行的命令。每個 Dockerfile 只能包含一個 CMD 指令。
# 總結來說，RUN 是在構建映像檔時執行的命令，而 CMD 是在容器啟動時執行的命令。
# exec 模式，官方推薦
#CMD ["php", "artisan", "serve"]
# shell 模式
#CMD php artisan serve
