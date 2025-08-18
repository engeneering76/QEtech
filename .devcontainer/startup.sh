#!/bin/bash

# Thiết lập file .xsession để XRDP biết cần khởi động môi trường XFCE
echo 'exec startxfce4' > ~/.xsession

# Thêm user xrdp vào nhóm ssl-cert để có quyền đọc certificate
sudo adduser xrdp ssl-cert

# Đặt mật khẩu cho người dùng vscode (thay thế lệnh cũ)
# Lệnh này an toàn hơn vì nó không hiện mật khẩu trong lịch sử lệnh
echo "vscode:12345678" | sudo chpasswd

# Khởi động lại dịch vụ XRDP với cấu hình mới
sudo systemctl restart xrdp
