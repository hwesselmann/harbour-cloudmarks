# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-cloudmarks

CONFIG += sailfishapp

SOURCES += src/harbour-cloudmarks.cpp

OTHER_FILES += qml/harbour-cloudmarks.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-cloudmarks.changes.in \
    rpm/harbour-cloudmarks.spec \
    rpm/harbour-cloudmarks.yaml \
    translations/*.ts \
    harbour-cloudmarks.desktop \
    qml/models/Settings.qml \
    qml/pages/BookmarksPage.qml \
    qml/pages/SettingsPage.qml \
    qml/components/BookmarkDelegate.qml \
    qml/models/BookmarkListModel.qml \
    qml/utils/BookmarkDatabase.js \
    qml/utils/SettingsDatabase.js \
    qml/pages/SearchPage.qml \
    qml/pages/cloudmarks.py

python_files.files = third-party
python_files.path = /usr/share/$$TARGET

INSTALLS += python_files

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-cloudmarks-de.ts \
    translations/harbour-cloudmarks-fi.ts \
    translations/harbour-cloudmarks-es.ts \
    translations/harbour-cloudmarks-da.ts \
    translations/harbour-cloudmarks-gl.ts \
    translations/harbour-cloudmarks-fr.ts \
    translations/harbour-cloudmarks-nl.ts

RESOURCES += \
    res.qrc

