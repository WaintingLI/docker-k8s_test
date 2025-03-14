測試紀錄與遇到的問題
===


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


---
## 2025-03-13

>學習Dokcer network相關知識

```shell
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
2017cca0027d        bridge              bridge              local
1b1c05935480        host                host                local
8b9319cd142e        none                null                local
```
主要有三個模式
- bridge 會和host(實際機器上面的網路)隔開,如果外網需要連線,則在使用時,需要透過 -p來指定對接口
- host 會占用host上面的port
- None 需要手動設定網路設定


Dokcerfile
CMD 與 ENTRYPOINT
兩者一樣是啟動 container 的時候會用到，所以一樣也會有後面設定覆蓋的狀況。
差別比較像 **CMD** 如果Docker run時,有附帶CMD參數,則會被覆蓋掉先前設定的CMD;
ENTRYPOINT則是透過任意輸入Command都會附帶前面的ENTRYPOINT參數

> 詳細解釋請參考:[了解 CMD 與 ENTRYPOINT](https://ithelp.ithome.com.tw/articles/10250988)     

Bash 特殊參數 $0, $1, $2, $3 ...
>詳情請參考:[Bash技巧：介绍 $0、$1、$2、$#、$@、$*、$? 的含义](https://segmentfault.com/a/1190000021435389)
- $0
>對應 ./test.sh 這個值。如果執行的是 ./work/test.sh， 則對應 ./work/test.sh 這個值，而不是只回傳檔名本身的部分。
- $1
>會取得到 a，即 $1 對應傳給腳本的第一個參數。
- $2
>會取得到 b，即 $2 對應傳給腳本的第二個參數。
- $3
>會取得到 c，即 $3 對應傳給腳本的第三個參數。 $4、$5 等參數的意義依此類推。
- $#
>會取得到 3，對應傳入腳本的參數個數，統計的參數不包含 $0。
- $@
>會取得到 "a" "b" "c"，也就是所有參數的列表，不包含 $0。
- $*
> 也會取得到 "a" "b" "c"， 其值和 $@ 相同。但 "$*" 和 "$@" 有所不同。
> "$*" 把所有參數合併成一個字串，而 "$@" 會得到一個字串參數數組。
- $?  
>可以取得到執行 ./test.sh a b c 指令後的回傳值。  
>執行一個前台指令後，可以立即用 $? 取得到該指令的回傳值。
>這個指令可以是系統本身的指令，可以是 shell 腳本，也可以是自訂的 bash 函數。

標準輸入輸出
>詳情請參考:[2>/dev/null和>/dev/null 2>&1和2>&1>/dev/null的区别](https://blog.csdn.net/longgeaisisi/article/details/90519690)
---

## 2025-03-14

Dockerfile變數定義 **ENV** 與 **ARG**
>詳情請參考:[活用 ENV 與 ARG](https://ithelp.ithome.com.tw/articles/10251549)

ENV 的設計:
>ENV 比較容易理解，它其實就是設定 environment，因此概念上，它會是一個全域變數－－直到 docker run 的時候都還會存在的變數。

ARG 的設計:
>ARG 是一個很像 ENV 的指令，不一樣的點主要在於，它只能活在 build image 的過程裡。

※使用情境
- ENV與ARG混用:  
都是可以正常取值
- ENV與ARG撞名:  
若取一樣的名字會發現，它最後都會以 ENV 為主。
- 不同Stage下使用跨不同Stage使用或者不同Stage下有相同命名的變數:  
每個 stage 要用的 ARG 與 ENV 都需要各自定義的，因此兩個 stage 可以設定兩個同名不同值的 ENV；若兩個 stage 都使用同名的 ARG，則兩個 ARG 在 --build-arg 給值的時候都拿得到。


  
exec 模式與 shell 模式
```shell
# exec 模式
CMD ["php", "artisan", "serve"]
# shell 模式
CMD php artisan serve
```
- exec 模式:  
簡單來說，就是直接執行指令，因此會是 PID 1 process。使用 PID 1 process 的好處是，使用 docker stop 指令發出 SIGTERM 後，會是由 PID 1 process 收到，做 graceful shutdown 相容比較簡單。
- shell 模式:  
Shell 模式是透過 /bin/sh -c 執行指令，因此會先有 /bin/sh -c 的 PID 1 process，然後在底下開子 process。在這個情況下，docker stop 指令發出的 SIGTERM 信號將會由 shell 收到。


> The twelve-factor app與Docker關聯
詳細請參考:[The Twelve-Factor App](https://ithelp.ithome.com.tw/articles/10253303)

I. Codebase
II. Dependencies
III. Config
IV. Backing services
V. Build, release, run
VI. Processes
VII. Port binding
VIII. Concurrency
IX. Disposability
X. Dev/prod parity
XI. Logs
XII. Admin processes