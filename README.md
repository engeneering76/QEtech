# Script install Desktop and VNC to Github Codespaces! (xfce4)

## CÀI ĐẶT
### CODE CÀI ĐẶT
# #!/bin/bash
echo "--- Dang cap nhat he thong va cai dat cac goi can thiet... ---"


sudo apt-get update -y


sudo apt-get install -y xfce4 xfce4-goodies dbus-x11 tigervnc-standalone-server novnc websockify


echo "--- Dang cau hinh VNC Server... ---"


mkdir -p ~/.vnc


echo "--- Vui long nhap mat khau VNC (it nhat 6 ky tu). Ban se khong thay ky tu khi go. ---"


tigervncpasswd


cat <<EOF > ~/.vnc/xstartup


# #!/bin/bash


unset SESSION_MANAGER


unset DBUS_SESSION_BUS_ADDRESS


exec /usr/bin/startxfce4


chmod +x ~/.vnc/xstartup


echo "--- Dang khoi dong VNC Server... ---"


tigervncserver -kill :1 >/dev/null 2>&1 || true


tigervncserver -localhost no -geometry 1280x720 -depth 24 :1


echo "--- Dang khoi dong Web Interface (noVNC)... ---"


websockify -D --web=/usr/share/novnc/ 6080 localhost:5901


echo "--- KHOI TAO HOAN TAT! ---"


echo "--- Cua so 'PORTS' se tu dong mo ra. Hay chuyen trang thai cua cong 6080 sang Public (Bieu tuong hinh trai dat)."


echo "--- Sau do, nhan vao bieu tuong 'Mo trong Trinh duyet' (Hinh vuong co mui ten) de truy cap VPS."


## GIẢI THÍCH CODE
<details>
<blockquote>
# #!/bin/bash

# # --- Phần 1: Cài đặt các gói cần thiết ---
echo "--- Dang cap nhat he thong va cai dat cac goi can thiet... ---"
sudo apt-get update -y
sudo apt-get install -y xfce4 xfce4-goodies dbus-x11 tigervnc-standalone-server novnc websockify

# # --- Phần 2: Cấu hình VNC Server ---
echo "--- Dang cau hinh VNC Server... ---"
# # Tạo thư mục cấu hình VNC nếu chưa có
mkdir -p ~/.vnc

# # Thiết lập mật khẩu VNC
echo "--- Vui long nhap mat khau VNC (it nhat 6 ky tu). Ban se khong thay ky tu khi go. ---"
tigervncpasswd

# # Tạo file cấu hình xstartup để khởi động XFCE4
cat <<EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb \$HOME/.Xresources
startxfce4 &
EOF

# # Cấp quyền thực thi cho file xstartup
chmod +x ~/.vnc/xstartup

# # --- Phần 3: Khởi động VNC và Web Server ---
echo "--- Dang khoi dong VNC Server... ---"
# # Dọn dẹp các phiên VNC cũ nếu có
tigervncserver -kill :1 >/dev/null 2>&1 || true
# # Khởi động phiên VNC mới trên màn hình :1 (cổng 5901)
tigervncserver -localhost no -geometry 1280x720 -depth 24 :1

echo "--- Dang khoi dong Web Interface (noVNC)... ---"
# # Khởi động websockify để kết nối trình duyệt với VNC
# # Lắng nghe trên cổng 6080 và chuyển tiếp tới cổng VNC 5901
websockify -D --web=/usr/share/novnc/ 6080 localhost:5901

echo "--- KHOI TAO HOAN TAT! ---"
echo "--- Cua so 'PORTS' se tu dong mo ra. Hay chuyen trang thai cua cong 6080 sang Public (Bieu tuong hinh trai dat)."
echo "--- Sau do, nhan vao bieu tuong 'Mo trong Trinh duyet' (Hinh vuong co mui ten) de truy cap VPS." '
</blockquote>
</details>

  
## SỬA LẠI FILE CẤU HÌNH STARTUP  
	nano ~/.vnc/xstartup
		#!/bin/bash
		unset SESSION_MANAGER
		unset DBUS_SESSION_BUS_ADDRESS
		exec /usr/bin/startxfce4
	-> Lưu file và thoát nano: Ctrl + X -> Y -> Enter.
 	tigervncserver -localhost no -geometry 1280x720 -depth 24 :1
 	websockify -D --web=/usr/share/novnc/ 6080 localhost:5901 

 	Có thể dùng nano để sửa file starup như sau:
  	nano ~/.vnc/xstartup
 		#!/bin/bash
		#
		# Start XFCE4 Desktop Environment
		#
		# Unset problematic session variables
			unset SESSION_MANAGER
			unset DBUS_SESSION_BUS_ADDRESS
		# Load resources
		[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
		# Start a new D-Bus session for this VNC instance
		eval $(dbus-launch --sh-syntax)
		# Start the main XFCE4 session
		startxfce4 &
	-> Lưu file và thoát nano: Ctrl + X -> Y -> Enter.
  	tigervncserver -localhost no -geometry 1280x720 -depth 24 :1
 	websockify -D --web=/usr/share/novnc/ 6080 localhost:5901


## CHECK VNC SERVER CÓ CHẠY
  	ps aux | grep Xtigervnc	-> Có dòng Xtigervnc :1 ... là VNC server đang chạy
   	cat ~/.vnc/*.log	-> tìm các dòng có chữ "Error" hoặc "Fatal" để xem lỗi

 
## DỪNG LẠI TẤT CẢ DỊCH VỤ ĐÃ CÀI
	tigervncserver -kill :1
	pkill websockify
	tigervncserver -localhost no -geometry 1280x720 -depth 24 :1
 	websockify -D --web=/usr/share/novnc/ 6080 localhost:5901

  
## XEM PHIÊN BẢN UBUNTU
	lsb_realese -a

 
### Tat VPS khi su dung xong

### Khởi chạy lại VPS khi cần
	tigervncserver -localhost no -geometry 1280x720 -depth 24 :1
 	websockify -D --web=/usr/share/novnc/ 6080 localhost:5901
  
# INSTALL QUANTUM ESPRESSO AND DFT, SCF TOOL






