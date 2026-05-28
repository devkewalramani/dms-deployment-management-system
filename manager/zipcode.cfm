<!--- zip code lookup--->

<script language="JavaScript">
<!--
// This will resize the window when it is opened or
// refresh/reload is clicked to a width and height of 500 x 500
// with is placed first, height is placed second
window.resizeTo(500,500)
-->
</script>

<cfquery name="zipcode" datasource="SBSEFD">
select *
from dbo.zipcode
where state='#Form.State#'
Order by City ASC
</cfquery>

<table width="300" bgcolor="#CCCCCC">
  <tr>
    <th colspan="2" bgcolor="#FFFFFF" scope="col"><div align="left">State: <cfoutput>#Form.State#</cfoutput></div></th>
  </tr>
  <tr>
    <th bgcolor="#FFFFFF" scope="col">City</th>
    <th bgcolor="#FFFFFF" scope="col">Zipcode</th>
  </tr>
  <cfoutput query="zipcode">
  <tr>
    <td bgcolor="##FFFFFF"><div align="center">#City#</div></td>
    <td bgcolor="##FFFFFF"><div align="center">#Zipcode#</div></td>
  </tr>
  </cfoutput>
</table>
