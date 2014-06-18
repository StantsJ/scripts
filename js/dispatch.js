var _ = require('underscore');

function dispatch(/* funs */) {
  var funs = _.toArray(arguments),
      size = funs.length;

  return function (target /*, args */) {
    var ret = undefined,
        args = _.rest( arguments );

    for ( var funIndex = 0; funIndex < size; funIndex++ ) {
      var fun = funs[funIndex],
          ret = fun.apply(fun, construct(target, args));

      if (existy(ret)) return ret;
    }

  return ret;
  };
}