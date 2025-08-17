## Script install Desktop and VNC to Github Codespaces! (xfce4) (sources: https://www.youtube.com/watch?v=jncuv4FcBLc)
	sudo apt update -y
	sudo apt install xfce4 xfce4-goodies novnc python3-websockify python3-numpy tightvncserver htop nano neofetch -y	-> chọn 35 English US -> chon 1 cho keylayout
	openssl req -x509 -nodes -newkey rsa:3072 -keyout novnc.pem -out novnc.pem -days 3650	-> chon ten Quoc gia mac dinh bang cach nhan nut Enter 8 lan
	USER=root vncserver	-> chay VNC server với quyền root -> nhap password moi -> chon n de khong show password
	mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
	sudo apt install nano
	nano ~/.vnc/xstartup	-> terminal chuyen sang cua so moi GNU nano 4.8 -> copy ca 3 dong code dan vao cua so moi mo
		#!/bin/bash
		xrdb $HOME/.Xresources
		startxfce4 &	-> Nhấn Ctrl + S -> sau đó nhấn Ctrl+X để thoát (nhu huong dan o duoi cung cua so terminal)
	chmod +x ~/.vnc/xstartup	-> tao file executable
	USER=root vncserver	-> chuyen sang cua so PORTs de truy cap forwarding port
	htop	-> tuong tu nhu Task Manager cua Win10 -? nhan F10 đe thoat
	websockify -D --web=/usr/share/novnc/ --cert=/home/ubuntu/novnc.pem 6080 localhost:5901	-> sang PORTs chon port 6080 -> chon cong 5901 -> vao thu muc vnc.html de su dung Ubuntu VPS
  _________________________________________
	#!/bin/bash
	xrdb $HOME/.Xresources
	startxfce4 &
  _________________________________________

## Setup Quantum Expresso va tool






