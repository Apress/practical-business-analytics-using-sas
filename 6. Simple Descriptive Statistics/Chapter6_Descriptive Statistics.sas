PROC IMPORT OUT= WORK.online_sales 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\6. Simple Descriptive Statistics\Datasets\Online_sales.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/* Printing first few observations of the data*/
proc print data =  online_sales (obs=20);
run;

/* Sorting data based on list price*/
proc sort data=online_sales ;
by listPrice ;
run;
/* Sorting data based on list price in descending order*/
proc sort data=online_sales ;
by descending listPrice  ;
run;

/* Printing first few observations of the data*/
proc print data = online_sales (obs=20);
run;

/*Average list price */
proc means data=online_sales ;
var listPrice;
run;

/*To print just the mean */
proc means data=online_sales mean;
var listPrice;
run;

/*Mean list price by brand */
proc means data=online_sales mean;
var listPrice;
class brand;
run;

/*Meadian of list price */
proc means data=online_sales median;
var listPrice;
run;

/*Mode of list price */
proc means data=online_sales mode;
var listPrice;
run;

/*Mode of Shipping period */
proc means data=online_sales mode;
var shippingPeriod;
run;

/*Mean of Shipping period */
proc means data=online_sales mean;
var shippingPeriod;
run;

/* Variance in list price */

proc means data=online_sales var;
var listPrice;
run;

/* SD in list price */
proc means data=online_sales std ;
var listPrice;
run;

/* SD in list price for each brand */
proc means data=online_sales std ;
var listPrice;
class brand;
run;
/* Import Helathcalim data*/
PROC IMPORT OUT= WORK.health_claim
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\6. Simple Descriptive Statistics\Datasets\Health_claim_data.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/************ Analysis on Claim Amount */
proc contents data=	health_claim varnum; 
run;

/* Mean claim amount*/
proc means data= health_claim  ;
var  Claim_amount;
run;

/* Mean and Meadian of claim amount*/
proc means data= health_claim  mean median;
var  Claim_amount;
run;

/* SD of claim amount*/
proc means data= health_claim std;
var  Claim_amount;
run;
/* quantiles of list price*/
proc univariate data= online_sales  ;
var  listPrice ;
run;

/* quantiles of claim amount*/
proc univariate data= health_claim  ;
var  Claim_amount ;
run;



/* Boxplot of claim amount*/
proc univariate data= health_claim  plot;
var  Claim_amount ;
run;
proc contents data=	health_claim; run;


/* Boxplot of claim amount with condition*/
proc univariate data= health_claim  plot;
var  Claim_amount ;
where  Claim_amount<6149;
run;

proc univariate data= health_claim  plot;
var  Claim_amount ;
where Claim_amount>20 and Claim_amount<6149;
run;


/* Boxplot of list price*/
proc univariate data= online_sales plot ;
var  listPrice ;
run;
/* Boxplot of list pric with conditione*/
proc univariate data= online_sales plot ;
var  listPrice ;
where listPrice<44500;
run;
