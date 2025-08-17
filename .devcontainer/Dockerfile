# Sử dụng image Ubuntu cơ bản và ổn định cho dev container
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Chuyển sang quyền root để cài đặt phần mềm
USER root

# Cập nhật và cài đặt các gói cần thiết mà không cần hỏi
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    novnc \
    websockify \
    htop \
    nano \
    neofetch \
    # Dọn dẹp cache để giảm kích thước image
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Sao chép script khởi động vào trong container và cấp quyền thực thi
COPY vnc-startup.sh /usr/local/bin/vnc-startup.sh
RUN chmod +x /usr/local/bin/vnc-startup.sh

# Chuyển về người dùng mặc định của Codespaces để tăng cường bảo mật
USER vscode