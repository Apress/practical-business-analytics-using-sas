
proc print data=sashelp.air;
run;

proc contents data=sashelp.air;
run;

proc print data=sashelp.air(obs=10);
run;

data  sasdata.air_data;
set  sashelp.air;
run;

libname mydata 'C:\Users\venk\Documents\Training\Books\Content\3 SAS Data Manipulations\Datasets';

data mydata.income;
input income expense;
datalines;
4500 2000
5000 2300
7890 2810
8900 5400
2300 2000
;
run;

data work.income;
input income expense;
datalines;
4500 2000
5000 2300
7890 2810
8900 5400
2300 2000
;
run;

data income;
input income expense;
datalines;
4500 2000
5000 2300
7890 2810
8900 5400
2300 2000
;
run;
/*Importing SAT_Exam.csv*/
PROC IMPORT OUT= MYDATA.sat_exam 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\3 SAS Data Manipulations\Datasets\SAT_Exam.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/*Importing Burger_sales.csv*/
PROC IMPORT OUT= MYDATA.burger 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\3 SAS Data Manipulations\Datasets\Burger_sales.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/*Importing Burger_sales.XLS*/
PROC IMPORT OUT= MYDATA.BURGER_sales_from_excel 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\3 SAS Data Manipulations\Datasets\Burger_sales.xls" 
            DBMS=EXCEL REPLACE;
     RANGE="Burger_sales$"; 
     GETNAMES=YES;
   RUN;
/*Importing tab delimited text file*/
PROC IMPORT OUT= MYDATA.SAT_EXAM_data_from_text_file 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\3 SAS Data Manipulations\Datasets\SAT_Exam.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/* Making a copy of SAS Data*/
data MYDATA.sat_exam_copy;
set  MYDATA.sat_exam;
run;
data sat_exam_copy;
set  MYDATA.sat_exam;
run;
/* Importing Market campaign data*/
PROC IMPORT OUT= MYDATA.market 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\3 SAS Data Manipulations\Datasets\Market_campaign.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/* Sanpshot of market campain data*/
proc print data=MYDATA.market(obs=10);
run;

/* New variable creation*/
data new_data;
set old_data;
<new var statement>;
run;

/* New variable in market campaign*/

data MYDATA.market_v1;
set MYDATA.market;
budget_new=budget*1.12;
run;

proc print data= MYDATA.market_v1(obs=10);
run;

data MYDATA.market_v2;
set MYDATA.market_v1;
net_reach=reach*0.8;
run;


proc print data= MYDATA.market_v2(obs=10);
run;

Data MYDATA.market_v3;
set  MYDATA.market;
budget_new=budget*1.12;
net_reach=reach*0.8;
run;

proc print data= MYDATA.market_v3(obs=10);
run;

Data MYDATA.market_v4;
set  MYDATA.market;
reach_per_dollar=reach/budget;
run;
proc print data= MYDATA.market_v4(obs=10);
run;

/* Creating new variable using if then else*/

Data MYDATA.market_v5;
set  MYDATA.market;
if reach<33 then reach_ind='Low';
else if reach >= 33 and reach <=66 then reach_ind='Med';
else reach_ind='High';
run;

proc print data= MYDATA.market_v5(obs=10);
run;

Data MYDATA.market_v6;
set  MYDATA.market;
if reach<20000 then budget_ind='Low';
else if reach >= 20000 and reach <=75000 then budget_ind='Med';
else budget_ind='High';
run;

proc print data= MYDATA.market_v6(obs=10);
run;


/*Updating the same dataset*/
Data MYDATA.market;
set MYDATA.market;
budget_new=budget*1.12;
net_reach=reach*0.8;
run;

proc print data= MYDATA.market(obs=10);
run;

/*Drop and Keep statements*/
Data MYDATA.market_v7;
set MYDATA.market(keep=camp_id name  budget);
run;

proc print data= MYDATA.market_v7(obs=10);
run;

Data MYDATA.market_v8;
set MYDATA.market(Drop=start_date end_date);
run;

proc print data= MYDATA.market_v8(obs=10);
run;

/* Subsetting of the data*/
Data MYDATA.market_v9;
set MYDATA.market ;
where Category='Healthcare';
run;

proc print data= MYDATA.market_v9(obs=10);
run;

Data MYDATA.market_v10;
set MYDATA.market ;
if Category='Healthcare';
run;

proc print data= MYDATA.market_v10(obs=10);
run;

/* Difference between where and if*/

proc print data= MYDATA.market;
where Category='Healthcare';
run;


proc print data= MYDATA.market;
if Category='Healthcare';
run;
