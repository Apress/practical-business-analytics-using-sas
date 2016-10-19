/* Importing the data into SAS*/

PROC IMPORT OUT= WORK.ms 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\12. TimeSeries Analysis\Datasets\Microsoft_Stock.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/* Plotting the Series*/
symbol v=dot i=join;
proc gplot data= ms;
plot stock_price*date;
run;

/*Testing Stationarity using DF Test*/
proc arima data= ms;
identify var=stock_price	stationarity=(DICKEY);
run;
/*Creating a differentiated series*/
	data ms1;
	set ms;
	diff_stock_price=stock_price-lag1(stock_price);
	run;

proc print data= ms1(obs=10);
var  stock_price  diff_stock_price;
run;

proc arima data= ms1;
identify var=diff_stock_price	 stationarity=(DICKEY);
run;

/*ACF and PACF plots*/
proc arima data= ms1 plots=all;
identify var=diff_stock_price	 ;
run;


/*SCAN and EACF options*/
proc arima data= ms1 plots=all;
identify var=diff_stock_price	scan esacf ;
run;

/*SCAN and EACF options*/
proc arima data= tsdata.ts13 plots=all;
identify var=x	SCAN ESACF ;
run;
libname tsdata 'C:\Users\venk\Documents\Training\Books\Content\12. TimeSeries Analysis\Datasets\Sample Time Series Data';

proc arima data= tsdata.ts14 plots=all;
identify var=x	SCAN ESACF ;
run;

proc arima data= tsdata.ts15 plots=all;
identify var=x	SCAN ESACF ;
run;


PROC IMPORT OUT= web_views 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\12. TimeSeries Analysis\Datasets\Web_views.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/* Identification for Web Views Data*/
ods graphics on; /* Option to display graphics, if required*/
proc arima data= web_views plots=all;
identify var=Visitors	stationarity=(DICKEY)  ;
run;

/* Estimating the parameter*/
proc arima data=web_views;
identify var=Visitors ;
estimate p=1 q=0  method=ML;
run;

/*Residual plots verification*/
proc arima data=web_views;
identify var=Visitors ;
estimate p=0 q=0  method=ml;
run;


/* Forecasting using the model */
proc arima data=web_views;
identify var=Visitors ;
estimate p=1 q=0  method=ml;
forecast  lead=7 ;
run;

/* Importing Call Volume data*/
PROC IMPORT OUT= WORK.CALL_VOLUME 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\12. TimeSeries Analysis\Datasets\Call_volumes.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/*proc arima data=call_volume plots=all;*/
/*identify var=x SCAN ESACF;*/
/*estimate p=1 q=1 method=ML;*/
/*run;*/

/* Modeling time Call volume data*/
proc arima data=call_volume;
identify var=call_volume stationarity=(DICKEY);
run;

ods graphics on;
proc arima data=call_volume plots=all;
identify var=call_volume ;
run;
proc arima data=call_volume plots=all;
identify var=call_volume SCAN ESACF;
run;

proc arima data=call_volume plots=all;
identify var=call_volume SCAN ESACF;
estimate p=1 q=1 method=ML;
run;


proc arima data=call_volume plots=all;
identify var=call_volume SCAN ESACF;
estimate p=1 q=1 method=ML;
forecast lead=7;
run;



/* Accuracy*/
data call_volume1;
set  call_volume;
where day <= 295;
run;


proc arima data=call_volume1 plots=all;
identify var=call_volume SCAN ESACF;
estimate p=1 q=1 method=ML;
forecast lead=5;
run;
