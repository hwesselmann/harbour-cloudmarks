.pragma library
.import QtQuick.LocalStorage 2.0 as Storage

function instance()
{
    return openDatabase("1.0");
}

function openDatabase(version)
{
    return Storage.LocalStorage.openDatabaseSync("ocBookmarksStorageDB", version, "ownCloud Bookmarks offline storage database", 5000000);
}
function set(setting, value)
{
    var db = instance();

    db.transaction(function(tx) {
        transactionSet(tx, setting, value);
    });
}

function get(setting)
{
    var db = instance();
    var res = false;

    db.readTransaction(function(tx) {
        res = transactionGet(tx, setting);
    });

    return res;
}

function transactionSet(tx, setting, value)
{
    tx.executeSql("INSERT OR REPLACE INTO Settings (name, value) VALUES (?, ?);", [setting, value]);
}

function transactionGet(tx, setting)
{
    var r = tx.executeSql("SELECT value FROM Settings WHERE name = ?;", [setting]);

    if(r.rows.length > 0)
        return r.rows.item(0).value;

    return false;
}

function load()
{
    var db = instance();

    db.transaction(function(tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS Settings(name TEXT PRIMARY KEY, value TEXT)");
    });
}

function transaction(txfunc)
{
    instance().transaction(txfunc);
}

