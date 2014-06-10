var _ = require('underscore'),
        numbers = [1,2,3,4,5,6,7,8,9],
        people = [{ name : "Joe", age: 30}, 
                  { name : "Bob", age: 55 },
                  { name : "Luke", age: 34}],
        results;

results = _.max( numbers );

console.log( results );  

results = _.max( people, function ( p ) { return p.age } );

console.log( results );  