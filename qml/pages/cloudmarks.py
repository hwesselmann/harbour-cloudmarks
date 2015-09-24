#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#   cloudMarks - A SailfishOS client for the ownCloud Bookmarks application.
#   Copyright (C) 2015 Hauke Wesselmann
#   Contact: Hauke Wesselmann <hauke@h-dawg.de>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

import requests


def loadBookmarksFromServer(url, user, password, ignoreSSLErrors):
    ocPath = url + '/index.php/apps/bookmarks/public/rest/v1/bookmark'
    ocPath += '?user=' + user
    ocPath += '&password=' + password
    ocPath += '&select[0]=tags&select[1]=description'
    ignoreErrors = True

    if ignoreSSLErrors == "true":
        ignoreErrors = False

    response = requests.get(ocPath, verify=ignoreErrors)
    return response.text
