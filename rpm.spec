Summary: Yet another unofficial AppEditor package for Amazon Linux 2
Name: albuild-appeditor
Version: {{VERSION}}
Release: 1%{?dist}
Group: User Interface/Desktops
License: BSD-3-Clause
Source0: {{SOURCE0}}
SOURCE1: https://github.com/elementary/granite/blob/master/COPYING
SOURCE2: https://github.com/GNOME/libgee/blob/master/COPYING
URL: https://github.com/albuild/appeditor
BuildArch: x86_64
AutoReqProv: no

%description
Yet another unofficial AppEditor package for Amazon Linux 2.

%install
cp -r /dest/* %{buildroot}/

%clean
rm -rf %{buildroot}

%post
glib-compile-schemas /usr/share/glib-2.0/schemas/

%files
