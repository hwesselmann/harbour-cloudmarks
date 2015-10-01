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
import os
import datetime
import pyotherside
import json
import traceback
from pyfav import download_favicon


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


def exportBookmarkstoSailfishBrowser(bookmarks, sPath):
    bookmark_list = []

    home = os.environ['HOME']
    path = '/.local/share/'
    browser = 'org.sailfishos/sailfish-browser/'
    timestamp = str(datetime.datetime.now().timestamp())
    backup = sPath + '/bookmarks.json.bak' + timestamp
    favicon_path = sPath + '/favicons'

    try:
        _mkdir(favicon_path)
        bookmark_obj = json.loads(bookmarks)
        with open(home + path + browser + 'bookmarks.json', 'r') as f:
            exist_bookmarks = json.load(f)
        exist_urls = []
        for ebm in exist_bookmarks:
            bookmark_list.append(ebm)
            exist_urls.append(ebm['url'])

        for bm in bookmark_obj:
            if bm['url'] not in exist_urls:
                bookmark = {
                    'favicon': 'icon-launcher-bookmark',
                    'hasTouchIcon': False,
                    'title': bm['title'],
                    'url': bm['url']
                }
                bookmark_list.append(bookmark)

        os.renames(home + path + browser + 'bookmarks.json', backup)
        with open(home + path + browser + 'bookmarks.json', 'w') as f:
            json.dump(bookmark_list, f)
    except:
        pyotherside.send(traceback.print_exc())


def retrieve_favicon(url, path):
    return ""


def get_encoded_favicon(favicon):
    return ""


def _mkdir(newdir):
    """works the way a good mkdir should :)
        - already exists, silently complete
        - regular file in the way, raise an exception
        - parent directory(ies) does not exist, make them as well
    """
    if os.path.isdir(newdir):
        pass
    elif os.path.isfile(newdir):
        raise OSError("a file with the same name as the desired "
                      "dir, '%s', already exists." % newdir)
    else:
        head, tail = os.path.split(newdir)
        if head and not os.path.isdir(head):
            _mkdir(head)
        if tail:
            os.mkdir(newdir)
