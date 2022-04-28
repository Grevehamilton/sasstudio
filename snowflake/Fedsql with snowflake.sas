
/* Implicit passthru and _method */
proc fedsql sessref=casauto _method ;
	create table cassnow.classfedjoin{options replace=true} as select 
		a.name, a.sex, a.age, b.predict from cassnow."class" as a, 
		cassnow."classfit" as b where a.name=b.name;
quit;
/* Implicit passthru and _method and cntl=(requireFullPassThrough) */
proc fedsql sessref=casauto _method ;
	create table cassnow.classfedjoin{options replace=true} as select 
		a.name, a.sex, a.age, b.predict from cassnow."class" as a, 
		cassnow."classfit" as b where a.name=b.name;
quit;


/* Implicit passthru and _method - note the put statement! */
proc fedsql sessref=casauto _method;
	create table cassnow.classfedjoin{options replace=true} as select 
		a.name, put(a.sex,$2.) , a.age, b.predict from cassnow."class" as a, 
		cassnow."classfit" as b where a.name=b.name;
quit;

/* Implicit passthru and _method and cntl=(requireFullPassThrough) */
proc fedsql sessref=casauto _method cntl=(requireFullPassThrough);
	create table cassnow.classfedjoin{options replace=true} as select 
		a.name, put(a.sex,$2.) , a.age, b.predict from cassnow."class" as a, 
		cassnow."classfit" as b where a.name=b.name;
quit;


