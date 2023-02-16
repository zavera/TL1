function imposeMaxLength(Object, MaxLen)
{
  return (Object.value.length <= MaxLen);
}

function checkForm()
{

if (document.cctsiform.appType.value == 'Predoctoral student') {
var stdt = document.getElementsByName('agncy');
var stdt_value = '';
for(var i = 0; i < stdt.length; i++){
    if(stdt[i].checked){
        stdt_value = stdt[i].value;
    }
}

if (stdt_value == '' ) {
	alert('Please enter Predoctoral student Degree Type'); 
	return false;
}
 
if (document.cctsiform.tottsfrstapp.value == 'No') {
	if (document.cctsiform.tottsfrstappyr.value == '') {
		alert('You have answered "No" to TOTTS first application.  Please enter year you first applied'); 
		return false;
	}
}

if (document.cctsiform.testType.value.length < 2) {
	alert ('Please enter GRE or MCAT information');
	return false;
}

} 

if ((!document.cctsiform.rank.checked) && (!document.cctsiform.dds.checked) && (!document.cctsiform.dnp.checked) && (!document.cctsiform.do.checked) && 
	(!document.cctsiform.dpt.checked) && (!document.cctsiform.drph.checked) && (!document.cctsiform.ma.checked) &&
	(!document.cctsiform.mba.checked) && (!document.cctsiform.md.checked) && (!document.cctsiform.mdphd.checked) &&
	(!document.cctsiform.mph.checked) && (!document.cctsiform.ms.checked) && (!document.cctsiform.pharmd.checked) &&
	(!document.cctsiform.phd.checked) && (!document.cctsiform.psyd.checked) && (!document.cctsiform.dgroth.checked)) {
	alert('Please select at least one degree.  Enter NA if PreDoctoral student'); 
	return false;
} else { 
if ((document.cctsiform.dgroth.checked) && (document.cctsiform.dgreother.value == '')){
	alert('You have selected other degree type. Please specify other degree');
	return false; 
}
}



if ((!document.cctsiform.csu.checked) && 
	(!document.cctsiform.ucamc.checked) && (!document.cctsiform.ucb.checked) && (!document.cctsiform.ucd.checked) &&
	(!document.cctsiform.affoth.checked)) {
	alert('Please select at least one institution during TOTTS'); 
	return false;
} else { 
if ((document.cctsiform.affoth.checked) && (document.cctsiform.aaffother.value == '')){
	alert('You have selected other affiliation type. Please specify other affiliation'); 
	return false;
}
}

if (document.cctsiform.cntlnbr.value != '') {
  if (document.cctsiform.cntlnbr.value.length != 4) {
	alert('Please enter Month/Day of birth in mmdd format '); 
	return false;
  } 
}

if ((!document.cctsiform.rsrtpe0.checked) && (!document.cctsiform.rsrtpe1.checked) && (!document.cctsiform.rsrtpe2.checked) && 
	(!document.cctsiform.rsrtpe3.checked) && (!document.cctsiform.rsrtpe4.checked) && (!document.cctsiform.rsrtpe5.checked)) {
	alert('Please select at least one type of research.  Selct N/A if no research activity'); 
	return false;
}


if ( typeof document.cctsiform.upldFle != 'undefined' ) {
if (document.cctsiform.upldFle.value == '') {
	alert('Please attach application documentation'); 
	return false; 
}
	else {
		var pst = document.cctsiform.upldFle.value.length - document.cctsiform.upldFle.value.lastIndexOf("."); 
		var smStrng = document.cctsiform.upldFle.value.substr(0, (document.cctsiform.upldFle.value.length - pst))
		document.cctsiform.fleEnd.value = document.cctsiform.upldFle.value.replace(smStrng,'')
		var strngEnd = document.cctsiform.upldFle.value.substr((document.cctsiform.upldFle.value.length - pst))
		if (strngEnd != '.pdf') {
			alert('Application documentation must be in .pdf format'); 
			return false; 
		}
}
}
	
if ( document.cctsiform.cmmnts.value.length > 500 ) {
		alert('Data entry is greater than the maximum number of characters (500) allowed for the Comments field.'); 
		return false; 
}

return true; 

}