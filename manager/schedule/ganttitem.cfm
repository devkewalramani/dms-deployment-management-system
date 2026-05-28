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
STARTDATE [REQUIRED] Gantt chart item start date  
ENDDATE   [REQUIRED] Gantt chart item end date 
COLOR   [OPTIONAL] Gantt chart item color
MILESTONE [OPTIONAL] Indicates whether this is a milestone (only works if there is no ENDDATE)
COMPLETE [OPTIONAL] Percent Complete (ie 25% or 0.25)
--->

<!--- Set defaults --->
<CFPARAM name="attributes.color" default="6f6f6f">
<CFPARAM name="attributes.href" default="">
<CFPARAM name="attributes.complete" default="0">
<CFPARAM name="attributes.milestone" default="0">
<CFPARAM name="attributes.assignedto" default="">
<CFPARAM name="attributes.id" default="">
<CFPARAM name="attributes.dependencies" default="">
<CFSET child = 0>
<CFSET parentid = 0>

<!--- Convert %nn to real percent --->
<CFIF attributes.complete contains "%">
	<CFSET attributes.complete = replacenocase(attributes.complete,"%","")>
	<CFIF isnumeric(attributes.complete) and attributes.complete lte 100>
		<CFSET attributes.complete = attributes.complete/100>
	<CFELSE>
		<CFSET attributes.complete = 0>
	</CFIF>
</CFIF>
<!--- Get attributes and variables from base <CF_GANTT> tag --->
<cfset gantt = GetBaseTagData('cf_gantt')>

<!--- If this item has a parent, mark it as a child and find out who the parent is --->
<cfif listfindnocase(getbasetaglist() ,"CF_GANTTGROUP")>
	<cfset child = 1>
	<cfassociate baseTag="CF_GANTTGROUP" datacollection="childitems">
	<cfset ganttgroup = GetBaseTagData('cf_ganttgroup')>
	<cfset parentid = ganttgroup.groupid>
</cfif>

<!--- Set current ID --->
<cfset gantt.id = gantt.id +1 >

<cfif not len(trim(attributes.id))>
	<cfset attributes.id = "fakeid_#gantt.id#">
</cfif>
<!--- Add an item to the gantt chart --->
<cfset queryaddrow(gantt.qItems)>
<cfset querysetcell(gantt.qItems,"realid",attributes.id)>
<cfset querysetcell(gantt.qItems,"dependencies",attributes.dependencies)>
<cfset querysetcell(gantt.qItems,"id",gantt.id)>
<cfset querysetcell(gantt.qItems,"name",attributes.name)>
<cfset querysetcell(gantt.qItems,"lenname",len(attributes.name))>
<cfset querysetcell(gantt.qItems,"assignedto",attributes.assignedto)>
<CFSET querysetcell(gantt.qItems,"lenassignedto",len(attributes.assignedto))>
<cfset querysetcell(gantt.qItems,"startdate",attributes.startdate)>
<cfif not isdefined("attributes.enddate")>
	<cfset attributes.enddate = attributes.startdate>
</cfif>
<cfset querysetcell(gantt.qItems,"enddate",attributes.enddate)>
<cfset querysetcell(gantt.qItems,"color",attributes.color)>
<cfset querysetcell(gantt.qItems,"href",attributes.href)>
<cfset querysetcell(gantt.qItems,"complete",attributes.complete)>
<cfset querysetcell(gantt.qItems,"group",0)>
<cfset querysetcell(gantt.qItems,"child",child)>
<cfset querysetcell(gantt.qItems,"parentid",parentid)>
<cfset querysetcell(gantt.qItems,"milestone",attributes.milestone)>