
var
  naiveNth, 
  args;

args = process.argv;

naiveNth = function(a, index) {
  console.log( a[index] );
}

naiveNth( args[2], args[3] )