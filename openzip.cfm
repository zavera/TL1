<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>KTR LOI Report</title>
<link href="/cctsi/cctsi.css" rel="stylesheet" type="text/css">
</head>

<cfif isDefined("Session.listFirst")>

<cfset thisPath= ExpandPath("*.*")>
<cfset thisDirectory = GetDirectoryFromPath(thisPath)>

<cfzip
action="zip"
source="#ExpandPath( './submissions/' )#"
file="#ExpandPath( './tl12021.zip' )#"
overwrite="true"
/>

<cfset dfile = "tl12021.zip" >

<body>

 
<cfheader name="Content-Disposition" value="attachment; filename=#dfile# "> 
<cfcontent file="#thisDirectory#\#dfile#" type="application/zip"> 

<cfelse>

<cflocation URL="main.cfm?Message=login" addtoken="no">
</cfif>

</div>

</body>
</html>
