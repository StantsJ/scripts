var _ = require('C:/scripts/js/lib/underscore.js');

// used for error
function fail(thing) {
  throw new Error(thing);
}

// used for warning
function warn(thing) {
  console.log(["WARNING:", thing].join(' '));
}

// used for loging a note
function note(thing) {
  console.log(["NOTE:", thing].join(' '));
}

// Returns if data is an idexed datatype
function isIndexed(data) {
  return _.isArray(data) || _.isString(data);
}

// Returns the value at an index
function nth(a, index) {
  if(!_.isNumber(index)) fail("Expected a number as index");
  if(!isIndexed(a)) fail("Not supported on non-indexed type");
  if((index < 0 ) || (index > a.length -1 ))
    fail("Index value is out of bounds")

   return a[index];
}

// Returns false for [null, undefined, 0, {}.notHere, (function()){}())]
function existy(x) { return x != null };

// Returns true for things that exist 0, ' ', {"hi":"there"}
function truthy(x) { return (x !== false) && existy(x) };

// returns a function of -1/0/1 for a given predicate
function comparator(pred) {
  return function(x, y) {
    if(truthy(pred(x, y)))
      return -1;
    else if(truthy(pred(y, x)))
      return 1;
    else
      return 0;
  }
}

// Returns true or false if x is less than y
function lessOrEqual(x, y) {
  return x <= y;
}

// Returns ture or false if x is greater than y
function greaterOrEqual(x, y) {
  return x >= y;
}



