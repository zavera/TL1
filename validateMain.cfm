<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!---
<cfloop index="x" list="#FORM.fieldnames#">
<cfoutput>#x# - #FORM[x]#<br></cfoutput>
</cfloop>
--->


<cfif (#FORM.LastName# EQ #Application.appUsr#) AND (#FORM.passwd# EQ #Application.appPw#)>

	<cfset Session.loggedin = true>
	<cfset Session.listFirst = #Application.appUsr#>
	<cflocation URL="lstAppTL1.cfm" addtoken="no">

<cfelse>
	<cflocation URL="main.cfm?Message=invalid" addtoken="no">
</cfif>


