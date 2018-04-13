set -x
SOURCE_PATH=$1

rm -rf bin
rm -rf deps
rm -rf include
rm -rf lib
rm -rf plugin
rm -rf python
rm -rf tools

cp -r $SOURCE_PATH/bin      bin
cp -r $SOURCE_PATH/deps     deps
cp -r $SOURCE_PATH/include  include
cp -r $SOURCE_PATH/lib      lib
cp -r $SOURCE_PATH/plugin   plugin
cp -r $SOURCE_PATH/python   python
cp -r $SOURCE_PATH/tools    tools

