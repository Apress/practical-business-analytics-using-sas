PROC IMPORT OUT= WORK.market_asset 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\4. SAS Programs and Analytics\Datasets\Market_data_two.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc print data=market_asset(obs=10 ) noobs;
run;

Data market_asset_v1;
set market_asset;
mean_val=Mean(White_Paper, Case_Study);
run;

proc print data=market_asset_v1(obs=10) noobs;
run;

data market_asset_v2;
set market_asset;
sum_two=Sum(White_Paper,Case_Study);
min_two=min(White_Paper,Case_Study);
max_two=max(White_Paper,Case_Study);
mean_val=Mean(White_Paper, Case_Study);
run;

proc print data=market_asset_v2(obs=10)noobs;
run;



data market_asset_v3;
set market_asset;
num_asset_new=Sum(White_Paper, Webinar, Software_Download, Free_Offer, Live_Event, Case_Study);
Difference=	abs( num_asset_new-num_assets);
run;

proc print data=market_asset_v3(obs=10) noobs;
where  Difference ne  0;
run;


data market_asset_v4;
set market_asset;
name_part1=substr(name,1,10);
name_part2=substr(name,11,10);
run;

proc print data=market_asset_v4(obs=10) noobs;
run;

data  market_asset_v5;
set  market_asset;
length_name=length(name);
trim_name=trim(name);
Captial_name=Upcase(name);
Small_name=Lowcase(name);
run; 

proc print data=market_asset_v5(obs=10) noobs;
var id name length_name trim_name Captial_name	Small_name ;
run;


PROC IMPORT OUT= WORK.market_campaign 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\4. SAS Programs and Analytics\Datasets\Market_campaign.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/* Date Functions*/
data market_campaign_v1;
set market_campaign;
Duration_days=INTCK('day',start_date,end_date);
Duration_months=INTCK('month',start_date,end_date);
Duration_weeks=INTCK('week',start_date,end_date);
run;

proc print data=market_campaign_v1(obs=10) noobs;
var camp_id name Duration_days  Duration_months Duration_weeks;
run;

data market_campaign_v2;
set market_campaign;
start_month=month(start_date);
start_year=year(start_date);
run;

proc print data=market_campaign_v2(obs=10) noobs;
run;

/* Proc Contents here*/

proc contents data=sashelp.stocks;
run;

proc contents data=sashelp.stocks varnum;
run;

proc contents data=sashelp.stocks short;
run;
proc contents data=sashelp.stocks varnum short;
run;

/* Proc Sort Code*/

libname mydata 'C:\Users\venk\Documents\Training\Books\Content\4. SAS Programs and Analytics\Datasets';
PROC IMPORT OUT= MYDATA.bill
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\4. SAS Programs and Analytics\Datasets\Telco_Bill_data.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/* Sort on Bill amount*/
proc sort data=MYDATA.bill out=mydata.bill_top;
by Bill_Amount;
run;

proc print data=mydata.bill_top (obs=20);
run;

/* Sort on Bill amount descnding*/
proc sort data=MYDATA.bill out=mydata.bill_top;
by descending Bill_Amount ;
run;

proc print data=mydata.bill_top (obs=20);
run;


/* Sort by multiple variables*/
proc sort data=MYDATA.bill out=mydata.StartDate_bill_top;
by cust_account_start_date descending  Bill_Amount ;
run;

proc print data=mydata.StartDate_bill_top(obs=20);
run;

/* Sort With Where Condition*/
proc sort data=MYDATA.bill out=mydata.bill_top100k;
by descending Bill_Amount ;
where Bill_Amount>100000;
run;

proc print data=mydata.bill_top100k;
run;

/* Removing the duplicate records*/
proc sort data=MYDATA.bill out=mydata.bill_wod nodup;
by cust_id   ;
run;
proc contents data=MYDATA.bill; run;

/* Removing the duplicate records on key*/
proc sort data=MYDATA.bill out=mydata.bill_cust_wod nodupkey;
by Bill_Id ;
run;

/* Taking duplicates to a new file*/
proc sort data=MYDATA.bill out=mydata.bill_wod nodup dupout=mydata.nodup_cust_id  ;
by cust_id   ;
run;

proc print data=mydata.nodup_cust_id;
run;

proc sort data=MYDATA.bill out=mydata.bill_cust_wod nodupkey dpout=mydata.nodupkeys_bill_id ;
by Bill_Id ;
run;
proc print data=mydata.nodupkeys_bill_id;
run;

PROC IMPORT OUT= market_asset
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\4. SAS Programs and Analytics\Datasets\Market_asset.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/* Plotting in SAS */
symbol i=none;
proc gplot data= market_asset;
plot reach*budget;
run;


/* Sctter plot for a subset */
proc gplot data= market_asset;
plot reach*budget;
where budget  < 100000;
run;


/* Sctter plot for a subset */

proc gplot data= market_asset;
plot reach*budget;
where budget  < 10000;
run;

/* Bar Chart*/
proc gchart data= market_asset;
vbar category ;
Run;


/*pie Chart*/
proc gchart data= market_asset;
pie category ;
Run;

/* Bar3d Chart*/
proc gchart data= market_asset;
vbar3d category ;
Run;


/*pie3d Chart*/
proc gchart data= market_asset;
pie3d category ;
Run;


/* Sql*/

proc sql;
create table buss_fin
as select * 
from  market_asset
where Category=	'Business/Finance';
Quit;

proc print data=buss_fin(obs=10);
run;

/* Sql Group by*/
proc sql;
select  Category, sum(budget) as total_budget
from  market_asset
group by  Category;
Quit;

/* Data Merging*/
data students1;
input name $ maths;
cards;
Andy 78
Bill 90
Mark 80
Jeff 75
John 60
;
data students2;
input name $ science;
cards;
Andy 56
Bill 75
Mark 78
Fred 86
Alex 77
;

/* Appending the dataset*/
Data Students_1_2;
set students1 students2;
run;

proc print data=Students_1_2;
run;



/* Merging Example*/
proc sort data=students1;
by name;
run;
proc sort data=students2;
by name;
run;

data studentmerge;
Merge students1 students2;
by name;
run;

proc print data=studentmerge;
run;

/* Merging with conditions*/
proc sort data=students1;
by name;
run;
proc sort data=students2;
by name;
run;

data studentmerge1;
Merge students1(in=a) students2(in=b);
by name;
if a;
run;

proc print data= studentmerge1;
run;

/* Merging with condition2*/
data studentmerge2;
Merge students1(in=a) students2(in=b);
by name;
if b;
run;
proc print data= studentmerge2;
run;

/* Merging with condition3*/
data studentmerge3;
Merge students1(in=a) students2(in=b);
by name;
if a and b;
run;

proc print data= studentmerge3;
run;

/* Case study*/
PROC IMPORT OUT= WORK.complaints 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\4. SAS Programs and Analytics\Datasets\Telco_complaints_data.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= bill
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\4. SAS Programs and Analytics\Datasets\Telco_Bill_data.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;


/*1.	Sort the billing data by customer id and remove the duplicates.*/
proc sort data=	bill nodupkey;
by cust_id;
run;
/*2.	Create a consolidated dataset that contains only the existing billing customers who gave complaints.  
Attach the type of comment in the resultant dataset. Name the dataset as active_complaints data*/
proc sort data=	bill nodupkey;
by cust_id;
run;
proc sort data=	complaints nodupkey;
by cust_id;
run;

data  active_complaints;
merge  	bill(in=a)  complaints(in=b);
by 	cust_id;
if a and b;
run;

proc print data= active_complaints(obs=10) noobs;
run;

/*3.	Attach the billing details of customers to the customers who gave complaints.
We may want to use it to analyze the complaints along with usage information. */

data  complaints_bill;
merge  	bill(in=a)  complaints(in=b);
by 	cust_id;
if b;
run;

proc print data= complaints_bill(obs=10) noobs;
run;

proc sort data= complaints_bill;
by descending Bill_Amount;
run;

proc print data= complaints_bill(obs=10) noobs;
run;

/*4.	Attach the complaints details of customers to the customers are actively paying bill.
We may want to use it to analyze the usage patterns and along type of complains.*/

data  bill_with_complaints;
merge  	bill(in=a)  complaints(in=b);
by 	cust_id;
if a;
run;

proc print data= bill_with_complaints(obs=10) noobs;
run;

