<!-- application vars -->
<cfapplication name="CCTSI Education Core" SessionManagement="Yes"
				sessionTimeout=#CreateTimeSpan(0,0,60,0)#>
				
<cflock scope="session" type="exclusive" timeout="10" >
	<cfparam name="session.loggedin" default="false" >
</cflock>

<cfset Application.PITdb = "eductn">

<!-- specific to each grant type -->
<!-- tl1 -->
<cfset Application.appYr = "2023">
<cfset Application.appGt = "tl1">
<cfset Application.pgmNme = "Team Oriented Training across the Translational Sciences Spectrum (TOTTS)">
<cfset Application.pgmNme2 = "totts">
<cfset Application.appUsr = "tl1Usr">
<cfset Application.appPw = "pwTl129!">
<cfset Application.pgmEndDt = "March 23, 2023">
<cfset Application.pgmedmth = "3">

<cfset Application.keyNew = 'pJhTRfde4bU='>
<cfset Application.key2 = 'r56ESfde4bU='>
<cfset Application.key3 = 'kTeTRfki5bU='>
<cfset Application.key = 'pJhTRfde4bU='>

<cfset Application.pgmmntrDD = "Feb 01 2023">
<cfset Application.email = "cctsi-education@olucdenver.onmicrosoft.com">
