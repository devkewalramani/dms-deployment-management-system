<!---
redirects based selection from select.cfm
--->
<cfif '#form.option#' eq 0>

<CFSCRIPT>
getPageContext().forward("./schedule/showprojinfo.cfm?RID=#Form.Rid#");
</CFSCRIPT>

<cfelseif '#form.option#' eq 1>

<CFSCRIPT>
getPageContext().forward("editselected.cfm?RID=#Form.Rid#");
</CFSCRIPT> 

<cfelseif '#form.option#' eq 2>

<CFSCRIPT>
getPageContext().forward("reschedule.cfm?RID=#Form.Rid#");
</CFSCRIPT> 


<cfelseif '#form.option#' eq 3>

<CFSCRIPT>
getPageContext().forward("doc_trackingselected.cfm?RID=#Form.Rid#");
</CFSCRIPT> 

<cfelseif '#form.option#' eq 4>

<CFSCRIPT>
getPageContext().forward("cancel.cfm?RID=#Form.Rid#");
</CFSCRIPT> 

</cfif>