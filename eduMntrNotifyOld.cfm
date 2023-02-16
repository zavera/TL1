<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>CCTSI TL1 Program</title>
<link href="/cctsi/cctsi.css" rel="stylesheet" type="text/css">
</head>

<body>
	
<div id="ApplicationData">
<img src="/cctsi/cctsiBasic.png">
<h2>CCTSI TL1 <cfoutput>#Application.pgmNme#</cfoutput></h2>


<cfquery name="mntrNme" datasource="#Application.PITdb#">
  select *
  from tottsAcceptMntr
 where recid in (8,9,10,11)
</cfquery>

<cfloop query="mntrNme">

<!--- now put mentors into table --->

<cfquery name="mxPRcID" datasource="#Application.PITdb#">
  select (max(recID) + 1) AS newId
  FROM baselineMntrTotts
</cfquery>

<cfif (#len(mxPRcID.newID)# GT 0)>
	<cfset mxPR = #mxPRcID.newID#>
<cfelse>
	<cfset mxPR = 1>
</cfif>

<cftransaction>
<cfquery datasource="#Application.PITdb#">
INSERT baselineMntrTotts (recid, pgmrecid, webts, fstNme, lstNme, emlAddrss, program, yr,edmth)
VALUES (#mxPR#, #mntrNme.precid#, #Now()#, 
<cfqueryparam value = '#mntrNme.mntfstnme1#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#mntrNme.mntlstnme1#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#mntrNme.mnteml1#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#Application.pgmNme2#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = #datepart("yyyy",Now())# cfsqltype = "cf_sql_integer">,
<cfqueryparam value = '7'>
)
</cfquery>
</cftransaction>


<cfmail FROM="galit.mankin@ucdenver.edu"
	TO="#mntrNme.mnteml1#"
	CC="#mntrNme.eml#"
	BCC = "galit.mankin@ucdenver.edu ; swan.ellert@ucdenver.edu"
	SUBJECT="Mentor Information Request - #Application.pgmNme# program (PI: #mntrNme.fstNme# #mntrNme.lstNme#)"
	TYPE="HTML">
<!---
<cfmail FROM="galit.mankin@ucdenver.edu"
	TO="#mntrNme.mnteml1#"
	CC="#mntrNme.eml#"
	SUBJECT="Mentor Information Request - #Application.pgmNme# program (PI: #mntrNme.fstNme# #mntrNme.lstNme#)"
	TYPE="HTML">
--->
	
<p>You have been listed as a mentor on a CCTSI Education, Training & Career Development <cfoutput>#Application.pgmNme#</cfoutput> grant for PI <cfoutput>#mntrNme.fstNme# #mntrNme.lstNme#</cfoutput></p>

<p>Please fill out the mentor information for this grant by <cfoutput>#Application.pgmEndDt#</cfoutput> at:
<br><a href="https://cctsiapps.ucdenver.edu/education/<cfoutput>#Application.appGt#</cfoutput>/eduMntr.cfm?ref=<cfoutput>#mxPR#</cfoutput>">https://cctsiapps.ucdenver.edu/education/<cfoutput>#Application.appGt#</cfoutput>/eduMntr.cfm?ref=<cfoutput>#mxPR#</cfoutput></a>

</cfmail>


<cfset mxPR = mxPR + 1>

<cftransaction>
<cfquery datasource="#Application.PITdb#">
INSERT baselineMntrTotts (recid, pgmrecid, webts, fstNme, lstNme, emlAddrss, program, yr,edmth)
VALUES (#mxPR#, #mntrNme.precid#, #Now()#, 
<cfqueryparam value = '#mntrNme.mntfstnme2#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#mntrNme.mntlstnme2#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#mntrNme.mnteml2#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#Application.pgmNme2#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = #datepart("yyyy",Now())# cfsqltype = "cf_sql_integer">,
<cfqueryparam value = '7'>
)
</cfquery>
</cftransaction>

<cfmail FROM="galit.mankin@ucdenver.edu"
	TO="#mntrNme.mnteml2#"
	CC="#mntrNme.eml#"
	BCC = "galit.mankin@ucdenver.edu ; swan.ellert@ucdenver.edu"
	SUBJECT="Mentor Information Request - #Application.pgmNme# program (PI: #mntrNme.fstNme# #mntrNme.lstNme#)"
	TYPE="HTML">
	
<p>You have been listed as a mentor on a CCTSI Education, Training & Career Development <cfoutput>#Application.pgmNme#</cfoutput> grant for PI <cfoutput>#mntrNme.fstNme# #mntrNme.lstNme#</cfoutput></p>

<p>Please fill out the mentor information for this grant by <cfoutput>#Application.pgmEndDt#</cfoutput> at:
<br> <a href="https://cctsiapps.ucdenver.edu/education/<cfoutput>#Application.appGt#</cfoutput>/eduMntr.cfm?ref=<cfoutput>#mxPR#</cfoutput>">https://cctsiapps.ucdenver.edu/education/<cfoutput>#Application.appGt#</cfoutput>/eduMntr.cfm?ref=<cfoutput>#mxPR#</cfoutput></a>

</cfmail>

<cfoutput>Done: #mntrNme.eml#...#mntrNme.mnteml1#...#mntrNme.mnteml2# <br></cfoutput>

</cfloop>

</div>

</body>
</html>


