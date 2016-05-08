'use strict';

var parser = require('../dist/firstlang/firstlang');

console.log(parser.parse(process.argv.slice(2).join(' ')));
