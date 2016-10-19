/* Importing the smart phone data*/
PROC IMPORT OUT= WORK.mobiles 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\10. Multiple Regression\Datasets\Regression_mobile_phones.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
/*Printing the contents of the data*/
proc contents data=	mobiles varnum short;
run;
/* Multiple Regression line for Smartphone sales example*/
proc reg data= mobiles;
model sales= Ratings Price Num_new_features Stock_market_ind Market_promo_budget  ;
run;

/* For F test*/
proc reg data= mobiles;
model sales= Price  ;
run;


/* Multiple Regression model without Stock_market_ind */
proc reg data= mobiles;
model sales= Ratings Price Num_new_features  Market_promo_budget  ;
run;


/* Multiple Regression model without Ratings and Stock_market_ind */
proc reg data= mobiles;
model sales=  Price Num_new_features  Market_promo_budget  ;
run;
/* Multiple Regression model without impactful variable */
proc reg data= mobiles;
model sales= Ratings  Num_new_features  Market_promo_budget  ;
run;
proc reg data= mobiles;
model sales= Ratings Price   Market_promo_budget  ;
run;
proc reg data= mobiles;
model sales= Ratings Price Num_new_features   ;
run;

/* Importing Sample Regression Dataset*/

PROC IMPORT OUT= WORK.sample_regression 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\10. Multiple Regression\Datasets\sample_regression.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/* Regression on Sample Regression Dataset*/
proc reg data=sample_regression;
model y=x1 x2 x3;
run;
proc reg data=sample_regression;
model y=x1 x2 x3 x4 x5 x6;
run;
proc reg data=sample_regression;
model y=x1 x2 x3  x4 x5 x6 x7 x8;
run;
/* Smart phone sales R-Squared and Adj-R Squared*/
proc reg data= mobiles;
model sales= Ratings Price Num_new_features Stock_market_ind Market_promo_budget  ;
run;
/* Smart phone sales R-Squared and Adj-R Squared With out Stock Market*/
proc reg data= mobiles;
model sales= Ratings Price Num_new_features  Market_promo_budget  ;
run;
/* Importing SAT exam Data*/
PROC IMPORT OUT= WORK.sat_score 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\10. Multiple Regression\Datasets\SAT_Exam.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc contents data=	WORK.sat_score varnum short;
run;

proc print data= sat_score(obs=10) ;
run;

/* Predicting SAT score using rest of the Variables*/
proc reg data=sat_score;
model SAT=General_knowledge Aptitude Mathematics Science ;
run;

/* Predicting SAT score using Two variable only*/
proc reg data=sat_score;
model SAT=General_knowledge Science ;
run;

/* Predicting SAT score using Two variable only*/
proc reg data=sat_score;
model SAT=Mathematics Aptitude ;
run;

/*Correlations in SAT exam data*/
proc corr data=sat_score;
var General_knowledge Aptitude Mathematics Science ;
run;

/* Importing one record updated data*/
PROC IMPORT OUT= WORK.sat_score_updated 
            DATAFILE= "C:\Users\venk\Documents\Training\Books\Content\10. Multiple Regression\Datasets\SAT_Exam_one_record_updated.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc reg data=sat_score_updated;
model SAT=General_knowledge Aptitude Mathematics Science ;
run;


/*Detecting multicollinearity VIF*/
proc reg data=sat_score;
model SAT=General_knowledge Aptitude Mathematics Science/VIF ;
run;

/*Detecting multicollinearity VIF without Science*/
proc reg data=sat_score;
model SAT=General_knowledge Aptitude Mathematics /VIF ;
run;

/*Removing multicollinearity */
proc reg data=sat_score;
model SAT=General_knowledge Aptitude Mathematics Science/VIF ;
run;

/*Removing multicollinearity  without Mathematics*/
proc reg data=sat_score;
model SAT=General_knowledge Aptitude  Science/VIF ;
run;

/*Removing multicollinearity  without Mathematics and GK*/
proc reg data=sat_score;
model SAT= Aptitude  Science/VIF ;
run;

/* Final Check List Smart phone sales*/
proc reg data= mobiles;
model sales= Ratings Price Num_new_features Stock_market_ind Market_promo_budget/vif  ;
run;

/*Drop stock market*/
proc reg data= mobiles;
model sales= Ratings Price Num_new_features  Market_promo_budget/vif  ;
run;

