FROM base/archlinux:latest
MAINTAINER james.s.spencer@gmail.com
RUN pacman -Syu --noconfirm gcc make yajl salt git sudo pkg-config fakeroot
RUN source /etc/profile.d/perlbin.sh && \
    cd /tmp && \
    git clone https://aur.archlinux.org/cower.git && \
    chmod o+w cower && \
    cd cower && \
    sudo -u nobody makepkg --skippgpcheck && \
    pacman -U --noconfirm cower*pkg.tar.xz
RUN git clone https://github.com/jsspencer/james.sls.git /srv/salt
RUN pacman -Syu --noconfirm && \
    salt-call --log-level info --local state.apply basic,cower,dev
