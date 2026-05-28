<!--- 
<CF_GANTTITEM>
Description: Custom tag used within <CF_GANTT>, creates one row and gantt timeline.
File: ganttitem.cfm
Author: Shlomy Gantz
Dependencies: Must be used within <CF_GANTT> chart
History:
12/08/04 - Added Color Attribute

Attributes:
NAME	  [REQUIRED] Gantt chart item name
STARTDATE [OPTIONAL] Gantt chart item start date  
ENDDATE   [OPTIONAL] Gantt chart item end date 
COLOR   [OPTIONAL] Gantt chart item color
--->
<!--- Set defaults --->
<cfparam name="attributes.color" default="000000">
<cfparam name="attributes.ghref" default="">
<cfparam name="attributes.startdate" default="">
<cfparam name="attributes.enddate" default="">
<CFPARAM name="attributes.assignedto" default="">
<CFPARAM name="attributes.id" default="">
<CFPARAM name="attributes.dependencies" default="">
<!--- Get attributes and variables from base <CF_GANTT> tag --->
<CFSET gantt = GetBaseTagData('cf_gantt')>
<CFIF not thisTag.hasEndTag>
	<cfthrow type="Gantt" message="End tag required" detail="The cf_ganttgroup custom tag requires an end tag">
</CFIF>
 
<CFSWITCH expression="#thisTag.executionMode#">
	<!--- Excute on CF_GANTTGROUP start  --->
	<CFCASE value="Start">
	
		<CFSET gantt.id = gantt.id +1 >
		<CFSET groupid = gantt.id >
		<CFSET parentid = 0>
		<CFSET child = 0>
		
		<!--- Find out if this group has a parent --->
		<CFIF listfindnocase(replace(getbasetaglist(),"CF_GANTTGROUP","") ,"CF_GANTTGROUP")>
			<CFSET ganttgroup = GetBaseTagData('cf_ganttgroup',2)>
			<CFSET parentid = ganttgroup.groupid>
			<CFSET child = 1>
		</CFIF>
		<cfif not len(trim(attributes.id))>
			<cfset attributes.id = "fakeid_#gantt.id#">
		</cfif>
		
		<!--- Add an item to the gantt chart --->
		<CFSET queryaddrow(gantt.qItems)>
		<CFSET querysetcell(gantt.qItems,"realid",attributes.id)>
		<CFSET querysetcell(gantt.qItems,"dependencies",attributes.dependencies)>
		<CFSET querysetcell(gantt.qItems,"id",gantt.id)>
		<CFSET querysetcell(gantt.qItems,"name",attributes.name)>
		<CFSET querysetcell(gantt.qItems,"lenname",len(attributes.name))>
		<CFSET querysetcell(gantt.qItems,"assignedto",attributes.assignedto)>
		<CFSET querysetcell(gantt.qItems,"lenassignedto",len(attributes.assignedto))>
		<CFSET querysetcell(gantt.qItems,"complete",0)>
		<CFSET querysetcell(gantt.qItems,"color",attributes.color)>
		<CFSET querysetcell(gantt.qItems,"ghref",attributes.ghref)>
		<CFSET querysetcell(gantt.qItems,"startdate",attributes.startdate)>
		<CFSET querysetcell(gantt.qItems,"enddate",attributes.enddate)>
		<CFSET querysetcell(gantt.qItems,"group",1)>
		<CFSET querysetcell(gantt.qItems,"children",0)>
		<CFSET querysetcell(gantt.qItems,"child",child)>
		<CFSET querysetcell(gantt.qItems,"parentid",parentid)>
		<CFSET querysetcell(gantt.qItems,"milestone",0)>
	</CFCASE>
	<CFCASE value="end">
		<CFPARAM name="thisTag.childitems" default="#ArrayNew(1)#">
		<!--- Stretch the group to fit all the sub-items --->
		<CFLOOP from="1" to="#arraylen(thisTag.childitems)#" index="idx">
			<CFIF not isdate(attributes.startdate)>
				<CFSET querysetcell(gantt.qItems,"startdate",thisTag.childitems[idx].startdate,groupid)>
				<CFSET attributes.startdate = thisTag.childitems[idx].startdate>
			</CFIF>
			<CFIF not isdate(attributes.enddate)>
				<CFSET querysetcell(gantt.qItems,"enddate",thisTag.childitems[idx].enddate,groupid)>
				<CFSET attributes.enddate = thisTag.childitems[idx].enddate>
			</CFIF>
			<CFIF attributes.startdate GT thisTag.childitems[idx].startdate>
				<CFSET querysetcell(gantt.qItems,"startdate",thisTag.childitems[idx].startdate,groupid)>
				<CFSET attributes.startdate = thisTag.childitems[idx].startdate>
			</CFIF>
			<CFIF attributes.enddate LT thisTag.childitems[idx].enddate>
				<CFSET querysetcell(gantt.qItems,"enddate",thisTag.childitems[idx].enddate,groupid)>
				<CFSET attributes.enddate = thisTag.childitems[idx].enddate>
			</CFIF>
		</CFLOOP>
	
	</CFCASE><!--- /cfcase value="end" --->
</CFSWITCH><!--- /cfswitch expression="#thisTag.executionMode#" --->