bash
#!/bin/bash

# --- Cấu hình VNC ---
# Tạo thư mục .vnc nếu chưa tồn tại
mkdir -p ~/.vnc

# Đặt mật khẩu VNC (thay 'yourpassword' bằng mật khẩu của bạn)
# Lưu ý: Mật khẩu này sẽ được lưu trong file, hãy sử dụng secrets nếu cần bảo mật cao hơn.
echo "123456789" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Tạo file cấu hình xstartup để khởi động XFCE
cat <<EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb \$HOME/.Xresources
startxfce4 &
EOF

# Cấp quyền thực thi cho file xstartup
chmod +x ~/.vnc/xstartup

# --- Khởi động các dịch vụ ---
# Khởi động VNC server trên màn hình :1 (cổng 5901)
vncserver :1 -geometry 1280x720 -depth 24

# Tạo chứng chỉ SSL tự ký cho noVNC
openssl req -x509 -nodes -newkey rsa:2048 -keyout ~/.vnc/novnc.pem -out ~/.vnc/novnc.pem -days 3650 -subj "/C=US/ST=State/L=City/O=Organization/OU=IT/CN=codespaces"

# Khởi động websockify để kết nối noVNC với VNC server
websockify -D --web=/usr/share/novnc/ --cert=~/.vnc/novnc.pem 6080 localhost:5901

echo "VNC Server is ready! Access it on the forwarded port 6080."
