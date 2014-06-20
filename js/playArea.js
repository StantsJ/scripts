require('C:/scripts/js/lib/fp.js')
var _ = require('C:/scripts/js/lib/underscore.js');

function parseAge(age) {
  if(!_.isString(age)) fail("Expecting a string");
  var a;

  note("Attempting to parse age");
  a = parseInt(age, 10);

  if (_.isNaN(a)) {
    warn(["Could not parse age:", age].join(' '));
    a = 0;
  }
  return a;
}

parseAge("test");
parsplugineAge("10");

isIndexed("test");
isIndexed(10);

var letters = ['a', 'b', 'c'];

nth(letters, 1);
nth('abc', 0);
nth({}, 0);
nth(letters, 4000);
nth(letters, 'aaaaaa');

function second(a) {
  return nth(a, 1);
}


[2, 3, -6, 0, -108, 42].sort();
[0, -1, -2].sort();
[2, 3, -1, -6, 0, 10, 2, 3, 42].sort();

[2, 3, -1, -6, 0, 10, 2, 3, 42].sort(function(x, y) {
  if (x < y) return -1;
  if (x > y) return 1;
  return 0;
});

var sortIt = [2, 3, -1, -6, 0, -108, 42, 10];

[2, 3, -1, -6, 0, -108, 42, 10].sort(lessOrEqual);

[2, 3, -1, -6, 0, -108, 42, 10].sort(greaterOrEqual);

sortIt.sort(comparator(lessOrEqual));

sortIt.sort(comparator(function (x, y) { return x <= y; }));
sortIt.sort(comparator(function (x, y) { return y <= x; }));
sortIt.sort(comparator(function (x, y) { return x >= y; }));

var peopleTable = lameCSV("name,age,hair\nMerble,35,red\nBob,64,blonde");
peopleTable
_.rest(peopleTable).sort();

function selectNames(table) {
  return _.rest(_.map(table, _.first));
}

function selectAges(table) {
  return _.rest(_.map(table, second));
}

function selectHairColor(table) {
  return _.rest(_.map(table, function(row) {
    return nth(row, 2);
  }));
}

var mergeResults = _.zip;

selectNames(peopleTable);

selectAges(peopleTable);

selectHairColor(peopleTable);

mergeResults(selectNames(peopleTable), selectAges(peopleTable));

executeIfHasField([1,2,3], 'reverse');

executeIfHasField({foo: 42}, 'foo');

executeIfHasField([1,2,3], 'notHere');

existy(executeIfHasField([1,2,3], 'notHere'));

[null, undefined, 1, 2, false].map(existy);

[null, undefined, 1, 2, false].map(truthy);

42 + (function () { return 42; })();

function Point2D(x, y) {
  this._x = x;
  this._y = y;
}

new Point2D(0, 1);

function Point3D(x, y, z) {
  Point2D.call(this, x, y);
  this._z = z;
}

new Point3D(10, -1, 100);

var nums = [1,2,3,4,5];

doubleAll(nums);

average(nums);

onlyEven(nums);

_.map({a: 1, b: 2}, _.identity);

_.map({a: 1, b: 2}, function(v, k) {
  return [k,v];
});

_.map({a: 1, b: 2}, function(v, k, coll) {
  return [k, v, _.keys(coll)];
});

_.reduce(nums, div);

_.reduceRight(nums, div);

allOf();
allOf(T, T, T);
allOf(T, F, T);

anyOf(T, F, T);

_.find(['a', 'b', 3, 'c'], _.isNumber);

_.reject(['a', 'b', 3, 'c'], _.isNumber);

_.filter(['a', 'b', 3, 'c'], _.isNumber);

_.filter(['a', 'b', 3, 'c'], complement(_.isNumber));

_.all([1,2,3,4], _.isNumber);
_.all([1,2,'a',4], _.isNumber);

_.any([1,'a',3,4], _.isString);
_.any([1,2,3,4], _.isString);

var people = [{name: "Rick", age: 30}, {name: "Jaka", age: 24}];

_.sortBy(people, function(p) { return p.age; });

var albums = [{title: "Sabbath Bloody Sabbath", genre: "Metal"},
              {title: "Scientist", genre: "Dub"},
              {title: "Undertow", genre: "Metal"}]

_.groupBy(albums, function(a) { return a.genre });


_.countBy(albums, function(a) { return a.genre });


cat([1,2,3], [4,5], [6,7,8]);

construct(42, [1,2,3]);

mapcat(function(e) {
  return construct(e, [", "]);
}, [1,2,3]);

var zombie = {name: "Bub", film: "Day of the Dead"}

_.keys(zombie);
_.values(zombie);

_.pluck([{title: "Chthon", author: "Anthony"},
         {title: "Grendel", author: "Gardner"},
         {title: "After Dark"}],
       'author');
_.pairs(zombie);

_.object(_.map(_.pairs(zombie), function(pair) {
  return [pair[0].toUpperCase(), pair[1]];
}));

_.invert(zombie);

_.pluck(_.map([{title: "Chthon", author: "Anthony"},
         {title: "Grendel", author: "Gardner"},
         {title: "After Dark"}], function(obj) {
           return _.defaults(obj, {author: "unkown"});
         }),
       'author');

var person = {name: "Romy", token: "j3983ij", password: "tigress"};

var info = _.omit(person, 'token', 'password');
info
var creds = _.pick(person, 'token', 'password');
creds



























