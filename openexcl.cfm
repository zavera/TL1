<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>TL1 Report</title>
<link href="/cctsi/cctsi.css" rel="stylesheet" type="text/css">
</head>

<cfif isDefined("Session.listFirst")>

<cfset thisPath= ExpandPath("*.*")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>

<cfquery name="exclQ" datasource="#Application.PITdb#">
select a.FSTNME as 'First Name',
a.LSTNME as 'Last Name',
a.EMLADDRSS as 'Email',
a.apptype as 'Application Type',
a.agncy as 'predoctoralDegreeType',
a.phdPrgrm as 'Program', 
a.dtePhdPrgrm as 'Date entered program',
a.currentgpa as 'Current GPA',
a.cofc as 'Country of Citizenship', 
a.rank as 'Applicant Category', 
a.univ as 'IDNumber',
a.appTypeOthr as 'ID Type',
a.cntlnbr as 'control number', 
a.gender,
a.rsrtpe0,
a.rsrtpe1,
a.rsrtpe2,
a.rsrtpe3,
a.rsrtpe4,
a.rsrtpe5,
   
a.ethnct as 'ethnicity', 
a.aina as 'American Indian/Native Alaskan', 
a.asia as 'Asian', 
a.baa as 'Black or African American ',
a.nhopi as 'Native Hawaiian or Other Pacific Islander', 
a.white as 'White', 
a.unkn as 'Prefer not to answer', 
a.dsblty as 'physical/mental impairment', 
a.dsdvntlow as 'family low income',
a.dsdvntfst as 'first-generation college',
a.dsdvnt as 'challenging environment', 
a.cmmnts as 'comments', 


a.webts
from baselineSub a

    
    
where a.program = '#Application.pgmNme2#'
and DATEPART(year, a.webts) = '#Application.appYr#'
order by a.lstNme, a.fstNme
</cfquery>

<cfloop query="exclQ">
<cfif (#len(exclQ.IDNumber)# GT 1)>
<cfset #exclQ.IDNumber# = Decrypt(#exclQ.IDNumber#, #Application.key#, 'DES', 'Hex') >
</cfif>
<cfif #exclQ.predoctoralDegreeType# EQ 'Postdoctoral trainee'>
<cfset #exclQ.predoctoralDegreeType# = '' >
</cfif>
</cfloop>

<cfspreadsheet 
        action = "write" 
        filename="tl1.xls" 
        query="exclQ" 
        overwrite="true">

<cfset efile = "tl1.xls" >

<body>

 
<cfheader name="Content-Disposition" value="attachment; filename=#efile#"> 
<cfcontent file="#thisDirectory#\#efile#" type="application/vnd.msexcel"> 
 

<cfelse>
<cflocation URL="main.cfm?Message=login" addtoken="no">
</cfif>


</body>
</html>
