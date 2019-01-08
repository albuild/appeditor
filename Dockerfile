FROM amazonlinux:2.0.20181114

ARG version
ARG target_version
ARG target_version_minor

RUN yum -y update
RUN amazon-linux-extras install -y epel
RUN yum -y install \
  gettext-devel \
  gtk3-devel \
  meson \
  python3 \
  rpm-build \
  vala
RUN curl -O http://dl.fedoraproject.org/pub/fedora/linux/releases/29/Everything/x86_64/os/Packages/g/granite-5.1.0-1.fc29.x86_64.rpm
RUN yum -y install granite-5.1.0-1.fc29.x86_64.rpm
RUN curl -O http://dl.fedoraproject.org/pub/fedora/linux/releases/29/Everything/x86_64/os/Packages/g/granite-devel-5.1.0-1.fc29.x86_64.rpm
RUN yum -y install granite-devel-5.1.0-1.fc29.x86_64.rpm

RUN mkdir /app
WORKDIR /app

RUN curl -LO https://github.com/donadigo/appeditor/archive/$target_version.tar.gz
RUN tar xzf $target_version.tar.gz

WORKDIR /app/appeditor-$target_version
RUN meson build

WORKDIR /app/appeditor-$target_version/build
RUN meson configure -Dprefix=/usr
RUN ninja-build
RUN DESTDIR=/dest ninja-build install

RUN mkdir -p /dest/opt/albuild-appeditor/$version
WORKDIR /dest/opt/albuild-appeditor/$version
RUN mkdir bin
RUN mkdir lib
RUN mv /dest/usr/bin/com.github.donadigo.appeditor bin
RUN cp /usr/lib64/libgranite.so.5 lib
RUN cp /usr/lib64/libgee-0.8.so.2 lib
ADD com.github.donadigo.appeditor /dest/usr/bin
RUN sed -i "s,{{VERSION}},$version," /dest/usr/bin/com.github.donadigo.appeditor >/dev/null
RUN sed -i "s,Exec=com\.github\.donadigo\.appeditor,Exec=env XDG_MENU_PREFIX=mate- com.github.donadigo.appeditor," /dest/usr/share/applications/com.github.donadigo.appeditor.desktop >/dev/null

RUN mkdir -p /root/rpmbuild/{SOURCES,SPECS}
WORKDIR /root/rpmbuild
ADD rpm.spec SPECS
RUN sed -i "s,{{VERSION}},$version," SPECS/rpm.spec >/dev/null
RUN sed -i "s,{{SOURCE0}},https://github.com/donadigo/appeditor/archive/$target_version.tar.gz," SPECS/rpm.spec >/dev/null
RUN find /dest -type f | sed 's,^/dest,,' >> SPECS/rpm.spec
RUN find /dest -type l | sed 's,^/dest,,' >> SPECS/rpm.spec
RUN rpmbuild -bb SPECS/rpm.spec