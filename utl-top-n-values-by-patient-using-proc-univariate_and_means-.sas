Top N values by group using proc univariate and means                                                                     
                                                                                                                          
   Two Solutions                                                                                                          
        1. Proc univariate                                                                                                
        2. proc means and then untranspose(Arthur Tabachneck, Gerhard Svolba, Joe Matise and Matt Kastin)                 
           (ods output appears to be useless only a basic summary table is possible                                       
           There is not way to use stackodsoutput for top N)                                                              
                                                                                                                          
github                                                                                                                    
http://tinyurl.com/y6peyw9a                                                                                               
https://github.com/rogerjdeangelis/utl-top-n-values-by-patient-using-proc-univariate_and_means-                           
                                                                                                                          
These solutions works even when the data is not sorted by industry or value.                                              
Note the entire table needs to be scanned to get the top n.                                                               
                                                                                                                          
SAS Forum                                                                                                                 
http://tinyurl.com/y3ycaqdx                                                                                               
https://communities.sas.com/t5/SAS-Programming/Summary-of-top-3-values-by-group/m-p/538378                                
                                                                                                                          
*_                   _                                                                                                    
(_)_ __  _ __  _   _| |_                                                                                                  
| | '_ \| '_ \| | | | __|                                                                                                 
| | | | | |_) | |_| | |_                                                                                                  
|_|_| |_| .__/ \__,_|\__|                                                                                                 
        |_|                                                                                                               
;                                                                                                                         
                                                                                                                          
data have;                                                                                                                
  input memberid  $ industry amount;                                                                                      
cards4;                                                                                                                   
A2348 110 10045643                                                                                                        
A5469 110 9543376                                                                                                         
A2156 110 9034166                                                                                                         
D6765 110 4876                                                                                                            
B2345 110 46                                                                                                              
A5463 111 89                                                                                                              
A9876 111 30                                                                                                              
B8766 112 583497                                                                                                          
A5689 112 525488                                                                                                          
D9655 112 75158                                                                                                           
A4566 112 43866                                                                                                           
D6789 112 1865                                                                                                            
D4566 112 568                                                                                                             
A2876 112 366                                                                                                             
;;;;                                                                                                                      
run;quit;                                                                                                                 
                                                                                                                          
                                                                                                                          
WORK.HAVE total obs=14                                                                                                    
                                        |RULES                                                                            
 Obs  MEMBERID    INDUSTRY      AMOUNT  |                                                                                 
                                        |                                                                                 
 1     A2348         110      10045643  +------                                                                           
 2     A5469         110       9543376  | Top 3                                                                           
 3     A2156         110       9034166  +------                                                                           
 4     D6765         110          4876  |                                                                                 
 5     B2345         110            46  |                                                                                 
                                                                                                                          
 6     A5463         111            89  +------------------                                                               
 7     A9876         111            30  | Only output top 2                                                               
                                                                                                                          
 8     B8766         112        583497  +------                                                                           
 9     A5689         112        525488  | Top 3                                                                           
 10    D9655         112         75158  +------                                                                           
 11    A4566         112         43866  |                                                                                 
 12    D6789         112          1865  |                                                                                 
 13    D4566         112           568  |                                                                                 
 14    A2876         112           366  |                                                                                 
                                          * 8 observation out                                                             
*            _               _                                                                                            
  ___  _   _| |_ _ __  _   _| |_                                                                                          
 / _ \| | | | __| '_ \| | | | __|                                                                                         
| (_) | |_| | |_| |_) | |_| | |_                                                                                          
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                         
                |_|                                                                                                       
;                                                                                                                         
                                                                                                                          
1. Proc univariate output                                                                                                 
-------------------------                                                                                                 
                                                                                                                          
 WORK.WANT total obs=8                                                                                                    
                                                                                                                          
                        ASCENDING              OBSERVATION_                                                               
  VARNAME    INDUSTRY        TOP3    MEMBERID       NUMBER                                                                
                                                                                                                          
  AMOUNT       110        9034166     A2156            3                                                                  
  AMOUNT       110        9543376     A5469            2                                                                  
  AMOUNT       110       10045643     A2348            1                                                                  
                                                                                                                          
  AMOUNT       111             30     A9876            7                                                                  
  AMOUNT       111             89     A5463            6                                                                  
                                                                                                                          
  AMOUNT       112          75158     D9655           10                                                                  
  AMOUNT       112         525488     A5689            9                                                                  
  AMOUNT       112         583497     B8766            8                                                                  
                                                                                                                          
                                                                                                                          
2. proc means and then transpose                                                                                          
--------------------------------                                                                                          
                                                                                                                          
 WORK.WANT total obs=8                                                                                                    
                                                                                                                          
 INDUSTRY    INDEX    MEMBERID      AMOUNT                                                                                
                                                                                                                          
    110        1       A2348      10045643                                                                                
    110        2       A5469       9543376                                                                                
    110        3       A2156       9034166                                                                                
    111        1       A5463            89                                                                                
    111        2       A9876            30                                                                                
    112        1       B8766        583497                                                                                
    112        2       A5689        525488                                                                                
    112        3       D9655         75158                                                                                
                                                                                                                          
*          _       _   _                                                                                                  
 ___  ___ | |_   _| |_(_) ___  _ __  ___                                                                                  
/ __|/ _ \| | | | | __| |/ _ \| '_ \/ __|                                                                                 
\__ \ (_) | | |_| | |_| | (_) | | | \__ \                                                                                 
|___/\___/|_|\__,_|\__|_|\___/|_| |_|___/                                                                                 
                                                                                                                          
;                                                                                                                         
                                                                                                                          
1. Proc univariate                                                                                                        
------------------                                                                                                        
                                                                                                                          
ods exclude all;                                                                                                          
ods output extremeobs=want                                                                                                
   (keep=varname memberid_high high highobs industry                                                                      
    rename=(high=top3 highobs=observation_number memberid_high=memberid));                                                
                                                                                                                          
proc univariate data=have nextrobs=3;                                                                                     
class industry;                                                                                                           
id memberid;                                                                                                              
run;quit;                                                                                                                 
                                                                                                                          
ods select all;                                                                                                           
                                                                                                                          
                                                                                                                          
2. proc means and then untranspose                                                                                        
--------------------------------                                                                                          
                                                                                                                          
/* output summary=sumry useless for top N obs */;                                                                         
proc means data=have noprint nway /* useless stackodsoutput */;                                                           
   by Industry;                                                                                                           
   var Amount;                                                                                                            
   output out=havFat(drop=_:)                                                                                             
 idgroup( max(amount) out[3] (memberid industry amount)=);                                                                
run;quit;                                                                                                                 
                                                                                                                          
                                                                                                                          
data have;                                                                                                                
  input id income_2015-income_2017                                                                                        
           expenses_2015-expenses_2017                                                                                    
           ;                                                                                                              
cards4;                                                                                                                   
1 70000 75500 80000 60000 70000 81000                                                                                     
2 50000 52000 55000 42000 53000 60000                                                                                     
3 80000 90000 99000 70000 75000 85000                                                                                     
;;;;                                                                                                                      
run;quit;                                                                                                                 
                                                                                                                          
/*                                                                                                                        
WORK.HAVFAT total obs=3                                                                                                   
                                                                                                                          
            MEMBERID_  MEMBERID_ MEMBERID_ INDUSTRY_ INDUSTRY_ INDUSTRY_                                                  
 INDUSTRY       1          2         3         1         2         3     AMOUNT_1 AMOUNT_2 AMOUNT_3                       
                                                                                                                          
    110       A2348      A5469     A2156      110       110       110    10045643  9543376  9034166                       
    111       A5463      A9876                111       111         .          89       30        .                       
    112       B8766      A5689     D9655      112       112       112      583497   525488    75158                       
*/                                                                                                                        
                                                                                                                          
%untranspose(data=havFat,out=want,by=industry, delimiter=_,                                                               
  id=index, var=memberid industry amount );                                                                               
                                                                                                                          
/*                                                                                                                        
 WORK.WANT total obs=8                                                                                                    
                                                                                                                          
 INDUSTRY    INDEX    MEMBERID      AMOUNT                                                                                
                                                                                                                          
    110        1       A2348      10045643                                                                                
    110        2       A5469       9543376                                                                                
    110        3       A2156       9034166                                                                                
    111        1       A5463            89                                                                                
    111        2       A9876            30                                                                                
    112        1       B8766        583497                                                                                
    112        2       A5689        525488                                                                                
    112        3       D9655         75158                                                                                
*/                                                                                                                        
                                                                                                                          
                                                                                                                          
