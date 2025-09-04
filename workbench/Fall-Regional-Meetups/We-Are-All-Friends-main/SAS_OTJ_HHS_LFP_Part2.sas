*libname acs "We-Are-All-Friends/";

**************************************************************  Import Raw data file from Git;
filename us1 url 'https://raw.githubusercontent.com/lincolngroves/We-Are-All-Friends/main/covid_labor_supply_us.csv';

proc import datafile=us1
    out=covid_labor_supply_us
    dbms=csv
    replace;
run;


*-------------------------------------------------------------------------------------*
| 	   						  Examine Current Trends 								  | 
|						  Part I: Adjust Graph Settings								  |
*-------------------------------------------------------------------------------------*;

**********************************************  Assign colors and symbols to plot lines;
symbol1 interpol=join line=1 	color=bl 	;
symbol2 interpol=join line=2	color=b 	;
symbol3 interpol=join line=3	color=br 	;
symbol4 interpol=join line=4	color=g 	;
symbol5 interpol=join line=5	color=p 	;

**********************************************  Format Axis;
legend1 position=(top center inside)label=none mode=share frame;

*-------------------------------------------------------------------------------------*
|			 				Part II: Macro Loops									  |
*-------------------------------------------------------------------------------------*;

************************************  Define Variable List to Simplify Coding ;
%macro hilfe(from,to,by,var1,varlist2,title);

	***********************************************  Format axis for current range ;
	axis2 	order=(&from to &to by &by ) offset=(0,0) label=none minor=(n=1);


	**********************************************  Overlay Plot ;
	title3 h=1.75pct &title;
	proc gplot data=covid_labor_supply_us;
	   plot ( &var1 	)	* YearQuarter 
	   		( &varlist2 ) 	* YearQuarter 
			 /	overlay
				legend=legend1
		        vaxis=axis2
		        vref=&from to &to by .05
		        lvref=2;
	run;
	quit;

%mend;


**************************************************  Unemployment ;
%hilfe(0,.20,.02,UE_Women,UE_BlackWomen UE_HispanicWomen UE_WhiteWomen UE_OtherWomen,			"Unemployment Analysis | By Race and Ethnicity");
%hilfe(0,.20,.02,UE_Women,UE_Women_LTHS UE_Women_HS UE_Women_SCollege UE_Women_CollegeP,		"Unemployment Analysis | By Education Level");
%hilfe(0,.20,.02,UE_Women,UE_Women_NoKids UE_Women_OlderKids UE_Women_YoungKids,				"Unemployment Analysis | By Child Status");


**************************************************  Labor Force Participation ;
%hilfe(0.6,1,.05,LFP_Women,LFP_BlackWomen LFP_HispanicWomen LFP_WhiteWomen LFP_OtherWomen,		"Labor Force Participation Analysis | By Race and Ethnicity");
%hilfe(0.6,1,.05,LFP_Women,LFP_Women_LTHS LFP_Women_HS LFP_Women_SCollege LFP_Women_CollegeP,	"Labor Force Participation Analysis | By Education Level");
%hilfe(0.6,1,.05,LFP_Women,LFP_Women_NoKids LFP_Women_OlderKids LFP_Women_YoungKids,			"Labor Force Participation Analysis | By Child Status");


*-------------------------------------------------------------------------------------*
|		 	   						Backup Tables							  		  | 
*-------------------------------------------------------------------------------------*;

%macro backup(var,title);
	title3 h=1.75pct &title;
	proc print data=covid_labor_supply_us noobs label;
		var YearQuarter ue_: ;
	run;
%mend;

%backup(ue_:,"Backup Tables - Unemployment Rates");
%backup(lfp_:,"Backup Tables - Labor Force Participation Rates";);


*-------------------------------------------------------------------------------------*
|    	   						  Collapse Data 									  | 
|	                    	Produce State-Level Estimates          	          		  |
*-------------------------------------------------------------------------------------*;

********************************************************  Import Original File Directly from Git ;
filename acs_url url 'https://raw.githubusercontent.com/lincolngroves/SAS-OTJ-HHS/main/ACS_2015_2022_ltd.csv';
                
data acs_2015_2022    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */

    infile acs_url delimiter = ',' MISSOVER DSD  firstobs=2 ;

    informat State_FIP best32. ;
    informat State_Name $20. ;
    informat YearQuarter YYQ6. ;
    informat Race_Ethnic $21. ;
    informat EDUC_LTD $19. ;
    informat Child_Status $14. ;
    informat Unemp best32. ;
    informat in_LF best32. ;
    informat WTFINL best32. ;

    format State_FIP best12. ;
    format State_Name $20. ;
    format YearQuarter YYQ6. ;
    format Race_Ethnic $21. ;
    format EDUC_LTD $19. ;
    format Child_Status $14. ;
    format Unemp best12. ;
    format in_LF best12. ;
    format WTFINL best12. ;

    input
        State_FIP
        State_Name  $
        YearQuarter
        Race_Ethnic  $
        EDUC_LTD  $
        Child_Status  $
        Unemp
        in_LF
        WTFINL
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
run;

********************************************************  By State ;
proc sql;
	create 	table covid_labor_supply2 as 
	select	distinct state_fip, state_name, 
            year(yearquarter) as Year format 9.,
			
/*******************************************************************  Labor Force Status | All  */
			sum( ( unemp=1 ) * WTFINL ) 											/ sum( ( in_LF=1 ) *   	WTFINL )									as UE_Women				label="Unemployment Rate"	format percent9.1 		,
			sum( ( in_LF=1 ) * WTFINL ) 											/ sum(  				WTFINL )									as LFP_Women			label="LFP Rate"			format percent9.1 		,


/*******************************************************************  Labor Force Status | By Education  */

			/*******************************************************  Unemployment */
			sum( ( educ_ltd="High School Diploma" ) * ( unemp=1 ) * WTFINL ) 		/ sum( ( educ_ltd="High School Diploma" ) * ( in_LF=1 ) * WTFINL )	as UE_Women_HS			label="EDUC <= HS" 		format percent9.1 		,
			sum( ( educ_ltd="Some College" ) * ( unemp=1 ) * WTFINL ) 				/ sum( ( educ_ltd="Some College" ) * ( in_LF=1 ) * WTFINL ) 		as UE_Women_SCollege	label="Some College"	format percent9.1 		,
			sum( ( educ_ltd="College +" ) * ( unemp=1 ) * WTFINL ) 					/ sum( ( educ_ltd="College +" ) * ( in_LF=1 ) * WTFINL ) 			as UE_Women_CollegeP	label="College +" 		format percent9.1 		,

			/*******************************************************  LFP */
			sum( ( educ_ltd="High School Diploma" ) * ( in_LF=1 ) * WTFINL ) 		/ sum( ( educ_ltd="High School Diploma" ) * WTFINL ) 				as LFP_Women_HS			label="EDUC <= HS" 		format percent9.1 		,
			sum( ( educ_ltd="Some College" ) * ( in_LF=1 ) * WTFINL ) 				/ sum( ( educ_ltd="Some College" ) * WTFINL ) 						as LFP_Women_SCollege	label="Some College" 	format percent9.1 		,
			sum( ( educ_ltd="College +" ) * ( in_LF=1 ) * WTFINL ) 					/ sum( ( educ_ltd="College +" ) * WTFINL ) 							as LFP_Women_CollegeP	label="College +" 		format percent9.1 		,


/*******************************************************************  Labor Force Status | By Child Status  */

			/*******************************************************  Unemployment */
			sum( ( child_status="No Children" ) * ( unemp=1 ) * WTFINL ) 			/ sum( ( child_status="No Children" ) * ( in_LF=1 ) * WTFINL ) 		as UE_Women_NoKids		label="No Children" 	format percent9.1 		,
			sum( ( child_status="Older Children" ) * ( unemp=1 ) * WTFINL ) 		/ sum( ( child_status="Older Children" ) * ( in_LF=1 ) * WTFINL ) 	as UE_Women_OlderKids	label="Older Children" 	format percent9.1 		,
			sum( ( child_status="Child < 5" ) * ( unemp=1 ) * WTFINL ) 				/ sum( ( child_status="Child < 5" ) * ( in_LF=1 ) * WTFINL ) 		as UE_Women_YoungKids	label="Young Children"	format percent9.1 		,

			/*******************************************************  LFP */
			sum( ( child_status="No Children" ) * ( in_LF=1 ) * WTFINL ) 			/ sum( ( child_status="No Children" ) * WTFINL ) 					as LFP_Women_NoKids		label="No Children" 	format percent9.1 		,
			sum( ( child_status="Older Children" ) * ( in_LF=1 ) * WTFINL ) 		/ sum( ( child_status="Older Children" ) * WTFINL ) 				as LFP_Women_OlderKids	label="Older Children" 	format percent9.1 		,
			sum( ( child_status="Child < 5" ) * ( in_LF=1 ) * WTFINL ) 				/ sum( ( child_status="Child < 5" ) * WTFINL ) 						as LFP_Women_YoungKids	label="Young Children"	format percent9.1 		


	from 	acs_2015_2022
	group	by 1,2,3 
	order	by 1,2,3 ;
quit;

proc transpose data=covid_labor_supply2 out=tran1 (rename=(_label_=Group));
	by state_fip state_name year ;
run;


data 	ue 	(keep=state_fip state_name year group ue_rate)
		lfp (keep=state_fip state_name year group lfp_rate);
	set tran1 ;

	label 	group="Group" ;

	if 	index(_name_,"UE_")=1 then do;
		UE_Rate 		= col1 ;
		label 	UE_Rate = "Unemployment Rate" ;
		format 	UE_Rate percent9.1 ;
		output	ue ;
	end;

	else if index(_name_,"LFP_")=1 then do;
		LFP_Rate 		= col1 ;
		label 	LFP_Rate= "Labor Force Participation Rate" ;
		format 	LFP_Rate percent9.1 ;
		output	lfp ;
	end;
run;

*-----------------------------------------------------------------------------------------*
|		    	   				Unemployment Rate Analysis				  				  | 
*-----------------------------------------------------------------------------------------*;

**********************************************  By Education Level;
title3 h=1.75pct "Unemployment Analysis | By Education Level";
proc sgpanel data=ue;
	where group in ("Unemployment Rate" "EDUC <= HS" "Some College" "College +");
	panelby state_name / columns=3 rows=2 novarname ROWHEADERPOS=right ;
	series y=UE_Rate  x=Year 		/ group=group lineattrs=(thickness=2 pattern=solid);
	keylegend / title="" position=bottom;
	colaxis fitpolicy=thin valuesformat=best5. ;
run;
quit;


**********************************************   By Child Status;
title3 h=1.75pct "Unemployment Analysis | By Child Status";
proc sgpanel data=ue;
	where group in ("Unemployment Rate" "No Children" "Young Children" "Older Children");
	panelby state_name / columns=3 rows=2 novarname ROWHEADERPOS=right ;
	series y=UE_Rate  x=Year 		/ group=group lineattrs=(thickness=2 pattern=solid);
	keylegend / title="" position=bottom;
	colaxis fitpolicy=thin valuesformat=best5. ;
run;
quit;

*-----------------------------------------------------------------------------------------*
|		    	   						LFP Rate Analysis				  				  | 
*-----------------------------------------------------------------------------------------*;
	  
**********************************************  By Education Level;
title3 h=1.75pct "Labor Force Participation Rate Analysis | By Education Level";
proc sgpanel data=lfp;
	where group in ("Labor Force Participation Rate Rate" "EDUC <= HS" "Some College" "College +");
	panelby state_name / columns=3 rows=2 novarname ROWHEADERPOS=right ;
	series y=lfp_Rate  x=Year 		/ group=group lineattrs=(thickness=2 pattern=solid);
	keylegend / title="" position=bottom;
	colaxis fitpolicy=thin valuesformat=best5. ;
run;
quit;


**********************************************   By Child Status;
title3 h=1.75pct "Labor Force Participation Rate Analysis | By Child Status";
proc sgpanel data=lfp;
	where group in ("Labor Force Participation Rate Rate" "No Children" "Young Children" "Older Children");
	panelby state_name / columns=3 rows=2 novarname ROWHEADERPOS=right ;
	series y=lfp_Rate  x=Year 		/ group=group lineattrs=(thickness=2 pattern=solid);
	keylegend / title="" position=bottom;
	colaxis fitpolicy=thin valuesformat=best5. ;
run;
quit;