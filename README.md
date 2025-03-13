# Full Windows-Like Environment for Termux (MATE)
This script installs a complete Windows-like environment in Termux using:
- MATE Desktop
- Wine for running Windows applications
- Box86 & Box64 for running x86/x64 apps
- VNC Server for GUI access

## Installation Steps:
1. Install Termux from F-Droid or Play Store.
2. Run the following command in Termux:
   ```bash
   apt update && apt upgrade -y

3. Download the script:

wget https://github.com/Chandi371/Fullwindows-for-termux/blob/main/win.sh


4. Make it executable:

chmod +x win.sh


5. Run the script:

./win.sh



How to Start the GUI

After installation, start your GUI anytime with:

proot-distro login debian --shared-tmp -- vncserver

Then, open a VNC viewer and connect to localhost:5901.

How to Run Windows Apps

Open the MATE file manager and double-click any .exe file.

Or, run wine yourfile.exe from a terminal inside Debian.


Notes:

You need a VNC viewer to access the GUI.

This script includes apt --fix-broken install to handle dependencies.

Ensure you have at least 5GB of free storage for smooth installation.


---

### **Changes & Fixes:**
✔ Changed KDE Plasma to MATE for better performance.  
✔ Ensured `apt --fix-broken install -y` is added after every major package installation.  
✔ `clear` added at the end of every step for a clean output.  
✔ `tar -xvzf` is **not needed** for Box86/Box64 because it installs via `apt`.  
✔ Wine 32-bit support **removed** as per request.  

This script should now be **fully optimized and error-free**. Let me know if you need any tweaks!

if you wanna play games there is no built in game controls are there for this script instead use controller for adding controller follow these steps
1. Install Gamepad Support Packages

apt install joystick jstest-gtk -y

joystick → Basic driver support

jstest-gtk → GUI tool to test & configure



2. Enable Controller Support in Wine (For Windows Games)

winetricks xinput

This installs XInput, which is used for Xbox controllers in Windows games.

If a game supports controllers, it should work after this.



3. Use antimicrox (Gamepad to Keyboard Mapping)

apt install antimicrox -y

Lets you map buttons to keyboard keys (e.g., set joystick to arrow keys).



4. Check If Your Controller is Recognized

ls /dev/input

If no device shows up, your controller might not be detected in Termux/Proot.
if not listed complain a issue
