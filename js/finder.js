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

results = best(function(x, y) { return x > y }, numbers );

console.log(results);

results = best(function(x, y) { return x.age > y.age }, people);

console.log(results);
