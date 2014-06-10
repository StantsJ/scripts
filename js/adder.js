function makeAdder( setAmount ) {
  return function ( freeAmount ) {
    return freeAmount + setAmount;
  }
}

add10 = makeAdder(10);
console.log(add10(20));
// 30

add1000 = makeAdder(1000);
console.log(add1000(10));
// 1010