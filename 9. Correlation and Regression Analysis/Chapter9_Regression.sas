PROC IMPORT OUT= WORK.add_budget 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\9. Regression Analysis\Data\Add_budget_data.xls" 
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
var Live_Budget Responses_live ;
run;
/* Importing telecom data*/
PROC IMPORT OUT= WORK.telecom 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\9. Regression Analysis\Data\Telecom_Csat_correlation.csv" 
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
/*********************************************/
/*Regression Analysis*/
/*********************************************/

/* Importing the smart phone data*/
PROC IMPORT OUT= WORK.mobiles 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\9. Regression Analysis\Data\Regression_mobile_phones.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/*Printing the contents of the data*/
proc contents data=	mobiles varnum ;
run;
/*Variables are Market_promo_budget Num_new_features Price Ratings Sales Stock_market_ind */
/* Correlation */
proc corr data=	mobiles;
var price sales;
run;

/* Importing burger sales data*/
PROC IMPORT OUT= WORK.burgers 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\9. Regression Analysis\Data\Burger_sales.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/* Correlation between visitors and burger sales*/
proc corr data=	burgers;
var visitors burgers;
run;

/*Scatter plot between the variables*/

proc gplot data= burgers;
plot burgers * visitors;
run;

/*Fitting a regression line*/
proc reg data= burgers;
model  burgers=visitors;
run;

proc reg data= burgers;
/*proc reg is for calling regression procedure*/
/* Dataset name is burgers*/
model  burgers=visitors;
/* We need to mention the dependent and independent variables in model statement*/
/* Model y=x */
/* Here the dependent variable us burgers and independent variable is visitors*/
run;
proc corr data=	mobiles;
run;
/* Regression model for mobile sales*/
proc reg data= mobiles;
model sales=Price  ;
run;

proc reg data= mobiles;
model sales=Ratings  ;
run;
proc reg data= mobiles;
model sales= Num_new_features  ;
run;
proc reg data= mobiles;
model sales= Stock_market_ind   ;
run;
proc reg data= mobiles;
model sales= Market_promo_budget ;
run;


 

