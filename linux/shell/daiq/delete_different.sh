function delete_diff_log()
{
rm -rf ~/diff.txt
#mkdir ~/diff -p
mypath=`cat .repo/project.list`
echo $mypath
for myp in $mypath
do
pushd $myp

rm gjb_193503a_v002 gjb_1930_v001 sha-gjb_193503a_v002 sha-gjb_1930_v001

popd
done
}


