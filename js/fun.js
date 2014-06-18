var _ = require('underscore'),

        people = [{ name : "Joe", age: 30}, 
                  { name : "Bob", age: 55 },
                  { name : "Luke", age: 34}],

        numbers = [1,2,3,4,5],

        results;

function best(fun, coll){
  return _.reduce(coll, function(x, y){
    return fun(x, y) ? x : y
  });
}

results = best(function(x, y) { return x > y }, numbers);

console.log(results);

results = best(function(x, y) { return x.age > y.age }, people);

console.log(results);

function repeatedly(times, fun) {
  return _.map(_.range(times), fun);
}

results = repeatedly(3, function() { return "hello"});

console.log(results);

function iterateUntil( fun, check, init ) {
  var ret = [];
  var result = fun(init);

  while (check(result)) {
    ret.push(result);
    result = fun(result);
  }

  return ret;
}

results = iterateUntil( function(n) { return n+n },
                        function(n) { return n <= 1024 },
                        1);

console.log(results);

results = iterateUntil( function(n) { return Math.floor((
                                      Math.random()*10)+1); },
                        function(n) { return n <= 100 },
                        1);

console.log(results);