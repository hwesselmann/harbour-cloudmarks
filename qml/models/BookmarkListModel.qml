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
    function populate(rows, searchTerm)
    {   
        bookmarkListModel.clear();
        for(var li = 0; li < rows.length; li++)
        {
            var currentRow = rows[li];
            var tags = "";
            // replace null fields with empty string and sanitize the content for displaying
            var title = sanitizeString(currentRow.title ? currentRow.title : "");
            var description = sanitizeString(currentRow.description ? currentRow.description : "");
            // in owncloud, tags names cannot contain a comma, so we can check if we are dealing with a json response
            // by checking for commas
            if(currentRow.tags && currentRow.tags.indexOf(',') < 0)
            {
                tags = sanitizeString(currentRow.tags.toString().replace(/,/g, ', '));
            }
            else if(currentRow.tags)
            {
                tags = sanitizeString(currentRow.tags);
            }
            if(searchTerm.length <= 0)
            {
                bookmarkListModel.append({"url": currentRow.url, "title": title, "description": description, "tags": tags})
            }
            else
            {
                if(tags.toLowerCase().indexOf(searchTerm.toLowerCase()) >= 0 || title.toLowerCase().indexOf(searchTerm.toLowerCase()) >= 0 || description.toLowerCase().indexOf(searchTerm.toLowerCase()) >= 0)
                {
                    bookmarkListModel.append({"url": currentRow.url, "title": title, "description": description, "tags": tags})
                }
            }

        }
    }

    function sanitizeString(s)
    {
        s = s.replace(/(^\s+|\s+$)/g,'')
        s = s.replace(/\s+/g, ' ')

        return s
    }
}
