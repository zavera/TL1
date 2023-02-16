<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>CCTSI Education Mentor Information</title>
<link href="/cctsi/cctsi.css" rel="stylesheet" type="text/css">

<!--- this js is specific to this application --->
<script type="text/javascript" src="../baseline/formCheckMntr.js"></script>
<!--- generic checks --->
<script type="text/javascript" src="/cctsi/emailCheck.js"></script>
<script type="text/javascript" src="/cctsi/wordcnt.js"></script>
<script type="text/javascript" src="/cctsi/branching.js"></script>
</head>

<!---
<cfset ref =  #Decrypt(URL.ref, "#Application.key#")#>
<cfset ref2 =  Encrypt(#ref#, #Application.key#,"DES","Hex")>  
---> 

<cfset recid = #URL.ref#>

<cfquery name="mntrNme" datasource="#Application.PITdb#">
  select a.recid, a.pgmrecid, a.fstNme, a.lstNme, a.emlAddrss, b.fstnme as pifstnme, b.lstnme as pilstnme
  from baselineMntr a, baselineSub b
  where a.pgmrecid = b.recid
  and a.recid = #recid#
</cfquery>

<cfset shllFr= "mentor">

<body>
<div id="SubmitApplication">
<img src="/cctsi/cctsiBasic.png">
<h1>CCTSI <cfoutput>#Application.pgmNme#</cfoutput> Mentor Information  </h1>
<h3>Mentee: <cfoutput>#mntrNme.pifstnme# #mntrNme.pilstnme#</cfoutput></h3>
<cfform action="submitMntr.cfm" method="post" name="cctsiform" enctype="multipart/form-data" onSubmit="return checkForm();">
		<input type="hidden" name="ref" value="<cfoutput>#mntrNme.recid#</cfoutput>">
<fieldset>
      <legend>Mentor: <cfoutput>#mntrNme.fstnme# #mntrNme.lstnme#</cfoutput></legend>

		<cfinclude template="/eall/all/dgrInfoAllRqrd.cfm"> 

		<cfinclude template="/eall/all/aaffInfoAllRqrd.cfm"> 

		<cfinclude template="/eall/univInfo.cfm"> 

		<cfinclude template="/eall/all/rankInfoAllRqrd.cfm"> 

		<cfinclude template="/eall/all/schoolDeptDivInfoAllRqrd.cfm"> 
   
</fieldset>

<!--- optional demographic information --->
<fieldset>
	<cfinclude template="/eall/all/demoInfo.cfm"> 
	<cfinclude template="/eall/all/demoInfoUndrSrv.cfm"> 
</fieldset>
    	

<input type="submit" value="Save and Submit" name="" class="submit-button">
  
</cfform>
<cfinclude template="/cctsi/cctsiEducation.cfm">
<cfinclude template="/cctsi/footer.cfm">
</div>

<!-- Branching Logic -->

 <script type="text/javascript">
 var brErrExist=true;
 </script>
<script type='text/javascript'>


 function brErr(fld){alert('BRANCHING LOGIC ERRORS EXIST!\n\nThere is a syntactical error in the the Branching Logic for the field "'+fld+'" on this page. None of the Branching Logic on this data entry form will function correctly until this error has been corrected.\n\nIf you are not sure what this means, please contact your database administrator.')}var brTxt1='ERASE CURRENT VALUE OF THE FIELD';var brTxt2='The current field for which you just entered data requires that the field named';var brTxt3='be hidden from view. However, that field already';var brTxt4='has a value, so its value might need to be reset back to  a blank value.';var brTxt5='Click OK to HIDE this field and ERASE its current value.';var brTxt6='Click CANCEL if you DO NOT wish to hide this field or erase its current value.';

function doBranching(){

  return false;
}
 brErrExist = doBranching();
</script>
 <script type="text/javascript">
 if(brErrExist){alert('BRANCHING LOGIC ERRORS EXIST!\n\nThere is a syntactical error in the Branching Logic of one or more fields on this page. It cannot be determined which fields contain the error, so please check the Branching Logic for every field on this page. None of the Branching Logic on this data entry form will function correctly until this error has been corrected.\n\nIf you are not sure what this means, please contact your database administrator.');}
 </script>

</body>

</html>
