// Quick JS to query our sql server here at VP using node.js 
// Requirments

/*jshint node : true, strict  : true */

var   
  sql = require('mssql'),
  //fs = require('fs'),
  //Vpccode   =  'BAR',
  // sqlQuery  =  "SELECT Vpccode, Itemid, Itemdesc \
		// 		        FROM Items \
		// 		        WHERE (Itemstatus = 'Normal' OR Itemstatus = 'On Hold') \
  //               AND (SpOrdHandleReq <> 0)",

  // sqlQuery  =   "SELECT * "
  //               + "FROM Associates "
  //               + "WHERE AssociateID = 123456",

  config = {
  	user     : 'fsuser',
  	password : "fsuser",
  	server   : 'FulProdSQL.vp.lan',
  	database : 'FulfillmentTEST',
  },

  connection, request, sqlQuery, vpccode, qty, days;

  vpccode = 'BAR';
  days = 1;
  qty = 100;

  // sqlQuery  = 'psp_RptLowUsage '
  //             + vpccode + ', '
  //             + days + ', '
  //             + qty

  //sqlQuery = "psp_RptLowUsage 'BAR', 1, 100";

  connection = new sql.Connection(config, function(err) { 
	
	 request = new sql.Request(connection);

   request.input('Vpccode', sql.VarChar(6), 'BAR');
   request.input('Months', sql.Int, 1);
   request.input('LowQty', sql.Int, 100);

   request.execute('psp_RptLowUsage', function ( err, recordsets, returnValue ) {
      console.dir(recordsets);
   });

    // request.query(sqlQuery, function(err, recordsets) {
    //   connection.close();
    //   console.dir(recordsets);
    //   // var sRecords = JSON.stringify(recordsets, null, 4);

    //   // fs.writeFile('item.json', sRecords, function (err) {
    //   // 	console.log('It\'s saved');
    //   // });
    // });
});


// *** Notes ***
 
//request.input('Vpc', 'HLFFS');
// request.execute('psp_rptInventory', function(err, recordsets, returnValue) {
// 		console.dir(recordsets[0]);
// });
