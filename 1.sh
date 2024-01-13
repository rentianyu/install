
# c='arg1'
# PKG=com.fooview.android.fooview

c='{lv=Shizuku-in}'
PKG=com.termux


if [ -d /storage/emulated/0/shizuku ]; then
PKG=com.arlosoft.macrodroid
dir=/data/data/$PKG/files
r=$dir/rish
d=$dir/rish_shizuku.dex
mv -f /sdcard/shizuku/* $dir
sed -i "s/PKG/$PKG/" $r
chmod 400 $d
{ [ -f $r ] && [ -f $d ] } && echo "Shizuku 已安装"
else
echo 文件夹不存在,请新建！
fi

mv -f /sdcard/shizuku/rish /data/data/com.arlosoft.macrodroid/files/
mv -f /sdcard/shizuku/rish_shizuku.dex /data/data/com.arlosoft.macrodroid/files/
sed -i "s/PKG/com.arlosoft.macrodroid/" /data/data/com.arlosoft.macrodroid/files/rish
chmod 400 /data/data/com.arlosoft.macrodroid/files/rish_shizuku.dex


cd /storage/emulated/0/Android/data/com.arlosoft.macrodroid/files/&&
rm -f ./rish* &&
mv -f /sdcard/shizuku/rish ./&&
mv -f /sdcard/shizuku/rish_shizuku.dex ./&&
sed -i "s/PKG/com.arlosoft.macrodroid/" ./rish&&
chmod 400 ./rish_shizuku.dex&&
cat ./rish
