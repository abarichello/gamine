'use strict';

var dbm;
var type;
var seed;

const { readFileSync: read } = require('fs')

exports.setup = function(options, seedLink) {
    dbm = options.dbmigrate;
    type = dbm.dataType;
    seed = seedLink;
};

exports.up = function(db) {
    return db.runSql(read('sql/gamine.sql', 'utf8'));
};

exports.down = function(db) {
    const sql = `DROP TABLE gamine;`;
    return db.runSql(sql);
};

exports._meta = {
    "version": 1
};
