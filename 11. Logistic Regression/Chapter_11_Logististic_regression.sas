/* Importing Ice cream sales data*/
PROC IMPORT OUT= WORK.ice_cream_sales 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\11. Logistic Regression\Data\IceCream_sales.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/* Contents of the Ice cream sales data*/
proc contents data=	ice_cream_sales varnum;
run;
/* Fitting a simple regression line to predict buy_ind*/
proc reg data=ice_cream_sales;
model buy_ind=age;
run;
/* Fitting a logistic Regression line to predict buy_ind*/
proc logistic data=ice_cream_sales;
model buy_ind=age;
run;

/* Loans Data Case Study*/
PROC IMPORT OUT= WORK.loans_data 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\11. Logistic Regression\Data\Customer_Loans.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/* Basic Checks on the data*/
proc contents data=loans_data varnum ;
run;
proc print data=loans_data(obs=20);
run;

/* Fitting a logistic Rgeression Line*/
proc contents data=loans_data varnum short;
run;

/* Model*/
proc logistic data=loans_data;
model SeriousDlqin2yrs = utilization Age Num_loans Num_dependents MonthlyIncome Num_Savings_Acccts DebtRatio;
run;

/* VIF Option*/
proc logistic data=loans_data;
model SeriousDlqin2yrs = utilization Age Num_loans Num_dependents MonthlyIncome Num_Savings_Acccts DebtRatio/vif;
run;


/* VIF Option in PROC REG*/
proc reg data=loans_data;
model SeriousDlqin2yrs = utilization Age Num_loans Num_dependents MonthlyIncome Num_Savings_Acccts DebtRatio/vif;
run;


/* Descending otion in  Model*/
proc logistic data=loans_data descending;
model SeriousDlqin2yrs = utilization Age Num_loans Num_dependents MonthlyIncome Num_Savings_Acccts DebtRatio;
run;

/* Final Model After Dropping Num_Savings_Acccts */
proc logistic data=loans_data descending;
model SeriousDlqin2yrs = utilization Age Num_loans Num_dependents MonthlyIncome  DebtRatio;
run;



























