<!--- select which page to load based on business unit selection on daterange.cfm --->

<cfif '#form.BU#' eq 'DS'>

<CFSCRIPT>
getPageContext().forward("./dellbutracking.cfm?StartDate=#Form.StartDate#&EndDate=#Form.EndDate#&dq=#Form.dq#&dw=#Form.dw#");
</CFSCRIPT>

<cfelseif '#form.BU#' eq 'ES'>

<CFSCRIPT>
getPageContext().forward("butracking.cfm?StartDate=#Form.StartDate#&EndDate=#Form.EndDate#");
</CFSCRIPT> 


</cfif>