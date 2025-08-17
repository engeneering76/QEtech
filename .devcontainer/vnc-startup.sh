#!/bin/bash

# Kiểm tra xem VNC server đã chạy chưa bằng cách tìm file lock
if [ -f /tmp/.X1-lock ]; then
  echo "VNC server đã đang chạy."
else
  echo "Đang khởi động VNC server..."
  # Xóa các file lock cũ nếu có để tránh lỗi
  rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

  # Khởi động VNC server trên màn hình :1, với độ phân giải và độ sâu màu cụ thể
  # Mật khẩu sẽ được đọc từ ~/.vnc/passwd
  vncserver :1 -geometry 1280x800 -depth 24
fi

# Kiểm tra xem websockify đã chạy chưa
if pgrep -f "websockify" > /dev/null; then
  echo "noVNC gateway (websockify) đã đang chạy."
else
  echo "Đang khởi động noVNC gateway..."
  # Đường dẫn đến file chứng chỉ SSL
  CERT_PATH=~/.vnc/novnc.pem
  
  # Tạo chứng chỉ SSL nếu chưa tồn tại
  if [ ! -f "$CERT_PATH" ]; then
    echo "Tạo chứng chỉ SSL cho noVNC..."
    openssl req -x509 -nodes -newkey rsa:2048 -keyout "$CERT_PATH" -out "$CERT_PATH" -days 3650 -subj "/C=US/ST=CA/L=SF/O=GitHub/OU=Codespaces/CN=localhost"
  fi

  # Khởi động websockify ở chế độ nền
  websockify -D --web=/usr/share/novnc/ --cert="$CERT_PATH" 6080 localhost:5901
fi

echo "Hoàn tất! Môi trường Desktop đã sẵn sàng."
