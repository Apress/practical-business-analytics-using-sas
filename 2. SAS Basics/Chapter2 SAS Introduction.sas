/* SAS sample code*/
proc print data=sashelp.prdsale;
run;

proc printing data=sashelp.prdsale;
run;

proc print data=sashelp.prdsales;
run;

/* SAS code syntax Examples*/
proc means data =sashelp.prdsale;
var actual;
run;

			proc means data =sashelp.prdsale;
var actual;
run;

proc 
means data =sashelp.prdsale;
var actual;
run;

proc means data =sashelp.prdsale;var actual;run;


PROC MEANS Data =sashelp.prdsale;var actual;run;

/* My First SAS program*/
proc print data=sashelp.prdsale;
run;

proc means data =sashelp.prdsale;
var actual;
run;

/* New data*/
data income_data;
Input income expenses;
Cards;
1200 1000
9000 600
;
run;
Proc print data=income_data;
Run;

/* Code with Error*/
proc dataprinting data=sashelp.prdsale;
run;

proc print data=sashelp.prdsales;
run;
/* Example of warnings in log file*/
data new_data;
set sashelp.prdsale;
where actuals<1000;
run;
