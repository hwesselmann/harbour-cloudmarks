/*
    cloud Bookmarks - A SailfishOS client for the ownCloud Bookmarks application.
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
import "../models"
import "../components"

Page {
    id: bookmarksPage

    property BookmarkListModel bookmarkListModel: BookmarkListModel { }

    SilicaListView {
        id: bookmarkList
        anchors.fill: parent
        spacing: 90
        opacity: busyIndicator.running ? 0.5 : 1.0

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
                    loadBookmarksFromServer();
                }
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

    function loadBookmarksFromServer() {

        request(mainwindow.settings.ocUrl + '/index.php/apps/bookmarks/public/rest/v1/bookmark?user=' + mainwindow.settings.ocUsername + '&password=' + mainwindow.settings.ocPassword + '&select[0]=tags&select[1]=description', function (o) {
            var response = JSON.parse(o.responseText);
            bookmarkListModel.populate(response);
            busyIndicator.running = false
            busyIndicator.visible = false
        });
    }

    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function(myxhr) {
            return function() {
                callback(myxhr);
            }
        })(xhr);
        xhr.open('GET', url, true);
        xhr.send('');
    }
}


