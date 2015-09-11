.pragma library
.import QtQuick.LocalStorage 2.0 as Storage

function sanitizeString(s)
{
    // Trim whitespace at the beginning / end
    s = s.replace(/(^\s+|\s+$)/g,'')

    // Replace multiple whitespaces with one whitespace
    s = s.replace(/\s+/g, ' ')

    return s
}

function instance()
{
    return openDatabase("1.0");
}

function openDatabase(version)
{
    return Storage.LocalStorage.openDatabaseSync("ocBookmarksStorageDB", version, "ownCloud Bookmarks offline storage database", 5000000);
}

function clear()
{
    instance().transaction(function(tx) {
        tx.executeSql("DROP TABLE IF EXISTS Bookmarks");
    });

    load();
}

function storeBookmarks(rows)
{
    var db = instance();

    for(var li = 0; li < rows.length; li++)
    {
        var currentRow = rows[li];
        var tags = "";
        // in owncloud, tags names cannot contain a comma, so we can check if we are dealing with a json response
        // by checking for commas
        if(currentRow.tags)
        {
            tags = currentRow.tags.toString().replace(/,/g, ', ');
        }

        storeBookmark(db, currentRow.title, currentRow.description, currentRow.url, tags);
    }
}

function storeBookmark(db, title, description, url, tags)
{
    title = sanitizeString(title ? title : "");
    description = sanitizeString(description ? description : "");
    tags = sanitizeString(tags ? tags : "");

    db.transaction(function(tx) {
        tx.executeSql("INSERT INTO Bookmarks (url, title, description, tags) VALUES (?, ?, ?, ?);", [url, title, description, tags]);
    });
}

function queryBookmarks(model, searchTerm)
{
    model.clear();

    instance().transaction(function(tx) {
        var res = tx.executeSql("SELECT * FROM Bookmarks")

        model.clear();
        if(res.rows.length)
        {
            model.populate(res.rows, searchTerm);
        }
    });
}

function load()
{
    var db = instance();
    db.transaction(function(tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS Bookmarks(url TEXT PRIMARY KEY, title TEXT, description TEXT, tags TEXT)");
    });
}

function transaction(txfunc)
{
    instance().transaction(txfunc);
}
