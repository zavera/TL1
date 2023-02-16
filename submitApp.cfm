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
cofc, agncy, phdPrgrm, currentgpa, dtePhdPrgrm,
rank, [degree-dds],
[degree-dnp],[degree-do],[degree-dpt],[degree-drph],[degree-ma],[degree-mba],[degree-md],[degree-mdphd],
[degree-ms],[degree-mph],[degree-pharmd],[degree-phd],[degree-psyd],[degree-oth], dgreother, 
[affltn-csu],[affltn-ucamc],[affltn-ucb],[affltn-ucd],[affltn-oth],aaffother,  
gender, ethnct, aina, asia, baa, nhopi, white, unkn, dsblty, dsdvntlow, dsdvntfst, dsdvnt,  
rsrtpe0,rsrtpe1,rsrtpe2,rsrtpe3,rsrtpe4,rsrtpe5,tottsfrstapp,tottsfrstappyr,
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
<cfqueryparam value = '#FORM.currentgpa#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.dtePhdPrgrm#' cfsqltype = "cf_sql_char">, 

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
<cfqueryparam value = '#FORM.tottsfrstapp#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#FORM.tottsfrstappyr#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#FORM.cmmnts#' cfsqltype = "cf_sql_char">,
#Now()#,
<cfqueryparam value = '#Application.pgmNme2#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = #Application.appYr# cfsqltype = "cf_sql_integer">,
<cfqueryparam value = '#Application.pgmedmth#' cfsqltype = "cf_sql_char" >)
</cfquery>
</cftransaction>

<!--- now put mentors into table --->

<cfquery name="mxPRcID" datasource="#Application.PITdb#">
  select (max(recID) + 1) AS newId
  FROM baselineMntr
</cfquery>

<cfif (#len(mxPRcID.newID)# GT 0)>
	<cfset mxPR = #mxPRcID.newID#>
<cfelse>
	<cfset mxPR = 1>
</cfif>

<cftransaction>
<cfquery datasource="#Application.PITdb#">
INSERT baselineMntr (recid, pgmrecid, webts, mntrtpe, fstNme, lstNme, emlAddrss, program, yr,edmth)
VALUES (#mxPR#, #mxR#, #Now()#, 'Research',
<cfqueryparam value = '#FORM.mntr1frst#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.mntr1lst#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.mntr1Eml#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#Application.pgmNme2#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = #Application.appYr# cfsqltype = "cf_sql_integer">,
<cfqueryparam value = '#Application.pgmedmth#' cfsqltype = "cf_sql_char" >
)
</cfquery>
</cftransaction>

<cfif len(#FORM.mntr2eml#) GT 2>
<cfset mxPR = mxPR + 1>
<cftransaction>
<cfquery datasource="#Application.PITdb#">
INSERT baselineMntr (recid, pgmrecid, webts, mntrtpe, fstNme, lstNme, emlAddrss, program, yr,edmth)
VALUES (#mxPR#, #mxR#, #Now()#, 'Translational',
<cfqueryparam value = '#FORM.mntr2frst#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.mntr2lst#' cfsqltype = "cf_sql_char">, 
<cfqueryparam value = '#FORM.mntr2Eml#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = '#Application.pgmNme2#' cfsqltype = "cf_sql_char">,
<cfqueryparam value = #Application.appYr# cfsqltype = "cf_sql_integer">,
<cfqueryparam value = '#Application.pgmedmth#' cfsqltype = "cf_sql_char" >
)
</cfquery>
</cftransaction>
</cfif>

<!--- update Extra table to indicate verifications complete --->

<cftransaction>
<cfquery datasource="#Application.PITdb#">
INSERT tottsExtra (applicant_recid, verify_all, webts, yr,edmth)
VALUES (#mxR#, 'yes', #Now()#,
<cfqueryparam value = #Application.appYr# cfsqltype = "cf_sql_integer">,
<cfqueryparam value = '#Application.pgmedmth#' cfsqltype = "cf_sql_char" >
)
</cfquery>
</cftransaction>

<cfmail FROM="#Application.email#"
	TO="#Form.emlAddrss#"
	BCC="#Application.email#"
	SUBJECT="CCTSI Application Confirmation for #Application.pgmNme#"
	TYPE="HTML">
	
<p>Thank you for submitting an application for the 2020-21 #Application.pgmNme#
<p>If you have any questions or concerns, please contact CCTSI Education and Training Administration at #Application.email#</p>

</cfmail>

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
<tr><td><label>Gender</label></td><td><cfoutput>#Form.gender#</cfoutput></td></tr>
<tr><td><label>Race</label></td><td><cfoutput>#raceinfo#</cfoutput></td></tr>
<tr><td><label>Ethnicity</label></td><td><cfoutput>#Form.ethnct#</cfoutput></td></tr>
<tr><td><label>Disadvantage Background</label></td><td><cfoutput>#dsdvnt#</cfoutput></td></tr>
<tr><td><label>Do you have a physical or mental impairment that substantially limits one or more major life activities?</label></td><td><cfoutput>#dsblty#</cfoutput></td></tr>
</table>
	
<h3>Thank you!</h3>

<div id="contact">
Please contact CCTSI Education and Training Administration at <A href="mailto:<cfoutput>#Application.email#">#Application.email#</cfoutput></a> if you have any problems submitting this application.
</div>
<cfinclude template="/cctsi/footer.cfm">

</div>
</body>
</html>
