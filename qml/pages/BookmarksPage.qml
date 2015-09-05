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
        anchors.fill: parent
        spacing: 90

        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"), { "settings": mainwindow.settings})
            }
            MenuItem {
                text: qsTr("Reload from server")
                onClicked: loadBookmarksFromServer();
            }
        }

        header: PageHeader {
            title: qsTr("cloud Bookmarks")
        }

        model: bookmarkListModel

        VerticalScrollDecorator {}

        delegate: BookmarkDelegate{
            onClicked: {
                console.log("Clicked");
            }
        }
    }

    function loadBookmarksFromServer() {

        request(mainwindow.settings.ocUrl + '/index.php/apps/bookmarks/public/rest/v1/bookmark?user=' + mainwindow.settings.ocUsername + '&password=' + mainwindow.settings.ocPassword + '&select[0]=tags&select[1]=description', function (o) {
            var response = JSON.parse(o.responseText);
            bookmarkListModel.populate(response);
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


