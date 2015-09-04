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

ListItem {
    id: bookmarkDelegate
    x: Theme.horizontalPageMargin
    width: parent.width - 2*Theme.horizontalPageMargin
    height: childrenRect.height

    Label {
        id: title
        text: 'Convert Your Ubuntu Phone to an Android Phone'
        font.pixelSize: Theme.fontSizeSmall
        wrapMode: Text.WordWrap
        maximumLineCount: 2
        truncationMode: TruncationMode.Fade
        anchors {
            left: parent.left
            right: parent.right
            rightMargin: Theme.paddingSmall
        }
    }

    Label {
        id: url
        text: 'http://a25.co/ubuntu-phone-how-to-install-android/'
        font.pixelSize: Theme.fontSizeTiny
        font.italic: true
        wrapMode: Text.WordWrap
        maximumLineCount: 2
        truncationMode: TruncationMode.Fade
        anchors {
            top: title.bottom
            left: parent.left
            right: parent.right
        }
    }
    Label {
        id: tags
        text: 'Android, Ubuntu Phone'
        font.pixelSize: Theme.fontSizeTiny
        anchors {
            top: url.bottom
            topMargin: Theme.paddingSmall
            left: parent.left
        }
    }
}
