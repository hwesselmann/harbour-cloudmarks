Name:       harbour-cloudmarks

Summary:    A native client for the owncloud bookmarks application
Version:    0.7
Release:    1
Group:      Applications/Network
License:    LGPL v3
Source0: 	harbour-cloudmarks.tar.xz
BuildArch: 	noarch
Requires: 	libsailfishapp-launcher
Requires: 	pyotherside-qml-plugin-python3-qt5
Requires: 	sailfishsilica-qt5

%description
A native client for the owncloud bookmarks application

%prep
%setup -n %{name}

%install
rm -rf %{buildroot}

# Application files
TARGET=%{buildroot}/%{_datadir}/%{name}
mkdir -p $TARGET
mkdir -p $TARGET/translations
cp -rpv qml $TARGET/qml
cp -rpv third-party $TARGET/third-party
cp -pv translations/*.qm $TARGET/translations/

# Desktop Entry
TARGET=%{buildroot}/%{_datadir}/applications
mkdir -p $TARGET
cp -rpv %{name}.desktop $TARGET/

# Icon
TARGET=%{buildroot}/%{_datadir}/icons/hicolor/86x86/apps/
mkdir -p $TARGET
cp -rpv %{name}.png $TARGET/%{name}.png

%files
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png