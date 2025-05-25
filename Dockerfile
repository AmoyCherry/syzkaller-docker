FROM ubuntu:22.04

# Install dependencies for syzkaller and QEMU
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    qemu-system-x86 \
    golang \
    && rm -rf /var/lib/apt/lists/*

# Clone and build syzkaller
RUN git clone https://github.com/google/syzkaller.git /syzkaller && \
    cd /syzkaller && \
    make

RUN cd /syzkaller && \
    mkdir workdir

# Copy Linux build files and scripts
COPY data/bzImage /kernel/bzImage

COPY data/image/bullseye.img /kernel/image/bullseye.img
COPY data/image/bullseye.id.rsa /kernel/image/bullseye.id.rsa
COPY data/image/bullseye.id.rsa.pub /kernel/image/bullseye.id.rsa.pub

COPY qemu.cfg /syzkaller/qemu.cfg
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Set entrypoint to run syzkaller with QEMU
ENTRYPOINT ["/run.sh"]