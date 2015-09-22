/*
    cloudMarks - A SailfishOS client for the ownCloud Bookmarks application.
    Copyright (C) 2015 Hauke Wesselmann
    Contact: Hauke Wesselmann <hauke@h-dawg.de>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import "../models"
import "../components"
import "../utils/BookmarkDatabase.js" as BookmarkDatabase

Page {
    id: bookmarksPage

    property BookmarkListModel bookmarkListModel: BookmarkListModel {
        Component.onCompleted: {
            BookmarkDatabase.load();
            BookmarkDatabase.queryBookmarks(this, "");
        }
    }

    SilicaListView {
        id: bookmarkList
        anchors.fill: parent
        spacing: Theme.paddingLarge
        opacity: busyIndicator.running ? 0.5 : 1.0
        quickScroll: true

        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }

        ViewPlaceholder {
            enabled: (bookmarkList.count === 0) && (busyIndicator.running === false)
            text: qsTr("Nothing here? Visit the settings page and then load bookmarks from your server.")
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"), { "settings": mainwindow.settings})
            }
            MenuItem {
                text: qsTr("Load from server")
                onClicked: {
                    busyIndicator.running = true
                    busyIndicator.visible = true
                    python.reloadFromServer();
                }
            }
            MenuItem {
                text: qsTr("Search")
                onClicked: pageStack.push(Qt.resolvedUrl("SearchPage.qml"))
            }
        }

        header: PageHeader {
            title: qsTr("cloud Bookmarks")
        }

        model: bookmarkListModel

        VerticalScrollDecorator {}

        delegate: BookmarkDelegate{
            onClicked: {
                this.openLink();
                infoBanner.showText(qsTr("Opening link in web browser"));
            }
        }
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: false
        size: BusyIndicatorSize.Large
    }

    Python {
        id: python

        Component.onCompleted: {
            var pythonpath = Qt.resolvedUrl('.').substr('file://'.length);
            addImportPath(pythonpath);
            var requestspath = Qt.resolvedUrl('../../third-party/requests').substr('file://'.length);
            addImportPath(requestspath);

            importModule('cloudmarks', function () {});

        }

        function reloadFromServer() {
            call('cloudmarks.loadBookmarksFromServer', [mainwindow.settings.ocUrl, mainwindow.settings.ocUsername, mainwindow.settings.ocPassword, mainwindow.settings.ignoreSSLErrors], function(response) {
                var responseJSON = JSON.parse(response);
                BookmarkDatabase.clear();
                BookmarkDatabase.storeBookmarks(responseJSON);
                bookmarkListModel.populate(responseJSON, "");
                busyIndicator.running = false
                busyIndicator.visible = false
            });
        }

        onError: {
            console.log('python error: ' + traceback);
        }

        onReceived: {
            console.log('got message from python: ' + data);
        }
    }
}


