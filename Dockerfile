FROM cviebig/arch-build

RUN pacman -S --noprogressbar --noconfirm opencl-headers ocl-icd && \
    mkdir -v -p /var/abs/local && \
    cd /var/abs/local && \
    git clone https://aur.archlinux.org/clinfo.git && \
    git clone https://github.com/cviebig/arch-aur-clpeak-git.git clpeak && \
    useradd -ms /bin/bash build || true && \
    chown -R build:build /var/abs/local && \
    chmod -R 744 /var/abs/local && \
    su -c "cd /var/abs/local/clinfo && makepkg" - build && \
    su -c "cd /var/abs/local/clpeak && makepkg" - build && \
    pacman -U --noconfirm /var/abs/local/clinfo/clinfo-*-x86_64.pkg.tar.xz && \
    pacman -U --noconfirm /var/abs/local/clpeak/clpeak-*-x86_64.pkg.tar.xz && \
    rm -rf /var/abs/local/* && \
    pacman -Scc --noconfirm
