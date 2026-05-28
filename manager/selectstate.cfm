<!--- dropdown menu of all the states for zip code lookup--->

<head>
<script language="JavaScript">
<!--
// This will resize the window when it is opened or
// refresh/reload is clicked to a width and height of 500 x 500
// with is placed first, height is placed second
window.resizeTo(500,500)
-->
</script>
</head>
<body>
<cfquery name="state" datasource="SBSEFD">
select distinct(state)
from dbo.zipcode
order by State ASC
</cfquery>

<form name="Form" action="zipcode.cfm" method="post">
<table width="300" bgcolor="#CCCCCC">
  <tr>
    <th bgcolor="#FFFFFF" scope="col"><div align="center">Select State </div></th>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF">
	  <div align="center">
	    <select name="State">
	        <cfoutput query="state">
	            <option value="#state#">#state#</option>
              </cfoutput>
	        </select>
        </div></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF"><div align="center">
      <input type="submit" value="Submit">
    </div></td>
  </tr>
</table>
</form>

</body>