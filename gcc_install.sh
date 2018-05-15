tar -xf $1
name=$(echo $1 | cut -f -3 -d.) 
cd $name
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac

mkdir -v build && cd build

../configure                 \
    --prefix=/opt/$name  \
    --disable-multilib       \
    --enable-languages=c,c++

make -j4
make install
ln -svf gcc /opt/$name/bin/cc
cd ../..
rm -rf $name
