# wireless

## wpasupplicant

```
apt install wpasupplicant
# wpa_supplicant -i interface -c <(wpa_passphrase your_SSID your_key)
```

## iw

```
apt install iw
yay -S iw
```

```
# 帮助
# iw help

# 获得所有设备的功能，如带宽信息（2.4GHz，和5GHz），和802.11n的信息
# iw list

# 扫描
# iw dev wlan0 scan

# 监听事件 
# iw event

# 获得链路状态 
# iw dev wlan0 link

# 连接到已禁用加密的AP，这里它的SSID是foo 
# iw wlan0 connect foo

# 假设你有两个AP SSID 都是 foo ，你知道你要连接的是在 2432 频道
# iw wlan0 connect foo 2432

# 连接到使用WEP的AP
# iw wlan0 connect foo keys 0:abcde d:1:0011223344

# 获取station 的统计信息
# iw dev wlan1 station dump

# 获得station对应的peer统计信息
# iw dev wlan1 station get

# 修改传输比特率 
# iw wlan0 set bitrates legacy-2.4 12 18 24

# 修改tx HT MCS的比特率 
# iw dev wlan0 set bitrates mcs-5 4

# iw dev wlan0 set bitrates mcs-2.4 10  

# 清除所有 tx 比特率和设置的东西来恢复正常
# iw dev wlan0 set bitrates mcs-5

# 设置传输功率
# iw dev  set txpower  []

# 设置传输功率
# iw phy  set txpower  []

# 设置省电模式
# iw dev wlan0 set power_save on

# 查询当前的节电设定
# iw dev wlan0 get power_save

# 添加一个 monitor 接口
# iw phy phy0 interface add moni0 type monitor
```

```
iwlist wlan0 scan
```

## network-manager

```
apt install network-manager
```

vi /etc/NetWorkManager/NetWorkManager.conf

```
[ifupdown]
managed=true
``` 

``` 
systemctl restart network-manager
nmcli device wifi connect SSID password password ifname wlan1 profile_name
```
