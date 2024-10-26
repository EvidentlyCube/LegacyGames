function gmsql_init() {
	dll="GMSQL.DLL";
	cl=dll_cdecl;
	global.GMSQLInit=external_define(dll,"GMSQLInit",cl,ty_real,0);
	global.GMSQLClose=external_define(dll,"GMSQLClose",cl,ty_real,0);
	global.GMSQLErrorCode=external_define(dll,"GMSQLErrorCode",cl,ty_real,0);
	global.GMSQLErrorMessage=external_define(dll,"GMSQLErrorMessage",cl,ty_string,0);
	global.GMSQLConnect=external_define(dll,"GMSQLConnect",cl,ty_real,4,ty_string,ty_string,ty_string,ty_string);
	global.GMSQLGetVersion=external_define(dll,"GMSQLGetVersion",cl,ty_string,1,ty_real);
	global.GMSQLSelectDB=external_define(dll,"GMSQLSelectDB",cl,ty_real,1,ty_string);
	global.GMSQLNumRows=external_define(dll,"GMSQLNumRows",cl,ty_real,0);
	global.GMSQLNumFields=external_define(dll,"GMSQLNumFields",cl,ty_real,0);
	global.GMSQLQuery=external_define(dll,"GMSQLQuery",cl,ty_real,1,ty_string);
	global.GMSQLGetServerInfo=external_define(dll,"GMSQLGetServerInfo",cl,ty_string,0);
	global.GMSQLGetClientInfo=external_define(dll,"GMSQLGetClientInfo",cl,ty_string,0);
	global.GMSQLGetHostInfo=external_define(dll,"GMSQLGetHostInfo",cl,ty_string,0);
	global.GMSQLInfo=external_define(dll,"GMSQLInfo",cl,ty_string,0);
	global.GMSQLStat=external_define(dll,"GMSQLStat",cl,ty_string,0);
	global.GMSQLPing=external_define(dll,"GMSQLPing",cl,ty_real,0);
	global.GMSQLChangeUser=external_define(dll,"GMSQLChangeUser",cl,ty_real,3,ty_string,ty_string,ty_string);
	global.GMSQLStoreResult=external_define(dll,"GMSQLStoreResult",cl,ty_real,0);
	global.GMSQLUseResult=external_define(dll,"GMSQLUseResult",cl,ty_real,0);
	global.GMSQLGetValueXY=external_define(dll,"GMSQLGetValueXY",cl,ty_string,2,ty_real,ty_real);
	global.GMSQLGetFieldName=external_define(dll,"GMSQLGetFieldName",cl,ty_string,1,ty_real);
	global.GMSQLAffectedRows=external_define(dll,"GMSQLAffectedRows",cl,ty_real,0);
	global.GMSQLThreadID=external_define(dll,"GMSQLThreadID",cl,ty_real,0);
	global.GMSQLKill=external_define(dll,"GMSQLKill",cl,ty_real,1,ty_real);
	global.GMSQLShutDown=external_define(dll,"GMSQLShutDown",cl,ty_real,0);
	global.GMSQLReload=external_define(dll,"GMSQLReload",cl,ty_real,0);
	global.GMSQLInsertID=external_define(dll,"GMSQLInsertID",cl,ty_real,0);
	global.GMSQLDataSeek=external_define(dll,"GMSQLDataSeek",cl,ty_real,1,ty_real);
	global.GMSQLFetchRow=external_define(dll,"GMSQLFetchRow",cl,ty_real,0);
	global.GMSQLGetValue=external_define(dll,"GMSQLGetValue",cl,ty_string,1,ty_real);
	global.GMSQLSaveDataXY=external_define(dll,"GMSQLSaveDataXY",cl,ty_real,3,ty_real,ty_real,ty_string);
	global.GMSQLSaveData=external_define(dll,"GMSQLSaveData",cl,ty_real,2,ty_real,ty_string);
	return external_call(global.GMSQLInit);





}
