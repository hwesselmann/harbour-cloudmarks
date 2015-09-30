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

import "../models"

ListItem {
    id: bookmarkDelegate
    contentHeight: delegateColumn.height

    Column
    {
       id: delegateColumn
       width: parent.width
       spacing: 5

        Label {
            id: itemTitle
            text: title
            font.pixelSize: Theme.fontSizeMedium
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            truncationMode: TruncationMode.Fade
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
        }

        Label {
            id: itemDescription
            text: description
            font.pixelSize: Theme.fontSizeSmall
            font.italic: true
            truncationMode: TruncationMode.Fade
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            visible: description && settings.showDescription === "true"
        }

        Label {
            id: itemUrl
            text: url
            font.pixelSize: Theme.fontSizeTiny
            font.italic: true
            truncationMode: TruncationMode.Fade
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            visible: url && settings.showUrl === "true"
        }

        Separator {
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            color: Theme.primaryColor
        }

        Row {
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingLarge
            }
            spacing: 5

            Image {
                source: "../img/icon-s-tag.png"
                y: 11
                x: 1
                visible: tags && settings.showTags === "true"
            }

            Label {
                id: itemTags
                text: tags
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
                maximumLineCount: 2
                visible: tags && settings.showTags === "true"
            }
        }
   }

    function openLink() {
        Qt.openUrlExternally(url);
    }
}
