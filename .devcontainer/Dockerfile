# Sử dụng hình ảnh Ubuntu chính thức làm nền tảng
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Chuyển sang người dùng root để cài đặt phần mềm
USER root

# Cập nhật và cài đặt các gói cần thiết
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
    # Dọn dẹp để giảm kích thước image
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Chuyển về người dùng mặc định của Codespaces
USER vscode
