<HTML>
<HEAD>
<SCRIPT LANGUAGE="JavaScript">
<!--
function validateForm(objForm)
{
	var returnStatus = 1;

	if (objForm.q_one.selectedIndex == 0) {
		alert("Please select a Project Task");
		returnStatus = 0;
	};

	if (returnStatus) {
		objForm.submit();
	}
}
// -->
</SCRIPT>
</HEAD>
<BODY>
<FORM ACTION="" NAME="testform">
<SELECT NAME="q_one">
	<option value="0">Select One</option>
		<option value="1 to 2 Host DAS Deploy Bundle">1 to 2 Host DAS Deploy Bundle</option>
		<option value="3 to 4 Host DAS Deploy Bundle">3 to 4 Host DAS Deploy Bundle</option>
		<option value="1 to 2 Host SAN Deploy Bundle">1 to 2 Host SAN Deploy Bundle</option>
		<option value="3 to 4 Host SAN Deploy Bundle">3 to 4 Host SAN Deploy Bundle</option>
		<option value="">5 to 7 Host SAN Deploy Bundle</option>
		<option value="">8 to 15 Host SAN Deploy Bundle</option>
		<option value="">16 to 23 Host SAN Deploy Bundle</option>
		<option value="">Platform Upgrade CXxxx to CXxxx</option>
		<option value="">RSME</option>
		<option value="">Windows 2000 SQL Design Add-On</option> 
		<option value="">Exchange 2000 Cluster Design Add-On</option> 
		<option value="">File & Print Cluster Design Add-On</option>
		<option value="">Dell/EMC DAS Flarecode, Software and Firmware Upgrade</option> 
		<option value="">Dell/EMC SAN 1-2 hosts Flarecode, Software and Firmware Upgrade</option> 
		<option value="">Dell/EMC SAN 3-4 host Flarecode, Software and Firmware Upgrade</option> 
		<option value="">Dell/EMC SAN 5-7 hosts Flarecode, Software and Firmware Upgrade</option> 
		<option value="">Dell/EMC SAN 8-15 host Flarecode, Software and Firmware Upgrade</option>
		<option value="">Dell/EMC SAN 16-23 host Flarecode, Software and Firmware Upgrade</option> 
		<option value="">Dell/EMC SAN per host above 23 host Flarecode, Software and Firmware Upgrade</option> 
		<option value="">SMS</option>
		<option value="">Dell Server and NOS Install</option>
		<option value="">Dell NAS Filer Install</option>
		<option value="">DAE or Switch add</option>
		<option value="">Window Active/Passive or Single node Cluster</option>
		<option value="">HBA Install</option>
		<option value="">Snapview Implementation</option>
		<option value="">Mirrorview Implementation</option>
		<option value="">Visual SAN Add-On Implementation</option>
		<option value="">Add Dell Host</option> 
		<option value="">Add Non-Dell Host</option> 
		<option value="">External DLT Tape Library Hardware Install</option>
		<option value="">External DLT Tape Library Hardware Install-stand alone engagement</option>
		<option value="">Dell PowerVault Library Hardware Install</option>
		<option value="">Dell PowerVault Library Hardware Install-stand alone engagement</option>
		<option value="">Backup Exec Backup Production Readiness</option> 
		<option value="">Veritas Netbackup Backup Production Readiness</option> 
		<option value="">CommVault Backup Production Readiness</option> 
		<option value="">ArcServe Backup Production Readiness</option> 
		<option value="">Legato Backup Production Readiness</option> 
		<option value="">Data Migration Up to 1TB</option>
		<option value="">Data Migration Up to 1.5TB</option>
		<option value="">Data Migration Up to 2TB</option>
		<option value="">Data Migration Up to 3TB</option>
		<option value="">A/A SQL Cluster</option>
		<option value="">A/A Cluster</option>
		<option value="">Data Center Move</option>
		<option value="">Scripting</option>
		<option value="">SAN Copy Implementation</option>
</SELECT>	
<INPUT TYPE="BUTTON" VALUE="Send form" onClick="validateForm(document.testform)">
</FORM>
</BODY>
</HTML>
