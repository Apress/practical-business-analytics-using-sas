PROC IMPORT OUT= WORK.add_budget 
            DATAFILE= "C:\Users\VENKAT\Google Drive\Training\Books\Conte
nt\Regression Analysis\Add_budget_data.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="budget$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
/*Contents of the imported data*/
proc contents data=	add_budget varnum;
run;

/* Correlation */
proc corr data=add_budget ;
var Online_Budget Responses_online ;
run;

proc corr data=add_budget ;
var Online_Budget Responses_online ;
run;
/* Importing telecom data*/
PROC IMPORT OUT= WORK.telecom 
            DATAFILE= "C:\Users\VENKAT\Google Drive\Training\Books\Conte
nt\Regression Analysis\Telecom_Csat_correlation.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc print data=telecom(obs=10);
run;

/*Scatter plots between CSAT and other variables*/
proc gplot data= telecom;
plot  C_sat*service;
run;

proc gplot data= telecom;
plot  C_sat*issue_resolution;
run;

proc gplot data= telecom;
plot  C_sat*call_center;
run;

proc gplot data= telecom;
plot  C_sat*price_plans;
run;


/* Correlation between the variables*/
proc corr data=	telecom;
var  C_sat service issue_resolution call_center price_plans ;
run;

/* Importing telecom rank data*/
PROC IMPORT OUT= WORK.telecom_rank 
            DATAFILE= "C:\Users\VENKAT\Google Drive\Training\Books\Conte
nt\Regression Analysis\Telecom_Csat_correlation -Rank.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc print data=telecom_rank(obs=10);
run;
*C_sat_Rank service_rank issue_resolution_rank call_center_rank price_plans_rank  ;

/*Scatter plots between CSAT Rank and other variables*/

proc gplot data= telecom_rank;
plot  C_sat_Rank*service_rank;
run;

proc gplot data= telecom_rank;
plot  C_sat_Rank*issue_resolution_rank;
run;

proc gplot data= telecom_rank;
plot  C_sat_Rank*call_center_rank;
run;

proc gplot data= telecom_rank;
plot  C_sat_Rank*price_plans_rank;
run;

proc corr data=	telecom_rank SPEARMAN;
var C_sat_Rank service_rank issue_resolution_rank call_center_rank price_plans_rank   ;
run;
