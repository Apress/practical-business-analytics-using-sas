/*Import the dataset into SAS */

PROC IMPORT OUT= WORK.call_volume 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\7. Data Exploration and Cleaning\Datasets\Call_volume.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/*Get the contents of the SAS dataset */

proc contents data=WORK.call_volume varnum;
run;


title 'Overall mean of the call volume';
proc means data=WORK.call_volume ;
var volume ;
run;

title 'Overall mean of the call volume';
proc means data=WORK.call_volume mean;
var volume ;
run;

title 'Mean of the call volume in 1 to 8 Hours';
proc means data=WORK.call_volume mean;
var volume; 
where Hour < 9; 
run;

title 'Mean of the call volume in 9 to 24 Hours';
proc means data=WORK.call_volume mean;
var volume;
where  Hour ge 9;
run;
title;

title 'Overall Data - Daywise';
proc print data=WORK.call_volume;
by day; 
run;

/* Call volume subset */
Data call_Volume_subset;
set WORK.call_volume;
if volume > 1000 and volume< 100000;
run;


title 'Overall mean of the call volume';
proc means data=call_Volume_subset mean;
var volume ;
run;

title 'Mean of the call volume in 1 to 8 Hours';
proc means data=call_Volume_subset mean;
var volume; 
where Hour < 9; 
run;

title 'Mean of the call volume in 9 to 24 Hours';
proc means data=call_Volume_subset mean;
var volume;
where  Hour ge 9;
run;
title;


/*Import the customer loans raw data  into SAS */

PROC IMPORT OUT= WORK.cust_cred_raw 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\7. Data Exploration and Cleaning\Datasets\Customer_loan_data.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/*Step-1: Data Exploration & Validation using the contents*/ 

title 'Proc Contents on raw data';
proc contents data=	WORK.cust_cred_raw varnum ;
run;

/*Step-1: Data Exploration & Validation proc print(snap shot)*/ 
title 'Proc Print on raw data (firt 20 observations only)';
proc print data=WORK.cust_cred_raw (obs=20) ;
run;


title 'Univariate on Sr_num';
proc univariate data=WORK.cust_cred_raw;
var sr_num;
run;


/* Monthly income & number of dependents Character issue*/
Data cust_cred_raw_v1;
set  cust_cred_raw;
MonthlyIncome_new=	MonthlyIncome*1;
NumberOfDependents_new=NumberOfDependents*1;
run;

title 'Proc Contents on data version1';
proc contents data=	cust_cred_raw_v1 varnum ;
run;


/*Step-3: Univariate Analysis*/

title 'Proc Univriate on utilization -RevolvingUtilizationOfUnsecuredL ';
Proc univariate data= cust_cred_raw_v1;
var RevolvingUtilizationOfUnsecuredL;
run;
title 'Proc Univriate and boxplot on utilization  ';
Proc univariate data= cust_cred_raw_v1 plot;
var RevolvingUtilizationOfUnsecuredL;
run;

title 'Proc Univariate and boxplot on utilization less than or equal to 100% ';
Proc univariate data= cust_cred_raw_v1 plot;
var RevolvingUtilizationOfUnsecuredL;
where  RevolvingUtilizationOfUnsecuredL <=1;
run;

title ' Univariate on monthly  income ';
Proc univariate data= cust_cred_raw_v1 ;
var MonthlyIncome_new;
run;

/*
Sr_num SeriousDlqin2yrs RevolvingUtilizationOfUnsecuredL age NumberOfTime30_59DaysPastDueNotW 
DebtRatio MonthlyIncome NumberOfOpenCreditLinesAndLoans NumberOfTimes90DaysLate NumberRealEstateLoansOrLines
NumberOfTime60_89DaysPastDueNotW NumberOfDependents obs_type MonthlyIncome_new NumberOfDependents_new */


title ' Frequency  table for  Serious delinquency in 2 years ';
proc freq data=	cust_cred_raw_v1;
table SeriousDlqin2yrs;
run;

title ' Frequency  table for  obs_type ';
proc freq data=	cust_cred_raw_v1;
table obs_type;
run;


title ' Frequency  table for  30-59 days past due ';
proc freq data=	cust_cred_raw_v1;
table NumberOfTime30_59DaysPastDueNotW;
run;

title ' Frequency  table for  60-89, 90+ days past due ';
proc freq data=	cust_cred_raw_v1;
table NumberOfTime60_89DaysPastDueNotW 	NumberOfTimes90DaysLate;
run;

title ' Frequency  table for All discrete variables ';
proc freq data=cust_cred_raw_v1  ;
tables
age 
NumberOfOpenCreditLinesAndLoans
NumberRealEstateLoansOrLines
NumberOfDependents_new;
run;

title ' Frequency  table for All discrete variables with missing %';
proc freq data=cust_cred_raw_v1  ;
tables
age 
NumberOfOpenCreditLinesAndLoans
NumberRealEstateLoansOrLines
NumberOfDependents_new/missing;
run;


title 'Proc Univariate and boxplot on utilization less than or equal to 100% ';
Proc univariate data= cust_cred_raw_v1 plot;
var RevolvingUtilizationOfUnsecuredL;
where  RevolvingUtilizationOfUnsecuredL <=1;
run;

title 'Treating utilization ';
data  cust_cred_raw_v2;
set cust_cred_raw_v1;
if RevolvingUtilizationOfUnsecuredL >1 then utilization_new=0.304325;
else  utilization_new= RevolvingUtilizationOfUnsecuredL;
run;

title 'New utilization univariate ';
Proc univariate data= cust_cred_raw_v2 plot;
var utilization_new;
run;

title 'Treating Monthly income ';
data  cust_cred_raw_v2;
set  cust_cred_raw_v2;
if 	MonthlyIncome_new =. then 	MonthlyIncome_ind =1 ;
else  MonthlyIncome_ind = 0;
run;

data  cust_cred_raw_v2;
set  cust_cred_raw_v2;
if 	MonthlyIncome_new =. then 	MonthlyIncome_final=5400.000 ;
else  MonthlyIncome_final = MonthlyIncome_new;
run;

title 'Univariate Analysis on Final  Monthly income ';
Proc univariate data= cust_cred_raw_v2 ;
var MonthlyIncome_final;
run;

title 'Cross tab frequency of NumberOfTime30_59DaysPastDue1 and SeriousDlqin2yrs';
proc freq data=cust_cred_raw_v2;
tables 	NumberOfTime30_59DaysPastDueNotW*SeriousDlqin2yrs;
run;

title 'Treating 30DPD';
data cust_cred_raw_v2;
set   cust_cred_raw_v2; 
if 	NumberOfTime30_59DaysPastDueNotW in (96, 98) then  	NumberOfTime30_59DaysPastDue1= 6;
else  NumberOfTime30_59DaysPastDue1= NumberOfTime30_59DaysPastDueNotW;
run;

proc freq data=cust_cred_raw_v2;
tables NumberOfTime30_59DaysPastDue1;
run;
