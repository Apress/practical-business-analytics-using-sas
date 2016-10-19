proc contents data=sashelp.prdsale varnum;
run;
proc print data = sashelp.prdsale(obs=20);
run;

/* Only canada records*/

data prod_sample;
set  sashelp.prdsale;
where country='CANADA';
run;

/* Simple Random Sample */

proc surveyselect data = sashelp.prdsale 
method = SRS 
rep = 1 
sampsize = 30 seed = 12345 out = prod_sample_30;
id _all_;
run;

proc print data=prod_sample_30;
run;

/* Average Sales of population*/
proc means data=sashelp.prdsale ;
var actual;
run;

/* Average Sales of sample */
proc means data=prod_sample_30 ;
var actual;
run;

/* Simple Random Sample; Size is 100 */
proc surveyselect data = sashelp.prdsale 
method = SRS 
rep = 1 
sampsize = 100 seed = 12345 out = prod_sample_100;
id _all_;
run;


proc means data=prod_sample_100 ;
var actual;
run;
