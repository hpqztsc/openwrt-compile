#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# 下载新主题
git clone -b master https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 增加 lienol passwall
echo "src-git lienol https://github.com/chenshuo890/lienol-openwrt-package.git" >> feeds.conf.default
# 增加 helloworld
echo "src-git helloworld https://github.com/fw876/helloworld" >> feeds.conf.default
# 增加 lede
echo "src-git lede https://github.com/coolsnowwolf/lede.git" >> feeds.conf.default
# 修正内核
rm -rf target/linux/generic
svn co https://github.com/project-openwrt/openwrt/branches/master/target/linux/generic target/linux/generic
# 修改 dnsmasq 为 dnsmasq-full
sed -i 's/dnsmasq i/dnsmasq-full i/g' include/target.mk
# 增加自定义配置
sed -i 's/base-files.*/default-settings &/' include/target.mk
sed -i 's/default-settings.*/& luci-app-samba autosamba/' include/target.mk
# 修改文件句柄数
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

sed -i '$a src-git smallpackage https://github.com/kenzok8/small-package' feeds.conf.default
#sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
#sed -i '$a src-git jell https://github.com/kenzok8/jell' feeds.conf.default
