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

ListModel
{
    id: bookmarkListModel
    function populate(rows)
    {   
        bookmarkListModel.clear();
        for(var li = 0; li < rows.length; li++)
        {
            var currentRow = rows[li];
            var tags = "";
            // in owncloud, tags names cannot contain a comma, so we can check if we are dealing with a json response
            // by checking for commas
            if(currentRow.tags && currentRow.tags.indexOf(',') > 0)
            {
                tags = currentRow.tags.toString();
            }
            else
            {
                tags = currentRow.tags;
            }

            bookmarkListModel.append({"url": currentRow.url, "title": currentRow.title, "description": currentRow.description, "tags": tags})
        }
    }
}
