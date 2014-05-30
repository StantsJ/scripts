// Quick JS to query our sql server here at VP using node.js 
// Requirments

/*jshint node : true, strict  : true */

var   
  sql = require('mssql'),
  //fs = require('fs'),
  //Vpccode   =  'BAR',
  sqlQuery  =  "SELECT Vpccode, Itemid, Itemdesc \
				        FROM Items \
				        WHERE (Itemstatus = 'Normal' OR Itemstatus = 'On Hold') \
                AND (SpOrdHandleReq <> 0)",

  config = {
  	user     : 'fsuser',
  	password : "fsuser",
  	server   : 'FulProdSQL.vp.lan',
  	database : 'FulfillmentTEST',
  },

  connection, request;

  connection = new sql.Connection(config, function(err) { 
	
	 request = new sql.Request(connection);

    request.query(sqlQuery, function(err, recordsets) {
      connection.close();
      console.dir(recordsets);
      // var sRecords = JSON.stringify(recordsets, null, 4);

      // fs.writeFile('item.json', sRecords, function (err) {
      // 	console.log('It\'s saved');
      // });
    });
});


// *** Notes ***
 
//request.input('Vpc', 'HLFFS');
// request.execute('psp_rptInventory', function(err, recordsets, returnValue) {
// 		console.dir(recordsets[0]);
// });
