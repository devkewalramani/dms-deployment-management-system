<cfquery datasource="SBSEFD" name="se">
Select *
From dbo.se
Where (status='1') and (BU_group='DS')
Order by lname asc
</cfquery>

<cfoutput query="se">

<cfquery datasource="SBSEFD" name="dellpayment">
Select *
From dbo.Schedule
Where (Startdate between '4/2/2007' and '4/8/2007') and (empid='#se.empid#')
Order by ProjectName ASC
</cfquery>

<cfif #dellpayment.empid# eq #se.empid#>
#dellpayment.projectname# - #dellpayment.SE_Lname#, #dellpayment.SE_Fname#
<br>
<cfelseif #dellpayment.empid# neq #se.empid# AND #se.type# eq 'Non DLE'>
#se.lname#, #se.fname# - Not Scheduled - 0 earned revenue
<br>
</cfif>
</cfoutput>