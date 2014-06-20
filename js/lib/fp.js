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

// Simple illustrative way of parsing CSV
function lameCSV(str) {
  return _.reduce(str.split("\n"), function(table, row) {
    table.push(_.map(row.split(","), function (c) {
      return c.trim()
    }));
    return table;
  }, []);
};

// Do an action if the condtion is true
function doWhen(cond, action) {
  if(truthy(cond))
    return action();
  else
    return undefined;
}

// execute only if that objects has that field
function executeIfHasField(target, name) {
  return doWhen(existy(target[name]), function () {
    var result = _.result(target, name);
    console.log(['The result is', result].join(' '));
    return result;
  });
}

// doubles every number in an array
function doubleAll(array) {
  return _.map(array, function (x) { return x*2; });
}

// averages every number in an array
function average(array) {
  var sum = _.reduce(array, function (a, b) { return a+b; });
  return sum / _.size(array);
}

// returns only the even numbers
function onlyEven(array) {
  return _.filter(array, function (x) {
    return (x%2) === 0;
  });
}

// divied numbers x and way
function div(x, y) {
  return x/y;
}

// Make sure all supplied functions return true
function allOf(/* funs */) {
  return _.reduceRight(arguments, function(truth, f) {
    return truth && f();
  }, true);
}

// if only one of the functions returns true, return true
function anyOf(/* funs */) {
  return _.reduceRight(arguments, function(truth, f) {
    return truth || f();
  }, false);
}

// True
function T() { return true; }

// False
function F() { return false; }

// takes a predicate and returns a function that reverses the sense
// of the result of said predicate
function complement(pred) {
  return function() {
    return !pred.apply(null, _.toArray(arguments));
  }
}

// concats an array
function cat() {
  var head = _.first(arguments);
  if (existy(head))
    return head.concat.apply(head, _.rest(arguments));
  else
    return [];
}

// takes an element and an array and place the in front of the array
function construct(head, tail) {
  return cat([head], _.toArray(tail));
}

// concats all the elements as the result of map
function mapcat(fun, coll) {
  return cat.apply(null, _.map(coll, fun));
}
























