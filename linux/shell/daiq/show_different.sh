function show_diff_log()
{
rm -rf ~/diff.txt
#mkdir ~/diff -p
mypath=`cat .repo/project.list`
echo $mypath
for myp in $mypath
do
pushd $myp
git log --pretty=format:"%an,%aE:%s" caf/gjb_193503a_v002 |grep -E 'gosomo.cn|icebergbsd@gmail.com|unifront.com.cn' > gjb_193503a_v002
git log --pretty=format:"%an,%aE:%s" caf/gjb_1930_v001 |grep -E 'gosomo.cn|icebergbsd@gmail.com|unifront.com.cn' > gjb_1930_v001
cmp gjb_193503a_v002 gjb_1930_v001
if [ $? = 0 ]; then
echo "no diff log"
else
echo "pls check differences  with beyong compare , for all path of file ~/Desktop/diff.txt !"
echo $myp >> ~/diff.txt
git log --pretty=format:"%h-%an,%aE:%s" caf/gjb_193503a_v002 |grep -E 'gosomo.cn|icebergbsd@gmail.com|unifront.com.cn' > sha-gjb_193503a_v002
git log --pretty=format:"%h-%an,%aE:%s" caf/gjb_1930_v001 |grep -E 'gosomo.cn|icebergbsd@gmail.com|unifront.com.cn' > sha-gjb_1930_v001

fi
popd
done
}


