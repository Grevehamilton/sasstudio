data mysnow.class;
	set sashelp.class;
run;

proc sql;
	create table mysnow.classfit as
	select * from sashelp.classfit;
quit;


/*Implicit passthru*/
proc sql;
	drop table mysnow.classjoin;

	create table mysnow.classjoin as
	select a.*, b.predict from
	mysnow.class a left join
	mysnow.classfit b
	on a.name = b.name;
quit;

/*Explicit passthru*/
proc sql;
	connect to snow as x1(	server='rh33561.west-europe.azure.snowflakecomputing.com' 
							db=PATRIC
						  	warehouse=COMPUTE_WH schema=PUBLIC
						  	user=patrichamilton pw='{SAS002}C3D43A4156C496980B7AA5BC2BB4B655');

	execute(drop table "PUBLIC"."classjoin") by x1;
	execute(CREATE TABLE "PUBLIC"."classjoin" as select a."Name", a."Sex", a."Age", a."Height", a."Weight", b."predict" from "PUBLIC"."class" a 
	left join "PUBLIC"."classfit" b on a."Name" = b."Name") by x1;
quit;

