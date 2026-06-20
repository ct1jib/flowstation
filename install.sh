# this is an approache to install all the needed files for the project to work in any device
#!/bin/bash
apt update && sudo apt -y upgrade
apt install -y --no-install-recommends \
  git make g++ cmake \
  libsoapysdr-dev \
  soapysdr-tools \
  libasound2-dev \
  clang llvm-dev libclang-dev \
  limesuite liblimesuite-dev \
  limesuite-udev soapysdr-module-lms7 \
  uhd-host libuhd-dev soapysdr-module-uhd
cd /opt
git clone https://github.com/MidnightBlueLabs/tetra-bluestation
cd tetra-bluestation
git checkout main
. "$HOME/.cargo/env"
cargo build --release
cp example_config/config.toml ./config.toml
cp contrib/systemd/bluestation-bs.service /etc/systemd/system/tetra.service
# install drivers for SX
cd /opt
git clone "https://github.com/tejeez/sxxcvr.git"
cd sxxcvr/SoapySX
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig
