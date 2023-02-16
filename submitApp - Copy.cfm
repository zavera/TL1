<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title><cfoutput>#Application.appYr#</cfoutput> <cfoutput>#Application.pgmNme#</cfoutput> Program Submission</title>
<link href="/cctsi/cctsi.css" rel="stylesheet" type="text/css">

<!---
<cfloop index="x" list="#FORM.fieldnames#">
<cfoutput>#x# - #FORM[x]#<br></cfoutput>
</cfloop>
--->

<!--- lets use email first part for file name.  then there are no special characters --->
<cfset cmplNm = #Replace(emlAddrss, ".", "", "ALL")#>
<cfset cmplNm = #Left(cmplNm, find("@",cmplNm) - 1)#>
<cfset cmplNm2 = cmplNm>

<cfset thisPath= ExpandPath("*.*")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>

<cfdirectory action = "create" directory = "#thisDirectory#submissions\#cmplNm#" >

<cffile action = "upload" 
   	  filefield="Form.upldFle"
	  destination = "#thisDirectory#\tmp\"
	  accept="application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/msword,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/msexcel"
	  nameconflict = "overwrite">
	 
<cffile action = "move"   
	source = "#thisDirectory#\tmp\#File.ServerFile#"   
	destination = "#thisDirectory#\submissions\#cmplNm#\#File.ServerFile#">

<cfif #len(Form.univ)# GT 2>
<cfset univv = Encrypt(#Form.univ#, #Application.key#,"DES","Hex")>
<cfelse>
<cfset univv = ''>
</cfif>

<cfif !isDefined('Form.agncy') >
	<cfset agncy = ''>
<cfelse>
	<cfset agncy = #Form.agncy#>
</cfif>

<!--- this is for the NA degree, going to be stored in rank --->

<cfif !isDefined('Form.rank') >
	<cfset rank = ''>
<cfelse>
	<cfset rank = 'NA'>
</cfif>

<cfinclude template="/eall/all/setValuesAllSubmission.cfm"> 

<cfquery name="mxRcID" datasource="#Application.PITdb#">
  select (max(recID) + 1) AS newId
  FROM baselineSub
</cfquery>

<cfif (#len(mxRcID.newID)# GT 0)>
	<cfset mxR = #mxRcID.newID#>
<cfelse>
	<cfset mxR = 1>
</cfif>

<cftransaction>
<cfquery datasource="#Application.PITdb#">
INSERT baselineSub (recid, appType, 
fstNme, lstNme, emlAddrss, univ, appTypeOthr, cntlnbr,
cofc, agncy, phdPrgrm, dtePhdPrgrm,
uginstt, ugmajor, uggpa, testType,  dtegre, grevr, greqr, greaw, mcvr, mcps, mcbs, mcws,
rank, [degree-dds],
[degree-dnp],[degree-do],[degree-dpt],[degree-drph],[degree-ma],[degree-mba],[degree-md],[degree-mdphd],
[degree-ms],[degree-mph],[degree-pharmd],[degree-phd],[degree-psyd],[degree-oth], dgreother, 
[affltn-csu],[affltn-ucamc],[affltn-ucb],[affltn-ucd],[affltn-oth],aaffother,  
gender, ethnct, aina, asia, baa, nhopi, white, unkn, dsblty, dsdvntlow, dsdvntfst, dsdvnt,  
rsrtpe0,rsrtpe1,rsrtpe2,rsrtpe3,rsrtpe4,rsrtpe5,
cmmnts,  webts, program, yr, edmth)
VALUES (#mxR#, 
<cfqueryparam value = '#FORM.appType#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#FORM.fstNme#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.lstNme#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#FORM.emlAddrss#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#univv#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.appTypeOthr#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#FORM.cntlnbr#' cfsqltype = "cf_sql_char">,  
<cfqueryparam value = '#FORM.cofc#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#agncy#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.phdPrgrm#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.dtePhdPrgrm#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.uginstt#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.ugmajor#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.uggpa#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.testType#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#FORM.dtegre#' cfsqltype = "cf_sql_char">,   
<cfqueryparam value = '#FORM.grevr#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.greqr#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.greaw#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.mcvr#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.mcps#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.mcbs#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.mcws#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = #rank# cfsqltype = "cf_sql_char">,
<cfqueryparam value = #dds# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #dnp# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #do# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #dpt# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #drph# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #ma# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #mba# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #md# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #mdphd# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #ms# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #mph# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #pharmd# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #phd# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #psyd# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #dgroth# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = '#FORM.dgreother#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = #csu# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #ucamc# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #ucb# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #ucd# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = #affoth# cfsqltype = "CF_SQL_INTEGER">,
<cfqueryparam value = '#FORM.aaffother#' cfsqltype = "cf_sql_char">,  
<cfqueryparam value = '#FORM.gender#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.ethnct#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#aina#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#asia#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#baa#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#nhopi#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#white#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#unkn#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#dsblty#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#dsdvntlow#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#dsdvntfst#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#dsdvnt#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#rsrtpe0#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#rsrtpe1#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#rsrtpe2#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#rsrtpe3#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#rsrtpe4#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#rsrtpe5#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#FORM.cmmnts#' cfsqltype = "cf_sql_char">,
#Now()#,
<cfqueryparam value = '#Application.pgmNme2#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = #datepart("yyyy",Now())# cfsqltype = "cf_sql_integer">,
<cfqueryparam value = '#datepart("m",Now())#' cfsqltype = "cf_sql_char">)
</cfquery>
</cftransaction>

<!---
<cfset undergrad = #FORM.uginstt# & ':' & #FORM.ugmajor# & ':' & #FORM.uggpa#>
<cfset greinfo = #FORM.testType# & '<br>Date: ' & #FORM.dtegre# & '<br>Verbal Reasoning: ' & #FORM.grevr# & '<br>Quantitative Reasoning: ' & #FORM.greqr# & '<br>Analytical Writing: ' & #FORM.greaw#>
<cfset mcatinfo = #FORM.testType#  & '<br>Verbal Reasoning: ' & #FORM.mcvr# & '<br>Physical Sciences: ' & #FORM.mcps# & '<br>Biological Sciences: ' & #FORM.mcbs# & '<br>Writing Sample: ' & #FORM.mcws#>

<cfset undergrad = ''>
<cfset greinfo = ''>
<cfset mcatinfo = ''>
--->
<cfset raceinfo = 'American Indian/Native Alaskan: ' & #ainaReport# & 
		  '<br>Asian: ' & #asiaReport# & 
		  '<br>Black or African American: ' & #baaReport# & 
		  '<br>Native Hawaiian or Other Pacific Islander: ' & #nhopiReport# & 
		  '<br>White: ' & #whiteReport# & 
		  '<br>Unknown or not reported: ' & #unknReport# >

<div id="ApplicationData">
<img src="/cctsi/cctsiBasic.png"><br>
<h1><cfoutput>#Application.appYr#</cfoutput> <cfoutput>#Application.pgmNme#</cfoutput> Submission</h1>
<h2>Submission Successful!</h2>


<table>
<tr bgcolor="gold"><td colspan=2><label>Applicant Information</label></td></tr>
<tr><td><label>First Name</label></td><td><cfoutput><label>#Form.fstNme#</cfoutput></label></td></tr>
<tr><td><label>Last Name</label></td><td><cfoutput>#Form.lstNme#</cfoutput></td></tr>
<tr><td><label>Email Address</label></td><td><cfoutput>#Form.emlAddrss#</cfoutput></td></tr>
<tr><td><label>Country of Citizenship</label></td><td><cfoutput>#Form.cofc#</cfoutput></td></tr>
<tr><td><label>Program</label></td><td><cfoutput>#Form.phdPrgrm#</cfoutput></td></tr>
<tr><td><label>Date entered PhD Program</label></td><td><cfoutput>#Form.dtePhdPrgrm#</cfoutput></td></tr>
<!---
<tr><td><label>Undergraduate Information</label></td><td><cfoutput>#undergrad#</cfoutput></td></tr>
<tr><td><label>GRE or MCAT Information</label></td><td>
	   <cfif #FORM.testType# eq 'GRE'>
		<cfoutput>#greinfo#</cfoutput>
	   </cfif>
	   <cfif #FORM.testType# eq 'MCAT'>
		<cfoutput>#mcatinfo#</cfoutput>
	   </cfif>
</td></tr>
--->	
<tr><td><label>Gender</label></td><td><cfoutput>#Form.gender#</cfoutput></td></tr>
<tr><td><label>Race</label></td><td><cfoutput>#raceinfo#</cfoutput></td></tr>
<tr><td><label>Ethnicity</label></td><td><cfoutput>#Form.ethnct#</cfoutput></td></tr>
<tr><td><label>Disadvantage Background</label></td><td><cfoutput>#dsdvnt#</cfoutput></td></tr>
<tr><td><label>Do you have a physical or mental impairment that substantially limits one or more major life activities?</label></td><td><cfoutput>#dsblty#</cfoutput></td></tr>
</table>
	
<h3>Thank you!</h3>

<cfinclude template="/cctsi/emily.cfm">
<cfinclude template="/cctsi/footer.cfm">

</div>
</body>
</html>
