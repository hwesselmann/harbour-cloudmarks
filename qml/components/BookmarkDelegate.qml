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
        id: itemTitle
        text: title
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
        id: itemUrl
        text: url
        font.pixelSize: Theme.fontSizeTiny
        font.italic: true
        wrapMode: Text.WordWrap
        maximumLineCount: 2
        truncationMode: TruncationMode.Fade
        anchors {
            top: itemTitle.bottom
            left: parent.left
            right: parent.right
        }
    }
    Label {
        id: itemTags
        text: tags
        font.pixelSize: Theme.fontSizeTiny
        wrapMode: Text.WordWrap
        maximumLineCount: 2
        anchors {
            top: itemUrl.bottom
            topMargin: Theme.paddingSmall
            left: parent.left
        }
    }
}
