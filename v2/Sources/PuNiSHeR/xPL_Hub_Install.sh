wget http://www.xpl4java.org/xPL4Linux/downloads/xPLLib.tgz
tar xvzf xPLLib.tgz
cd xPLLib
make
sudo make install
cd examples/
make
sudo cp xPL_Hub  xPL_Logger /usr/local/bin
 
/usr/local/bin/xPL_Hub
