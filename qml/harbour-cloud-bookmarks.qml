/*
    ownCloud Bookmarks - A SailfishOS client for the ownCloud Bookmarks application.
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

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "models"
import "utils/Database.js" as Database

ApplicationWindow
{
    id: mainwindow
    allowedOrientations: defaultAllowedOrientations

    initialPage: Component { BookmarksPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    property alias settings: settings

    Settings
    {
        id: settings

        Component.onCompleted: {
            Database.load();
            Database.transaction(function(tx) {
                    var ocUrl = Database.transactionGet(tx, "ocUrl");
                    settings.ocUrl = (ocUrl === false ? "http:\/\/" : ocUrl);

                    var ocUsername = Database.transactionGet(tx, "ocUsername");
                    settings.ocUsername = (ocUsername === false ? "" : ocUsername);

                    var ocPassword = Database.transactionGet(tx, "ocPassword");
                    settings.ocPassword = (ocPassword === false ? "" : ocPassword);
                });
        }
    }
}


