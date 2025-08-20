# Script install Desktop and VNC to Github Codespaces! (xfce4) (sources: https://www.youtube.com/watch?v=jncuv4FcBLc)
## Install
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
## Cách khác tạo VPS Ubuntu
### Tạo file .devcontainer/docker-compose.yml có nội dung
	version: '3'
	services:
  		app:
    	image: lscr.io/linuxserver/webtop:ubuntu-xfce
    	container_name: webtop
   		environment:
      		- PUID=1000
      		- PGID=1000
      		- TZ=Etc/UTC
      		- SUBFOLDER=/ # Thêm dòng này để Webtop chạy trên thư mục gốc của domain
    volumes:
      		- ./config:/config
    ports:
      		- 3000:3000
      		- 3389:3389
    	shm_size: '1gb'
    	restart: unless-stopped # Thêm dòng này để container tự khởi động lại khi có lỗi
### Tạo file .devcontainer/devcontainer.json có nội dung 
	{
    	"name": "Webtop VPS",
    	"dockerComposeFile": "docker-compose.yml",
    	"service": "app",
    	"workspaceFolder": "/config",
    	"forwardPorts": [3000, 3389],
    	"portsAttributes": {
        	"3000": {
            	"label": "Desktop (Web)"
        	},
        	"3389": {
            	"label": "RDP"
        	}
    	},
    	"remoteUser": "root",
    	"postCreateCommand": "sudo chown -R 1000:1000 ./config"
		}
### Tạo codespace và máy ảo Ubuntu VPS
### Kiểm tra log của container
		Xem log: docker logs webtop	-> tìm theo keyword [error], [warn], permission denied
 		Xem log realtime: docker logs -f webtop
### Tat VPS khi su dung xong
	docker-compose stop	
	docker-compose down	(docker-compose down -v) sẽ xóa cả volume (./config))
### Khởi chạy lại VPS khi cần
	docker-compose start
	docker-compose up -d
# Setup Quantum Expresso va tool






