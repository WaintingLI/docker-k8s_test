### 測試紀錄與遇到的問題


20250308 找到如何在Ubuntu:24.04上成功安裝Python 與 其虛擬環境

20250310 由於使用Docker build 時,會遇到apt update無法解析問題,找了很多方法,如修改resolv.conf,但最終失敗;
最後由"https://medium.com/@faithfulanere/solved-docker-build-could-not-resolve-archive-ubuntu-com-apt-get-fails-to-install-anything-9ea4dfdcdcf2"
提供的創見"/etc/docker/daemon.json",並且添加
{
    "dns": ["192.10.0.2", "8.8.8.8"]
}
後,再"sudo service docker restart",就可以再Docker Build時,解決DNS問題