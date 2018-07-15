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
	if (process.env.NODE_ENV === 'development') {
		return db.runSql(read('sql/tests.sql', 'utf8'));
	}
	return
};

exports.down = function(db) {
	return null;
};

exports._meta = {
	"version": 1
};
