proc delete data=mysnow.cars;
run;

data mysnow.cars (bulkload=yes bl_internal_stage='@~' bl_compress=yes);
	set sashelp.cars;
run;

/*
If data is being loaded from a machine that is not in the cloud, 
it must be copied to a cloud storage location, called a stage, 
before it can be loaded into the target database table

bl_internal_stage='@~' references your own user staging area 
(there are named, user and table stages in Snowflake)

BL_COMRESS=yes if your SAS environment is on-premises and you 
need to minimize the size of the load file. 

*/

/*Extended logging. See what code sas generates through the access module*/
Options sastrace=',,,d' sastraceloc=saslog nostsuffix sql_ip_trace=note;

/*Implicit passtrhu*/
data mysnow.cars;
	set sashelp.cars (obs=0);
run;

/*Explicit passthru*/
proc sql;
	connect to snow as x1(server='rh33561.west-europe.azure.snowflakecomputing.com' db=PATRIC
						  warehouse=COMPUTE_WH schema=PUBLIC
						  user=patrichamilton pw='{SAS002}C3D43A4156C496980B7AA5BC2BB4B655');

	execute (CREATE TABLE 	"PUBLIC"."cars" ("Make" VARCHAR(13),"Model" VARCHAR(40),
						  	"Type" VARCHAR(8),"Origin" VARCHAR(6),"DriveTrain" VARCHAR(5),
							"MSRP" double,"Invoice" double,"EngineSize" double,
							"Cylinders" double,"Horsepower" double, 
							"MPG_City" double, "MPG_Highway" double,
							"Weight" double,"Wheelbase" double,
							"Length" double)) by x1;
quit;



