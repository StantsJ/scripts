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

