<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>CCTSI <cfoutput>#Application.pgmNme#</cfoutput> Mentor Confirmation</title>
<link href="/cctsi/cctsi.css" rel="stylesheet" type="text/css">
</head>
<body>


<cfset recid = #Form.ref#>

<cfif #len(Form.univ)# GT 2>
<cfset univv = Encrypt(#Form.univ#, #Application.key#,"DES","Hex")>
<cfelse>
<cfset univv = ''>
</cfif>

<cfset shllFr= "mentor">

<cfinclude template="/eall/all/setValuesAllSubmission.cfm"> 

<cftransaction>
<cfquery datasource="#Application.PITdb#">
update baselineMntr
set webts = #Now()#,
[degree-dds] = <cfqueryparam value = #dds# cfsqltype = "CF_SQL_INTEGER">,
[degree-dnp] = <cfqueryparam value = #dnp# cfsqltype = "CF_SQL_INTEGER">,
[degree-do] = <cfqueryparam value = #do# cfsqltype = "CF_SQL_INTEGER">,
[degree-dpt] = <cfqueryparam value = #dpt# cfsqltype = "CF_SQL_INTEGER">,
[degree-drph] = <cfqueryparam value = #drph# cfsqltype = "CF_SQL_INTEGER">,
[degree-ma] = <cfqueryparam value = #ma# cfsqltype = "CF_SQL_INTEGER">,
[degree-mba] = <cfqueryparam value = #mba# cfsqltype = "CF_SQL_INTEGER">,
[degree-md] = <cfqueryparam value = #md# cfsqltype = "CF_SQL_INTEGER">,
[degree-mdphd] = <cfqueryparam value = #mdphd# cfsqltype = "CF_SQL_INTEGER">,
[degree-ms] = <cfqueryparam value = #ms# cfsqltype = "CF_SQL_INTEGER">,
[degree-mph] = <cfqueryparam value = #mph# cfsqltype = "CF_SQL_INTEGER">,
[degree-pharmd] = <cfqueryparam value = #pharmd# cfsqltype = "CF_SQL_INTEGER">,
[degree-phd] = <cfqueryparam value = #phd# cfsqltype = "CF_SQL_INTEGER">,
[degree-psyd] = <cfqueryparam value = #psyd# cfsqltype = "CF_SQL_INTEGER">,
[degree-oth] = <cfqueryparam value = #dgroth# cfsqltype = "CF_SQL_INTEGER">, 
dgreother = <cfqueryparam value = '#FORM.dgreother#' cfsqltype = "cf_sql_char">, 
[affltn-chco] = <cfqueryparam value = #chco# cfsqltype = "CF_SQL_INTEGER">,
[affltn-csu] = <cfqueryparam value = #csu# cfsqltype = "CF_SQL_INTEGER">,
[affltn-dh] = <cfqueryparam value = #dh# cfsqltype = "CF_SQL_INTEGER">,
[affltn-dvamc] = <cfqueryparam value = #dvamc# cfsqltype = "CF_SQL_INTEGER">,
[affltn-kp] = <cfqueryparam value = #kp# cfsqltype = "CF_SQL_INTEGER">,
[affltn-njh] = <cfqueryparam value = #njh# cfsqltype = "CF_SQL_INTEGER">,
[affltn-ucamc] = <cfqueryparam value = #ucamc# cfsqltype = "CF_SQL_INTEGER">,
[affltn-ucb] = <cfqueryparam value = #ucb# cfsqltype = "CF_SQL_INTEGER">,
[affltn-ucd] = <cfqueryparam value = #ucd# cfsqltype = "CF_SQL_INTEGER">,
[affltn-uch] = <cfqueryparam value = #uch# cfsqltype = "CF_SQL_INTEGER">,
[affltn-oth] = <cfqueryparam value = #affoth# cfsqltype = "CF_SQL_INTEGER">,
aaffother = <cfqueryparam value = '#FORM.aaffother#' cfsqltype = "cf_sql_char">, 
univ = <cfqueryparam value = '#univv#' cfsqltype = "cf_sql_char">, 
rank = <cfqueryparam value = '#FORM.rank#' cfsqltype = "cf_sql_char">, 
rnkother = <cfqueryparam value = '#FORM.rnkother#' cfsqltype = "cf_sql_char">, 
ttle = <cfqueryparam value = '#FORM.ttle#' cfsqltype = "cf_sql_char">,
schl = <cfqueryparam value = '#FORM.schl#' cfsqltype = "cf_sql_char">, 
dprt = <cfqueryparam value = '#FORM.dprt#' cfsqltype = "cf_sql_char">, 
dvsn = <cfqueryparam value = '#FORM.dvsn#' cfsqltype = "cf_sql_char">, 
gender = <cfqueryparam value = '#FORM.gender#' cfsqltype = "cf_sql_char">, 
ethnct = <cfqueryparam value = '#FORM.ethnct#' cfsqltype = "cf_sql_char">, 
aina = <cfqueryparam value = '#aina#' cfsqltype = "cf_sql_char">, 
asia = <cfqueryparam value = '#asia#' cfsqltype = "cf_sql_char">, 
baa = <cfqueryparam value = '#baa#' cfsqltype = "cf_sql_char">, 
nhopi = <cfqueryparam value = '#nhopi#' cfsqltype = "cf_sql_char">, 
white = <cfqueryparam value = '#white#' cfsqltype = "cf_sql_char">, 
unkn = <cfqueryparam value = '#unkn#' cfsqltype = "cf_sql_char">, 
dsblty = <cfqueryparam value = '#dsblty#' cfsqltype = "cf_sql_char">, 
cntlnbr = <cfqueryparam value = '#FORM.cntlnbr#' cfsqltype = "cf_sql_char">
where recid = #recid# 
</cfquery>
</cftransaction>

<cfquery name="mntrNme" datasource="#Application.PITdb#">
 select a.fstNme, a.lstNme, b.fstnme as pifstnme, b.lstnme as pilstnme
  from baselineMntr a, baselineSub b
  where a.pgmrecid = b.recid
  and a.recid = #recid#
</cfquery>

<div id="ApplicationData">
<img src="/cctsi/cctsiBasic.png"><br>
<h1>CCTSI <cfoutput>#Application.pgmNme#</cfoutput> Mentor Confirmation</h1>
<h2>Mentor Information Submission Successful!</h2>
<p>The information below is for review only and cannot be changed.</p>


<cfinclude template="/ebaseline/cnfrmtnTableMntr.cfm"> 


<cfmail FROM="#Application.email#"
	TO="#Application.email#"
    BCC = "galit.mankin@ucdenver.edu"
	SUBJECT="Complete - Mentor Information Request - #Application.pgmNme# program (Mentee: #mntrNme.pifstnme# #mntrNme.pilstnme#)"
	TYPE="HTML">
	
<p>Mentor #mntrNme.fstNme# #mntrNme.lstNme# on a CCTSI Education, Training & Career Development <cfoutput>#Application.pgmNme#</cfoutput> grant has completed the online form</p>


</cfmail>


<h3>Thank you!</h3>
<cfinclude template="/cctsi/cctsiEducation.cfm">
<cfinclude template="/cctsi/footer.cfm">


</div>
</body>
</html>
