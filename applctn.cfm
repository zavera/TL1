<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>CCTSI <cfoutput>#Application.pgmNme#</cfoutput> Application Submission</title>
<link href="/cctsi/cctsiTest.css" rel="stylesheet" type="text/css">

<!--- this js is specific to this application --->
<script type="text/javascript" src="formCheckSub.js"></script> 
<!--- generic checks --->
<script type="text/javascript" src="/cctsi/emailCheck.js"></script>
<script type="text/javascript" src="/cctsi/wordcnt.js"></script>
<script type="text/javascript" src="/cctsi/branching.js"></script>
    
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

    
<script>
    

function checkDateFormat(dateField){
var inputDate = document.getElementsByName(dateField)[0].value;
var stripped_date = inputDate.replaceAll(" ","");

if( stripped_date.length > 0 && !moment(stripped_date, 'MMDD',true).isValid()){
    document.getElementsByName(dateField)[0].value = null;
    return alert("Please enter the date of birth in correct format MMDD");
}}    
    
</script>      
    
    
</head>

<cfquery name="qDgr" datasource="#Application.PITdb#">
		SELECT dgree, ddesc from allDegree
		order by dgree
</cfquery>

<cfquery name="qAff" datasource="#Application.PITdb#">
SELECT aff, adesc from allAffiliation
where adesc = 'Colorado State University'
or adesc = 'University of Colorado Anschutz Medical Campus'
or adesc = 'University of Colorado Boulder'
or adesc = 'University of Colorado Denver'
order by aff
</cfquery>


<cfset shllFr= "applicant">

<body>
<div id="SubmitApplication">
<img src="/cctsi/cctsiBasic.png">

<h1><cfoutput>#Application.pgmNme#</cfoutput> Application</h1>
<cfform action="submitApp.cfm" method="post" name="cctsiform" enctype="multipart/form-data" onSubmit="return checkForm();">
<fieldset>
      <legend>Applicant Information</legend>
	<p>You must be US Citizen or Permanent Resident for CCTSI funding, but not for admission to program without funding.</p>

		
		<div id='appType-brnch' sq_id='appType'>
		<label class="required">Applicant Category<em>**</em></label>

            	<div class="checkboxContainer">
			<cfinput name='appType' required="yes" message="Please enter applicant category"
				tabindex='1' onfocus="document.cctsiform.appType___radio[0].focus();" class='frmrd0'>
			<cfinput class="checkbox" type='radio' name='appType___radio' value=""
				onchange="doBranching()" onfocus="window.status='appType';return true;" 
				onclick="document.cctsiform.appType.value='Predoctoral student'; doBranching();">Predoctoral student
			
			<br><cfinput class="checkbox" type='radio' name='appType___radio' value=""
				onchange="doBranching()" onfocus="window.status='appType';return true;" 
				onclick="document.cctsiform.appType.value='Postdoctoral trainee'; doBranching();">Postdoctoral trainee
		</div>

		</div>

		<div>
		  <label>Predoctoral student Degree Type</label>
		  <div class="checkboxContainer">
		    <cfinput class="checkbox" type="radio" name="agncy" value="PhD">PhD
			<br><cfinput class="checkbox" type="radio" name="agncy" value="Clinical Professional Doctorate">Clinical Professional Doctorate
			<br><cfinput class="checkbox" type="radio" name="agncy" value="Postdoctoral trainee">I am applying as a Postdoctoral trainee
		</div>
		</div>

		<cfinclude template="/eall/nameInfoRqrd.cfm"> 

		<div id='tottsfrstapp-brnch' sq_id='tottsfrstapp'>
		<label class="required">Is this your first application to the TOTTS program<em>**</em></label>
		<div class="checkboxContainer">
		<cfinput name='tottsfrstapp' value=""
				tabindex='1' onfocus="document.cctsiform.tottsfrstapp___radio[0].focus();" class='frmrd0'
				required="yes" message="Please indicate if this your first application to the TOTTS program" >
			<cfinput class="checkbox" type="radio" name="tottsfrstapp___radio" value=""
				onchange="doBranching()" onfocus="window.status='tottsfrstapp';return true;" 
				onclick="document.cctsiform.tottsfrstapp.value='Yes'; doBranching();">Yes
			<br>
			<cfinput class="checkbox" type="radio" name="tottsfrstapp___radio" value=""
				onchange="doBranching()" onfocus="window.status='tottsfrstapp';return true;" 
				onclick="document.cctsiform.tottsfrstapp.value='No'; doBranching();">No
		</div>
		</div>

		<div sq_id='tottsfrstappyr' id='tottsfrstappyr-brnch'> 
	  	<label>Please enter the year you first applied to the TOTTS</label>
        	<input type="text" maxlength="50" size="30" name="tottsfrstappyr">
      		</div>	

		<label class="required">Student/University ID Number<em>**</em></label>
	        <cfinput type="text" size="30" maxlength="25" name="univ" required="yes" 
				message="Please enter student or university ID">

		<div><label class="required">This above ID number is a<em>**</em></label>
            	<div class="checkboxContainer">
			<cfinput class="checkbox" type="radio" name="appTypeOthr" required="yes" message="Please indicate type of ID number"
					value="student">Student ID
			<cfinput class="checkbox" type="radio" name="appTypeOthr" value="univ">University ID
		</div>
		</div>

		<div>
		<label>Month and Day of Birth<span>Format: mmdd (May 1 is entered as 0501)</span></label>
			<input type="text" size="30" maxlength="50" name="cntlnbr" value="" onChange="checkDateFormat('cntlnbr');">
		</div>
		
		<label class="required">Are you a U.S. citizen or permanent resident<em>**</em></label>
		<div class="checkboxContainer">
			<cfinput class="checkbox" type="radio" name="cofc" required="yes" message="Please indicate if U.S. citizen or permanent resident"
				value="yes">Yes
			<cfinput class="checkbox" type="radio" name="cofc" value="no">No
		</div>


		<div> 
		<label>Postdoctoral trainee Credential or Degree<em>**</em><span>select all that apply</span></label>
		<div class="checkboxContainer">
			<cfinput class="checkbox" type="checkbox" name="rank" value="rank">N/A - I am a Predoctoral student<br>
		<cfoutput query="qDgr">
			<cfinput class="checkbox" type="checkbox" name="#qDgr.dgree#" value="#qDgr.dgree#">#qDgr.ddesc#<br>
		</cfoutput>
			<cfinput class="checkbox" type="checkbox" name="dgroth" value="dgroth">Other
		</div>
		</div>

		<div sq_id='dgreother' id='dgreother-brnch'> 
	  	<label> If other postdoctoral credential or degree, please specify. </label>
        	<input type="text" maxlength="50" size="30" name="dgreother">
      		</div>	

		<div id='aaff-brnch' sq_id='aaff'>
		<label class="required">Institution during TOTTS<em>**</em><span>select all that apply</span></label>
		<div class="checkboxContainer">

		<cfoutput query="qAff">
			<cfinput class="checkbox" type="checkbox" name="#qAff.aff#" value="#qAff.aff#">#qAff.adesc#<br>
		</cfoutput>
			<cfinput class="checkbox" type="checkbox" name="affoth" value="affoth">Other<br>
		</div>
		</div>

		<div sq_id='aaffother' id='aaffother-brnch'> 
	  	<label> If other institution during TOTTS, please specify. </label>
        	<input type="text" maxlength="50" size="30" name="aaffother">
      		</div>	

		<div>
		<label class="required">Graduate program/Trainee program<em>**</em></label>
		<cfinput type="text" size="30" maxlength="50" name="phdPrgrm" required="yes"
				message="Please enter program">
		</div>
		<div>
		<label class="required">Date entered home program<em>**</em><span>(mm/dd/yyyy)</span></label>
	        <cfinput type="text" size="30" maxlength="50" name="dtePhdPrgrm" required="yes"
				message="Please enter entry date for program" > 
		</div>
   
            
        		<div>
		<label class="required">What is your current GPA (graduate level courses only)?<em>**</em></label>
	        <cfinput type="text" size="30" maxlength="50" name="currentgpa" required="yes"
				message="Please enter your current GPA(graduate level courses only)" > 
		</div>    
            
</fieldset>

<!---
<fieldset>
	<legend>Degree Information</legend>
	<p>Predoctoral students are requested to provide undergraduate information. Postdoctoral trainees are asked to provide graduate information</p>
	<label class="required">Undergraduate or Graduate Institution<em>**</em></label>
	<cfinput type="text" size="30" maxlength="50" name="uginstt" required="yes"
				message="Please enter Undergraduate or Graduate Institution">
	<label class="required">Undergraduate or Graduate Major<em>**</em></label>
	<cfinput type="text" size="30" maxlength="50" name="ugmajor" required="yes"
				message="Please enter Undergraduate or Graduate Major">
	<label class="required">Undergraduate or Graduate GPA<em>**</em></label>
	<cfinput type="text" size="30" maxlength="50" name="uggpa" required="yes"
				message="Please enter Undergraduate or Graduate GPA">

		
	<div id='testType-brnch' sq_id='testType'>
    	<label>GRE or MCAT</label>
	     <cfselect name="testType" onChange="doBranching();">
			<option selected value="">*Select GRE or MCAT*</option>
			<option value="GRE">GRE</option> 
			<option value="MCAT">MCAT</option>
	     </cfselect> 
	</div>
		
	<div id='dtegre-brnch' sq_id='dtegre'>
	<label>Date GRE taken<span>(mm/dd/yyyy)</span></label>
	<cfinput type="text" size="30" maxlength="50" name="dtegre" value=""> 
	</div>

	<div id='grevr-brnch' sq_id='grevr'>
	<label>GRE Verbal Reasoning score</label>
	<cfinput type="text" size="30" maxlength="50" name="grevr" value="">
	</div>

	<div id='greqr-brnch' sq_id='greqr'>
	<label>GRE Quantitative Reasoning score</label>
	<cfinput type="text" size="30" maxlength="50" name="greqr" value="">
	</div>
	
	<div id='greaw-brnch' sq_id='greaw'>
	<label>GRE Analytical Writing score</label>
	<cfinput type="text" size="30" maxlength="50" name="greaw" value="">
	</div>

	<div id='mcvr-brnch' sq_id='mcvr'>
	<label>MCAT Verbal Reasoning score</label>
	<cfinput type="text" size="30" maxlength="50" name="mcvr" value="">
	</div>

	<div id='mcps-brnch' sq_id='mcps'>
	<label>MCAT Physical Sciences score</label>
	<cfinput type="text" size="30" maxlength="50" name="mcps" value="">
	</div>
	
	<div id='mcbs-brnch' sq_id='mcbs'>
	<label>MCAT Biological Sciences score</label>
	<cfinput type="text" size="30" maxlength="50" name="mcbs" value="">
	</div>
	
	<div id='mcws-brnch' sq_id='mcws'>
	<label>MCAT Writing Sample score</label>
	<cfinput type="text" size="30" maxlength="50" name="mcws" value="">
	</div>

</fieldset>
--->

<!--- optional demographic information --->
<fieldset>
	<cfinclude template="/eall/all/demoInfo.cfm"> 
	<cfinclude template="/eall/all/demoInfoUndrSrv.cfm"> 
</fieldset>

<fieldset>
<legend>Mentor Information</legend>

<table class="ThreeColumnsForm" cellspacing="0" cellpadding="0">
   		<tr>
      			<td><label>Research Mentor First Name<em>**</em></label></td>
      			<td><label>Research Mentor Last Name<em>**</em></label></td>
			<td><label>Research Mentor Email Address<em>**</em></label></td>
    		</tr>

  <tr>
	<td><cfinput type="text" size="30" maxlength="50" name="mntr1frst" value="" required="yes" message="Please enter research mentor name"></td>
	<td><cfinput type="text" size="30" maxlength="50"  name="mntr1lst" value=""></td>
	<td><cfinput type="text" size="60" maxlength="50" name="mntr1eml" value=""></td>
  </tr>

</table>

<table class="ThreeColumnsForm" cellspacing="0" cellpadding="0">
   		<tr>
      			<td><label>Translational Mentor First Name<em>**</em></label></td>
      			<td><label>Translational Mentor Last Name<em>**</em></label></td>
			<td><label>Translational Mentor Email Address<em>**</em></label></td>
    		</tr>

  <tr>
	<td><cfinput type="text" size="30" maxlength="50" name="mntr2frst" value="" required="yes" message="Please enter translational mentor name"></td>
	<td><cfinput type="text" size="30" maxlength="50"  name="mntr2lst" value=""></td>
	<td><cfinput type="text" size="60" maxlength="50" name="mntr2eml" value=""></td>
  </tr>

</table>
</fieldset>

<fieldset>
      <legend>Application Research</legend>   

		<cfinclude template="/eall/all/rsrtpInfoAllRqrd.cfm"> 

</fieldset>	

<fieldset>  
	<legend>Application Verification Checklist</legend>
<p>Please create one PDF document for uploading into the online application. Required sections should be in the order listed below. Have all documents ready prior to accessing the online application as you will not be able to save and go back once you have uploaded and submitted your application. </p>
	<div>
		<label class="LongLabel">I have included the required Face Page<em>**</em></label>
	    	<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqfp" value='Yes'
			 required="yes" message="Please indicate that you have included a Face Page document.">Verified
		</div>
		<label class="LongLabel">I have included the required applicant NIH Biosketch<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqbs1" value='Yes'
			 required="yes" message="Please indicate that you have included an applicant NIH Biosketch.">Verified
		</div>
		<label class="LongLabel">I have included the required research mentor NIH Biosketch<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqbs2" value='Yes'
			 required="yes" message="Please indicate that you have included the research mentor NIH Biosketch.">Verified
		</div>
		<label class="LongLabel">I have included the required translational mentor NIH Biosketch<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqbs3" value='Yes'
			 required="yes" message="Please indicate that you have included the translational mentor NIH Biosketch.">Verified
		</div>
		<label class="LongLabel">I have included the required Proposal<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqp" value='Yes'
			 required="yes" message="Please indicate that you have included a Proposal document.">Verified
		</div>
		<label class="LongLabel">I have included the required Graduate courses complete with grades document(s)<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqgc" value='Yes'
			 required="yes" message="Please indicate that you have included graduate course documents.">Verified
		</div>
		<label class="LongLabel">I have included a doctoral or post doctoral program director letter of support<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqls1" value='Yes'
			 required="yes" message="Please indicate that you have included a doctoral or post doctoral program director letter of support.">Verified
		</div>
		<label class="LongLabel">I have included the required research mentor letter of support<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqls2" value='Yes'
			 required="yes" message="Please indicate that you have included the research mentor letter of support.">Verified
		</div>
		<label class="LongLabel">I have included the required translational mentor letter of support<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqls3" value='Yes'
			 required="yes" message="Please indicate that you have included the translational mentor letter of support.">Verified
		</div>
		<label class="LongLabel">I have included the required description of ethical and regulatory training in clinical and translational research, including Responsible Conduct of Research and Good Clinical Practice, already completed and proposed for completion during the TL1 TOTTS year<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqet" value='Yes'
			 required="yes" message="Please indicate that you have included a description of ethical and regulatory training in clinical and translational research.">Verified
		</div>
		<label class="LongLabel">I am aware that incomplete applications will not be reviewed.<em>**</em></label>
		<div class="checkboxContainer"> 
			<cfinput class="checkbox" type="radio" name="rqic" value='Yes'
			 required="yes" message="Please indicate that you are aware that incomplete applications will not be reviewed.">Verified
		</div>
	</div>	
</fieldset>

<input type="hidden" name="fleEnd" value="">
<input type="hidden" name="fleEnd2" value="">
<!--- file upload information --->	
<fieldset>  
	<legend>Application Document</legend>  			
<p><b>The application attachment is a single PDF document that is comprised of a Face Page, NIH Biosketches, Proposal, Courses, and Letters of Support.</b> </p>
<font color="red"><p>Document requirements:
<ul><li>Adobe .pdf format</li>
<li>Make sure your primary application document is named in the following format: <i>LastName_FirstName</i>_TOTTS_Application.</li>
</ul>
</p></font>
<p> Use the [Browse] button to locate files on your desktop.</p> 
	<label class="required">Primary Application Document<em>**</em></label>
	<cfinput type="file" size="60" maxlength="150" name="upldFle" required="yes"
				message="Please upload application document">

<!---
	<label>Optional Second File</label>
	<input type="file" size="60" maxlength="150" name="upldFle2" value="">
--->
</fieldset>


<fieldset>
	<cfinclude template="/eall/all/cmmntInfo.cfm">
</fieldset> 

<cfinclude template="/ebaseline/subPrgrmEval.cfm"> 	

<input type="submit" value="Save and Submit" name="" class="submit-button">
  
</cfform>

<div id="contact">
Please contact CCTSI Education and Training Administration at <A href="mailto:<cfoutput>#Application.email#">#Application.email#</cfoutput></a> if you have any problems submitting this application.
</div>
<cfinclude template="/cctsi/footer.cfm">
</div>

<!-- Branching Logic -->

 <script type="text/javascript">
 var brErrExist=true;
 </script>
<script type='text/javascript'>


 function brErr(fld){alert('BRANCHING LOGIC ERRORS EXIST!\n\nThere is a syntactical error in the the Branching Logic for the field "'+fld+'" on this page. None of the Branching Logic on this data entry form will function correctly until this error has been corrected.\n\nIf you are not sure what this means, please contact your database administrator.')}var brTxt1='ERASE CURRENT VALUE OF THE FIELD';var brTxt2='The current field for which you just entered data requires that the field named';var brTxt3='be hidden from view. However, that field already';var brTxt4='has a value, so its value might need to be reset back to  a blank value.';var brTxt5='Click OK to HIDE this field and ERASE its current value.';var brTxt6='Click CANCEL if you DO NOT wish to hide this field or erase its current value.';

function doBranching(){

  if ( typeof document.cctsiform.tottsfrstapp != 'undefined')
  {		
	
	if ((document.cctsiform.tottsfrstapp.value == "No"))
		{showRow('tottsfrstappyr');}
	else
		{hideRow('tottsfrstappyr');}
  }
  
<!---
  if (document.cctsiform.appType.value == "Predoctoral student")
  {showRow('testType'); }
  else{hideRow('testType');}

  if (document.cctsiform.testType.value == "GRE")
  {showRow('dtegre'); showRow('grevr'); showRow('greqr'); showRow('greaw');}
  else{hideRow('dtegre'); hideRow('grevr'); hideRow('greqr'); hideRow('greaw');}
 

  if (document.cctsiform.testType.value == "MCAT")
  {showRow('mcvr'); showRow('mcps'); showRow('mcbs'); showRow('mcws');}
  else{hideRow('mcvr'); hideRow('mcps'); hideRow('mcbs'); hideRow('mcws');}
--->

  return false;
}
 brErrExist = doBranching();
</script>
 <script type="text/javascript">
 if(brErrExist){alert('BRANCHING LOGIC ERRORS EXIST!\n\nThere is a syntactical error in the Branching Logic of one or more fields on this page. It cannot be determined which fields contain the error, so please check the Branching Logic for every field on this page. None of the Branching Logic on this data entry form will function correctly until this error has been corrected.\n\nIf you are not sure what this means, please contact your database administrator.');}
 </script>

</body>
</html>
