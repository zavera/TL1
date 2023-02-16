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

<!---
<cfquery name="exclQ" datasource="#Application.PITdb#">
select FSTNME as 'First Name',
LSTNME as 'Last Name',
EMLADDRSS as 'Email',
univ as 'studentIDNumber',
webts
from baselineSub 
where program = '#Application.pgmNme2#'
and convert(date,edmth + '/' + '01/' + convert(varchar,yr)) > Convert(datetime, DateAdd(month, -2, Convert(date, GetDate())))
order by lstNme, fstNme
</cfquery>

<cfloop query="exclQ">
<cfif (#len(exclQ.studentIDNumber)# GT 1)>
<cfset test = Decrypt(#exclQ.studentIDNumber#, #Application.key3#, "DES", "Hex") >
<cfoutput>#test#</cfoutput>
<!--- <cfset #exclQ.studentIDNumber# = Decrypt(#exclQ.studentIDNumber#, #Application.keyNew#, "DES", "Hex") > --->
</cfif>
</cfloop>

<cfspreadsheet 
        action = "write" 
        filename="tl1.xls" 
        query="exclQ" 
        overwrite="true">

<cfset efile = "tl1.xls" >
--->


<body>

<cfquery name="exclQ" datasource="#Application.PITdb#">
select FSTNME as 'First Name',
LSTNME as 'Last Name',
EMLADDRSS as 'Email',
univ as 'studentIDNumber',
webts
from baselineSub 
where program = '#Application.pgmNme2#'
and convert(date,edmth + '/' + '01/' + convert(varchar,yr)) > Convert(datetime, DateAdd(month, -2, Convert(date, GetDate())))
order by lstNme, fstNme
</cfquery>

<cfloop query="exclQ">
<cfif (#len(exclQ.studentIDNumber)# GT 1)>
<cfset test = Decrypt(#exclQ.studentIDNumber#, #Application.key#, "DES", "Hex") >
<cfoutput>#test#,#exclQ.studentIDNumber# <br></cfoutput>
<!--- <cfset #exclQ.studentIDNumber# = Decrypt(#exclQ.studentIDNumber#, #Application.keyNew#, "DES", "Hex") > --->
</cfif>
</cfloop>

<!---
<cfset test = Decrypt('6D2E0DB79157C786AC6E97BE832659F7', #Application.key3#, "DES", "Hex") >
 <cfset test = Encrypt('231209', #Application.key2#,"DES","Hex")> 
<cfoutput>#test#</cfoutput>
--->
 

<!---
<cfheader name="Content-Disposition" value="attachment; filename=#efile#"> 
<cfcontent file="#thisDirectory#\#efile#" type="application/vnd.msexcel"> 
--->
 

<cfelse>
<cflocation URL="main.cfm?Message=login" addtoken="no">
</cfif>


</body>
</html>
