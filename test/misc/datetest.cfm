<cfset x=Now()>
<cfset xdate=#dateformat(x,'mm.dd.yyyy')#>
<cfset projname='Test Shit'>
<cfset projcode='123456789'>

<cfset dirname=#projname# & '-' & #xdate# & '-' & #projcode#>

<cfoutput> #dirname#</cfoutput>