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

<body>

<cfquery name="qsubmitList" datasource="#Application.PITdb#">
SELECT recid, fstNme, lstNme, 
phdPrgrm, dtePhdPrgrm, emlAddrss, 
univ, cofc, rank, gender, ethnct, 
aina, asia, baa, nhopi, white, unkn, 
dsblty, dsdvntlow, dsdvntfst, dsdvnt, 
cntlnbr, cmmnts, 
uginstt, ugmajor, uggpa,
currentgpa,
testType, dtegre, 
grevr, greqr, greaw, 
mcvr, mcps, mcbs, mcws, 
webts
from baselineSub 
where program = '#Application.pgmNme2#'
and DATEPART(year, webts) = '#Application.appYr#' 
order by lstNme, fstNme
</cfquery>

<div id="ApplicationData">
<img src="/cctsi/cctsiBasic.png">
<h1>TL1 Application Information</h1>
<p><a href="openexcl.cfm" target="blank">Download application data to excel</a>
<br><a href="openzip.cfm" target="blank">Download application documents as .zip file</a></p>
<table border="0" cellpadding="0">
  <tr>
    	<th><label>Last Name</label></th>
	<th><label>First Name</label></th>
	<th><label>Email Address</label></th>
	<th><label>Country of <br>Citizenship</label></th>
	<th><label>Program Information</label></th>
    <th><label>Current GPA</label></th>  
	<th><label>Undergraduate Program Information</label></th>
	<th><label>Documentation</label></th>
  </tr>
  
  <cfloop query="qsubmitList">
	<tr>
      	  <td><label><cfoutput>#qsubmitList.lstNme#</cfoutput></label></td>
	  <td><label><cfoutput>#qsubmitList.fstNme#</cfoutput></label></td>
	  <td><label><cfoutput>#qsubmitList.emlAddrss#</cfoutput></label></td>
	  <td><label><cfoutput>#qsubmitList.cofc#</cfoutput></label></td>
	  <td><label><cfoutput>#qsubmitList.phdPrgrm#</cfoutput><br> Date Entered: <cfoutput>#dateFormat(qsubmitList.dtePhdPrgrm,'mm/dd/yyyy')#</cfoutput></label></td>
        <td><label><cfoutput>#qsubmitList.currentgpa#</cfoutput></label></td>
        
	  <td><label>-<cfoutput>#qsubmitList.uginstt#</cfoutput><br>
          
		<cfoutput>#qsubmitList.ugmajor#:#qsubmitList.uggpa#</cfoutput><br>

	  </label></td>

	  <td> 
	  <font size="-1">


		<cfset cmplNm = #Replace(qsubmitList.emlAddrss, ".", "", "ALL")#>
		<cfset cmplNm = #lcase(Left(cmplNm, find("@",cmplNm) - 1))#>

	  <!--- use CFDIRECTORY to give the contents of the snippets directory, order by name and size --->
      		<CFDIRECTORY 
         		DIRECTORY = "#thisDirectory#submissions/#cmplNm#"
        		 name = "myDirectory"
         		SORT = "name DESC, size DESC">
	  
		<cfif isDefined("Form.Download") >
   		<!--- If TRUE, download the file. --->
   			<cfheader name="Content-Disposition" value="Attachment; filename=#Form.Download#">
				<cfif Right(Form.Download,4) eq ".doc">
      				<cfcontent type="application/msword" file="#thisDirectory#submissions\#Form.Download#" deletefile="no">
   				<cfelseif Right(Form.Download,5) eq ".docx">
      				<cfcontent type="application/vnd.openxmlformats-officedocument.wordprocessingml.document" file="#thisDirectory#submissions\#Form.Download#" deletefile="no">
   				<cfelseif Right(Form.Download,4) eq ".pdf">
      				<cfcontent type="application/pdf" file="#thisDirectory#submissions\#Form.Download#" deletefile="no">
   				<cfelse>
      				Unrecognized file extension "#Right(Form.Download,4)#".  Please contact technical support.
   				</cfif>
		</cfif>

   		<!--- If FALSE, show the Form. --->
   		<form method="post" action=#cgi.script_name# name="downloadForm" enctype="multipart/form-data">
	  	<cfif isDefined("Form.Download") >
			<span class="bigt">Successful download!</span> 
		</cfif>
	  	<table> 
		<cfloop query = "myDirectory">
		<tr><td><input name='Download' type='submit' value='<cfoutput>#cmplNm#\#NAME#</cfoutput>'></td></tr>
		</cfloop>
	  	</table> 
      		</form> 
	  
	  </font>
	  </td>
	  	
	</tr>
	<tr>
	<td colspan=10><label><b>Comments:</b> <cfoutput>#qsubmitList.cmmnts#</cfoutput></label></td>
	</tr>
   </cfloop>
</table>
</div>

<cfelse>
<cflocation URL="main.cfm?Message=login" addtoken="no">
</cfif>

</body>
</html>
