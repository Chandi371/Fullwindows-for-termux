#!/bin/bash

# ███████╗██╗   ██╗███████╗ █████╗ ██╗   ██╗███████╗████████╗
# ██╔════╝██║   ██║██╔════╝██╔══██╗██║   ██║██╔════╝╚══██╔══╝
# ███████╗██║   ██║███████╗███████║██║   ██║███████╗   ██║   
# ╚════██║██║   ██║╚════██║██╔══██║██║   ██║╚════██║   ██║   
# ███████║╚██████╔╝███████║██║  ██║╚██████╔╝███████║   ██║   
# ╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   
#      HEAVIEST WINDOWS-LIKE ENVIRONMENT FOR TERMUX
#    With MATE, Wine, Box86/Box64 & Full Dependencies
# -----------------------------------------------------------

# Clear the terminal for a clean start
clear

# STEP 1: UPDATE & UPGRADE PACKAGES
echo "Updating Termux packages..."
apt update && apt upgrade -y
clear

# STEP 2: INSTALL REQUIRED REPOSITORIES
echo "Installing repositories..."
pkg install x11-repo -y
pkg install tur-repo -y
clear

# STEP 3: INSTALL PROOT-DISTRO & SET UP DEBIAN
echo "Installing proot-distro and setting up Debian..."
pkg install proot-distro -y
proot-distro install debian
clear

# STEP 4: LOG INTO DEBIAN AND INSTALL EVERYTHING INSIDE
echo "Entering Debian and installing MATE, Wine, Box86/Box64, and Steam..."
proot-distro login debian --shared-tmp -- bash -c "
apt update && apt upgrade -y
apt install -y mate-desktop-environment mate-terminal pcmanfm thunar 

# ENABLE i386 ARCHITECTURE
dpkg --add-architecture i386
apt update

# INSTALL VNC SERVER
apt install tigervnc-standalone-server -y

# INSTALL WINE
apt install wine -y

# INSTALL BOX86 & BOX64
apt install box86 box64 -y

# INSTALL XDG UTILS FOR DOUBLE-CLICK SUPPORT
apt install xdg-utils -y

# SETTING UP DOUBLE-CLICK SUPPORT FOR .EXE FILES
echo '[Desktop Entry]' > ~/.local/share/applications/wine.desktop
echo 'Name=Wine Windows Program Loader' >> ~/.local/share/applications/wine.desktop
echo 'Exec=wine %f' >> ~/.local/share/applications/wine.desktop
echo 'Type=Application' >> ~/.local/share/applications/wine.desktop
echo 'MimeType=application/x-ms-dos-executable;' >> ~/.local/share/applications/wine.desktop
chmod +x ~/.local/share/applications/wine.desktop
xdg-mime default wine.desktop application/x-ms-dos-executable

# INSTALL STEAM
wget -O steamsetup.exe https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe
wine steamsetup.exe

# CONFIGURE VNC SERVER FOR MATE
mkdir -p ~/.vnc
echo '#!/bin/bash' > ~/.vnc/xstartup
echo 'export DISPLAY=:1' >> ~/.vnc/xstartup
echo 'export XDG_RUNTIME_DIR=/tmp' >> ~/.vnc/xstartup
echo 'mate-session &' >> ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

echo 'Pre-installed apps added: CMD, Notepad, File Manager, Steam'
clear
"

# STEP 5: FIX NETWORK ISSUES
echo "Fixing potential network issues..."
echo 'nameserver 8.8.8.8' > /data/data/com.termux/files/usr/etc/resolv.conf
clear

# STEP 6: START DEBIAN & VNC SERVER
echo "Starting Debian and VNC Server..."
proot-distro login debian --shared-tmp -- vncserver
clear

# FINAL MESSAGE
echo "Setup complete! You can now connect to your MATE desktop using a VNC viewer."
echo "Run the following command anytime to start your GUI:"
echo "    proot-distro login debian --shared-tmp -- vncserver"
echo "To run Windows apps, just double-click the .exe file in MATE!"
echo "To open CMD, run: wineconsole cmd"
clear
