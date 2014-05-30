var
  fs = require( 'fs' ),
  path = require( 'path' ),
  dir, filter;

dir = process.argv[2];
filter = process.argv[3];

fs.readdir( dir, function( err, files )  {
  files.forEach( function ( file ) {
    if( '.' + filter === path.extname(file) ) {
      console.log(file);
    }
  });
});
