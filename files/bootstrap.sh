#/bin/bash

set -e

if ! [ `PATH=$HOME/bin:$PATH which python` ]; then
   echo Bootstrapping Python
   PYPY_VERSION=2.4.0

   wget https://bitbucket.org/pypy/pypy/downloads/pypy-$PYPY_VERSION-linux64.tar.bz2
   tar -xf pypy-$PYPY_VERSION-linux64.tar.bz2
   ln -s pypy-$PYPY_VERSION-linux64 pypy

   ## library fixup
   mkdir pypy/lib
   ln -s /lib64/libncurses.so.5.9 $HOME/pypy/lib/libtinfo.so.5

   mkdir -p $HOME/bin

   cat > $HOME/bin/python <<EOF
#!/bin/bash
LD_LIBRARY_PATH=$HOME/pypy/lib:$LD_LIBRARY_PATH $HOME/pypy/bin/pypy "\$@"
EOF

   chmod +x $HOME/bin/python
   $HOME/bin/python --version
fi

python=`PATH=$HOME/bin:$PATH which python`
echo $python