<cfcache action="flush">

<cflock name="dir_lock" type="readonly" timeout="5">
<cfdirectory action="list" name="dir_check" directory="\\Sbsfp01\SBS\Clients\Dell\Dell Engagements\">
</cflock>
 
<form name="form" action="dirtest.cfm" method="post">
<select name="dirlist">
<option value="0">Select One</option>
<cfoutput query="dir_check">
<option value="#dir_check.Name#">#dir_check.Name#</option>
</cfoutput>
</select>
<input type="submit" name="Submit" value="    Submit    ">
</form>