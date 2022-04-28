/*https://go.documentation.sas.com/doc/th/pgmsascdc/v_025/acreldb/p19i7uzcbso1szn1pczxn88co3g1.htm*/
/*No snow engine in my EG*/
libname mysnow snow server='rh33561.west-europe.azure.snowflakecomputing.com'
	db=PATRIC
	warehouse=COMPUTE_WH
	schema=PUBLIC
	user=patrichamilton
	pw='{SAS002}C3D43A4156C496980B7AA5BC2BB4B655'
	readbuff=32767
	insertbuff=32767
	dbcommit=0;


/*
WAREHOUSE= specifies the default Snowflake warehouse to use. 
A Snowflake warehouse is a cluster of resources. 
Can be started and stopped at any time. 
Can be resized at any time, even while running.

DBCOMMIT= affects update, delete, and insert processing. 
When you specify DBCOMMIT=0, COMMIT is issued only once after a procedure or DATA step completes. It is performed after each statement when you use the SQL procedure.

DBSERVER_MAX_BYTES= affects the maximum number of bytes per single character in the database server encoding.
DBCLIENT_MAX_BYTES= specifies the maximum number of bytes per single character in the database client encoding, which matches SAS encoding.
Provides correct physical length 

READBUFF = specifies the number of rows of DBMS data to read into the buffer. Buffering can decrease network activities and increase performance. Note, higher values for READBUFF= use more memory. You need to experiment to find the right value (the customer POC proved this point)
INSERTBUFF= specifies the number of rows in a single DBMS insert. You need to experiment to find the right value.
*/

/*https://go.documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/casref/p183rli8obtde3n10y9bzbrpwnsh.htm*/
/* Creating Snowflake library for Cloud Analytics Services */
caslib cassnow desc='Snowflake Caslib' 
     dataSource=(srctype='snowflake'
                 server='rh33561.west-europe.azure.snowflakecomputing.com'
                 schema='PUBLIC'
                 username='patrichamilton'
                 password='{SAS002}C3D43A4156C496980B7AA5BC2BB4B655'
                 database="PATRIC");
/* Allocate CAS library and make it visible in SAS Studio Library Explorer */
libname cassnow cas caslib=cassnow;


data mysnow.cars;
	set sashelp.cars;
run;

