
<cfset ProjectName='sbs'>
<cfset startdate=Now()>
<cfset projcode='123456789'>


<!-- create project directory code-->
<cfset dirdate=#dateformat(startdate,'mm.dd.yyyy')#>
<cfset dirname=#ProjectName# & '-' & #dirdate# & '-' & #projcode#>

<cfcache action="flush">
<cfset projdir="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\" & #Form.dirlist# & '\' & #dirname#>
<cfset chdir="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\" & #Form.dirlist# & '\'>

<cflock name="dir_lock" type="readonly" timeout="5">
<cfdirectory action="list" name="dir_check" directory="#chdir#">
</cflock>
 
<!-- Check to see if the directory exists-->
<cfset dir_exists='n'>

<cfoutput query="dir_check">
<cfif dir_check.Name eq #dirname#>
<cfset dir_exists='y'>
Project Directory already existes and was not re-created
</cfif>
</cfoutput>

<cfif dir_exists eq 'n'>
<cflock name="dir_lock" type="exclusive" timeout="5">
<cfdirectory action="create" directory="#projdir#">
</cflock>
Project Directory Created
</cfif>