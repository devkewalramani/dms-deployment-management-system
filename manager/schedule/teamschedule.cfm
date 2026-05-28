<!---
This page calls on third party code to display a gantt chart view of the teams schedule
--->

<!--- legend --->
<font color="#006600" size="1">EFD/DPS DLE </font> | <font color="#0000FF" size="1">EFD/LOE</font> | <font color="#666666" size="1">DPS</font> | <font color="#99CCFF" size="1">EMC</font> | <font color="#00FF00" size="1">HP</font> | <font color="#9900FF" size="1">SUN</font> | <font color="#FF00FF" size="1">HDS</font> | <font color="#FF6600" size="1">IDS</font> | <font color="#FF0000" size="1">VACATION/TRAINING</font> | <font color="#FFCC66" size="1">SCHEDULE BLOCK</font> | <font color="#FFCCFF" size="1">SHADOW</font>
<br />

<title><cfoutput>#Form.Type#</cfoutput> Schedule</title>
<!--- lookup type of engineer based on previous selection --->
<cfquery name="SE_lookup" datasource="SBSEFD">
SELECT *
FROM dbo.SE
Where (status = '1') and (Type='#Form.Type#')
Order by Lname ASC
</cfquery>

<!--- calculate and format date fields --->
<cfset todaysdate=DateFormat(Now(),'mm/dd/yyyy')>
<cfset newdate1=#todaysdate# - 14>
<cfset newdate=#DateFormat(newdate1,'mm/dd/yyyy')#>
<cfset mdate1=#todaysdate# + 120>
<cfset mdate=#DateFormat(mdate1,'mm/dd/yyyy')#>
<!--- special lookup for all project type that are EMC --->
<cfquery name="emc_lookup" datasource="SBSEFD">
select Proj_Type_ID
from dbo.Proj_type
Where Type Like 'EMC%'
</cfquery>


<div style="height: 800; overflow-x: hidden; overflow-y:scroll;"> 
<!--- begin third party calls--->
<cf_gantt enddate="#mdate#" showAssignedTo="yes" width="1200" hscroll="Yes">


<cfoutput query="SE_lookup">
<!--- lookup projects assined to the engineer --->
<cfquery datasource="SBSEFD" name="schedule">
Select *
From dbo.Schedule
Where (EmpID = '#SE_lookup.EmpID#') and (Status <> 'Canceled') and (Startdate >= #newdate1# OR Enddate >= #newdate1#)
Order by StartDate ASC
</cfquery>

<!---do if the eng emp id equals the emp id assigned on the project --->  
<cfif  #schedule.EmpID# eq #SE_lookup.EmpID#>
<cf_ganttgroup name="#SE_lookup.Lname#, #SE_lookup.Fname#" ghref="./engdates.cfm?EmpID=#schedule.EmpID#">
<cfloop query="schedule">
<!--- default taks color--->
<cfset taskcolor='006600'>
<!--- assign specfic task colors--->
<cfif #schedule.projecttype# eq 3>
<cfset taskcolor='666666'>
<cfelseif #schedule.projecttype# eq 2>
<cfset taskcolor='0000FF'>
<cfelseif #schedule.projecttype# eq 1>
<cfset taskcolor='006600'>
<cfelseif #schedule.projecttype# eq 53>
<cfset taskcolor='006600'>
<cfelseif #schedule.projecttype# eq 43>
<cfset taskcolor='00FF00'>
<cfelseif #schedule.projecttype# eq 38>
<cfset taskcolor='9900FF'>
<cfelseif #schedule.projecttype# eq 42>
<cfset taskcolor='FF00FF'>
<cfelseif #schedule.projecttype# eq 57>
<cfset taskcolor='FF6600'>
<cfelseif #schedule.projecttype# eq 58 OR #schedule.projecttype# eq 44 OR #schedule.projecttype# eq 59>
<cfset taskcolor='FF0000'>
<cfelseif #schedule.projecttype# eq 60>
<cfset taskcolor='FFCC66'>
<cfelseif #schedule.projecttype# eq 45>
<cfset taskcolor='FFCCFF'>
<cfelse>

<cfloop query="emc_lookup">
<cfif #emc_lookup.Proj_Type_ID# eq #schedule.ProjectType#>
<cfset taskcolor='99CCFF'>
</cfif>
</cfloop>

</cfif>

<cfset pcomp=0>
<cfif #schedule.status# eq 'Completed'>
<cfset pcomp=1>
</cfif>

<cfset d1=#dateformat(startdate,'mm/dd/yy')#>
<cfset d2=#dateformat(enddate,'mm/dd/yy')#>
<!---output items--->
<cf_ganttitem name="#Dispatchid# - #ProjectName#" startdate="#Startdate#" enddate="#EndDate#" color="#taskcolor#" assignedto="#d1# - #d2#" href="./showprojinfo.cfm?RID=#schedule.RID#" Complete="#pcomp#">
</cfloop>
</cf_ganttgroup>
<!--- if the engineer didn't have any project still display just the name--->
<cfelse>

<cf_ganttgroup name="#SE_lookup.Lname#, #SE_lookup.Fname#" ghref="./engdates.cfm?EmpID=#SE_lookup.EmpID#">

<cf_ganttitem name="" startdate="#todaysdate#" enddate="#todaysdate#" color="FFFFFF" assignedto="" href="">
</cf_ganttgroup>
</cfif>
</cfoutput></cf_gantt>
</div>



 