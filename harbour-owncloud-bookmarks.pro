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
TARGET = harbour-owncloud-bookmarks

CONFIG += sailfishapp

SOURCES += src/harbour-owncloud-bookmarks.cpp

OTHER_FILES += qml/harbour-owncloud-bookmarks.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-owncloud-bookmarks.changes.in \
    rpm/harbour-owncloud-bookmarks.spec \
    rpm/harbour-owncloud-bookmarks.yaml \
    translations/*.ts \
    harbour-owncloud-bookmarks.desktop \
    qml/models/Settings.qml \
    qml/pages/BookmarksPage.qml \
    qml/utils/Database.js \
    qml/pages/SettingsPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-owncloud-bookmarks-de.ts

