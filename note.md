# 測試紀錄與遇到的問題


## 2025-03-08
> 找到如何在Ubuntu:24.04上成功安裝Python 與 其虛擬環境
- Linux 使用Virtualenv來建立Python 執行環境,請參考[Unable to locate package virtualenv in ubuntu](https://stackoverflow.com/questions/28256891/unable-to-locate-package-virtualenv-in-ubuntu-13-on-a-virtual-machine)
- 在Linux如何完全移除Python,請參考[How to make a complete removal of Python 3.9 in Ubuntu 16.04](https://askubuntu.com/questions/1292504/how-to-make-a-complete-removal-of-python-3-9-in-ubuntu-16-04)

```shell{.line-numbers}
sudo apt-get clean
sudo apt-get autoremove --purge
sudo apt-get remove python3.9
sudo apt-get autoremove
```
- Linux安裝Python3,請參考:[Ubuntu22.04安装python3.12](https://blog.csdn.net/qq_39656068/article/details/137819957)
---
## 2025-03-10 
>由於使用Docker build 時,會遇到apt update無法解析問題,找了很多方法,如修改resolv.conf,但最終失敗;
最後由"[SOLVED: Docker build “Could not resolve ‘archive.ubuntu.com’” apt-get fails to install anything](https://medium.com/@faithfulanere/solved-docker-build-could-not-resolve-archive-ubuntu-com-apt-get-fails-to-install-anything-9ea4dfdcdcf2)"
提供的創見"/etc/docker/daemon.json",並且添加
```json
{
    "dns": ["192.10.0.2", "8.8.8.8"]
}
```
> 後,再"sudo service docker restart",就可以再Docker Build時,解決DNS問題
**關於 daemon.json解說**請參考:[【Docker】daemon.json的作用（八）](https://blog.csdn.net/u013948858/article/details/79974796)
- psycopg2 
> 由於安裝psycopg2遇到問題,才知道還需要額外安裝" apt install libpq-dev python3-dev"
參考資料:[How to install psycopg2 with pg_config error?](https://stackoverflow.com/questions/35104097/how-to-install-psycopg2-with-pg-config-error)

- Dockfile撰寫

參考原官方說明:[Dockerfile reference](https://docs.docker.com/reference/dockerfile/#run)
IThome:[了解 CMD 與 ENTRYPOINT](https://ithelp.ithome.com.tw/articles/10250988)

---

## 2025-03-12
>嘗試減少Docker Build後的Image大小
參考網站:[最佳化 Dockerfile - 精簡 image](https://ithelp.ithome.com.tw/articles/10246952)

