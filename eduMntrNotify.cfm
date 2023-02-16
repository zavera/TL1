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
  select b.pgmrecid, b.recid, a.fstNme, a.lstNme, a.emladdrss, b.[fstNme] as mntfn, b.[lstNme] as mntln, b.[emlAddrss] as mntea 
from baselineSub a, [eductn].[dbo].[baselineMntr] b
where a.recid = b.pgmrecid
and a.program = '#Application.pgmNme2#'
and a.yr = #Application.appYr#
and b.pgmrecid in (1045,
1048,
1053,
1056,
1061,
1066,
1067,
1070,
1072,
1074)
order by a.lstNme
</cfquery>

<cfloop query="mntrNme">


<cfmail FROM="#Application.email#"
	TO="#mntrNme.mntea#"
	CC="#mntrNme.emladdrss#"
	BCC = "galit.mankin@ucdenver.edu ; ambreen.zaver@ucdenver.edu"
	SUBJECT="Mentor Information Request - #Application.pgmNme# program (Mentee: #mntrNme.fstNme# #mntrNme.lstNme#)"
	TYPE="HTML">

<!---
<cfmail FROM="#Application.email#"
	TO="swan.ellert@cuanschutz.edu"
	SUBJECT="Mentor Information Request - #Application.pgmNme# program (Mentee: #mntrNme.fstNme# #mntrNme.lstNme#)"
	TYPE="HTML">
--->
	
<p>You have been listed as a mentor on a CCTSI Education, Training & Career Development <cfoutput>#Application.pgmNme#</cfoutput> grant for mentee <cfoutput>#mntrNme.fstNme# #mntrNme.lstNme#</cfoutput></p>

<p>Please fill out the mentor information for this grant by <cfoutput>#Application.pgmmntrDD#</cfoutput> at:
<br><a href="https://cctsiapps.ucdenver.edu/education/<cfoutput>#Application.appGt#</cfoutput>/eduMntr.cfm?ref=<cfoutput>#mntrNme.recid#</cfoutput>">https://cctsiapps.ucdenver.edu/education/<cfoutput>#Application.appGt#</cfoutput>/eduMntr.cfm?ref=<cfoutput>#mntrNme.recid#</cfoutput></a>

<p>If you have any questions or concerns, please contact #Application.email#</p>

</cfmail>

<cfoutput>Done: #mntrNme.emladdrss#...#mntrNme.mntea#...<br></cfoutput>

</cfloop>

</div>

</body>
</html>


