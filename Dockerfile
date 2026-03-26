FROM ubuntu:22.04

# Basic tools aur SSH install karein
RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    wget \
    git \
    sudo \
    iputils-ping \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Tailscale install karein
RUN curl -fsSL https://tailscale.com/install.sh | sh

# SSH directory aur Root password set karein
RUN mkdir /var/run/sshd
# 'yourpassword' ko apne pasand ke password se badal dein
RUN echo 'root:gg-gamer-786' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Start script copy karein
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Port 22 expose karein (Railway iska use internal karega)
EXPOSE 22

CMD ["/bin/bash", "/start.sh"]
