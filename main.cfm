<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>CCTSI TL1 Program</title>
<link href="/cctsi/cctsiTest.css" rel="stylesheet" type="text/css">
</head>

<body>
	
<div id="ApplicationData">
<img src="/cctsi/cctsiBasic.png">
<h2><cfoutput>#Application.appYr#</cfoutput> <cfoutput>#Application.pgmNme#</cfoutput></h2>

<cfif isDefined('URL.Message')>
<cfif URL.Message EQ 'login'>
<p><font color="red">Please login</font>
<cfelse>
<p><font color="red">Invalid Name or Password</font>
</cfif>
</cfif>

<cfform action="validateMain.cfm" method="post" name="cctsiform">
	<label class="required">Name</label>
    	<cfinput type="text" size="20" maxlength="20" name="LastName" required="yes"
		message="Please enter name information">
  	<label class="required">Password</label>
    	<cfinput name="passwd" type="password" size="20" maxlength="20" required="yes"
		message="Please enter password information">

<input type="submit" value="Login" name="" class="submit-button">
</cfform>


<cfinclude template="/cctsi/cctsiEducation.cfm">
<cfinclude template="/cctsi/footer.cfm">

</div>

</body>
</html>
