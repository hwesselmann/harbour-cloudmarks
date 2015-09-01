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

import QtQuick 2.1
import Sailfish.Silica 1.0
import "../models"
import "../utils/Database.js" as Database

Dialog {
    id: settingsPage

    property Settings settings

    allowedOrientations: defaultAllowedOrientations
    acceptDestinationAction: PageStackAction.Pop
    canAccept: true

    function acceptSettings() {
        settings.ocUrl = ocUrlTF.text;
        settings.ocUsername = ocUsernameTF.text;
        settings.ocPassword = ocPasswordTF.text;

        Database.transaction(function(tx) {
            Database.transactionSet(tx, "ocUrl", settings.ocUrl);
            Database.transactionSet(tx, "ocUsername", settings.ocUsername);
            Database.transactionSet(tx, "ocPassword", settings.ocPassword);
        });
    }

    onAccepted: {
        acceptSettings()
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + dlgheader.height

        Column
        {
            id: column
            anchors.top: parent.top
            width: parent.width

            DialogHeader
            {
                id: dlgheader
                acceptText: "Save Settings"
            }

            TextField
            {
                id: ocUrlTF
                placeholderText: "ownCloud server url"
                label: "ownCloud server url"
                width: parent.width
                inputMethodHints: Qt.ImhUrlCharactersOnly
                text: settings.ocUrl
                EnterKey.enabled: text.length > 0
                EnterKey.onClicked: ocUsernameTF.focus = true
            }

            TextField
            {
                id: ocUsernameTF
                placeholderText: "ownCloud username"
                label: "ownCloud username"
                width: parent.width
                inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
                text: settings.ocUsername
                EnterKey.enabled: text.length > 0
                EnterKey.onClicked: ocPasswordTF.focus = true
            }

            TextField
            {
                id: ocPasswordTF
                placeholderText: "ownCloud password"
                label: "ownCloud password"
                width: parent.width
                inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
                echoMode: TextInput.Password
                text: settings.ocPassword
                EnterKey.enabled: text.length > 0
                EnterKey.onClicked: {
                    acceptSettings();
                    parent.focus = true;
                }
            }
        }
    }
}
