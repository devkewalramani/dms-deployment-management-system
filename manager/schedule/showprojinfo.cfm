<!--- this page displays the project info when clicked on from the gantt chart view--->
<script language="JavaScript">
<!--
// This will resize the window when it is opened or
// refresh/reload is clicked to a width and height of 500 x 500
// with is placed first, height is placed second
window.resizeTo(600,600)
-->
</script>

<cfquery name="lookup" datasource="SBSEFD">
select *
from dbo.schedule
where RID=#URL.RID#
</cfquery>

<cfquery name="trcurrent" datasource="SBSEFD">
select *
from dbo.travel
where RID=#URL.RID#
</cfquery>


<style type="text/css">
<!--
.style1 {
	font-size: 10px;
	font-weight: bold;
}
.style4 {font-size: 10px}
.style2 {font-size: 10px; color:#0000FF;}
-->
</style>

<cfoutput query="lookup">

<cfquery name="proj_type_lookup" datasource="SBSEFD">
select Type
from dbo.Proj_Type
where Proj_Type_ID=#ProjectType#
</cfquery>

      <table width="482" border="0"> 
        
        <tr>
          <th colspan="3" bgcolor="##CCCCCC" class="pageheader style4" scope="row">General Dispatch Information</th>
        </tr>
        <tr>
          <th width="91" class="style1" scope="row"><div align="right" class="style1"><span class="style25">Dispatch ID:</span> </div></th>
          <td colspan="2" class="maincontent style4"><span class="style2">
            #dispatchid#</span><strong>OMNI Number: </strong><span class="style2">#omninum#</span>
			<strong>Dell Pid: </strong><span class="style2">#dell_pid#</span>			</td>
        </tr>
        <tr>
          <th class="style1" scope="row"><div align="right" class="style4"><strong>SBS Proj Code: </strong></div></th>
          <td colspan="2" class="maincontent style4"><span class="style2">#projcode#</span> 
		  <strong>PO Number: </strong><span class="style2">#PO_Num#</span>
		  </td>
        </tr>
        <tr>
          <th class="style1" scope="row"><div align="right" class="style4"><strong>Project Name: </strong></div></th>
          <td colspan="2" class="maincontent style4"><span class="style2">#projectname#</span>&nbsp;</td>
        </tr>
        <tr>
          <th class="style1" scope="row"><div align="right" class="style4"><strong>City: </strong></div></th>
          <td colspan="2" class="maincontent style4"><span class="style2">#Projectcity#</span><strong> State:</strong><span class="style2"> #projectstate#</span> <strong>Zip Code: </strong><span class="style2">#projectzip#</span></td>
        </tr>
        <tr>
          <th class="style1" scope="row"><div align="right" class="style4"><strong>Start Date: </strong></div></th>
          <td width="93" class="style2">#dateformat(startdate,'mm/dd/yyyy')#</td>
          <td width="284" class="maincontent style4"><strong>Start Time:</strong><span class="style2"> #timeformat(starttime,'h tt')#</span></td>
        </tr>
        <tr>
          <th class="style1" scope="row"><div align="right" class="style4"><strong>End Date: </strong></div></th>
          <td class="style2">#dateformat(enddate,'mm/dd/yyyy')#</td>
          <td class="maincontent style4"><strong>End Time: </strong><span class="style2">#timeformat(endtime,'h tt')#</span></td>
        </tr>
        <tr>
          <th class="style1" scope="row"><div align="right" class="style4"><strong>SE:</strong></div></th>
          <td colspan="2" class="maincontent style4"><span class="style2">#SE_Fname#</span> <span class="style2">#SE_Lname#</span></td>
        </tr>
        <tr>
          <th class="style1" scope="row"><div align="right" class="style4"><strong>Project Type: </strong></div></th>
          <td  class="style2">#proj_type_lookup.type# </td>
		  <td class="maincontent style4"><strong>DM: </strong><span class="style2">#DM#</span></td>
        </tr>
        <tr>
          <th class="style1" scope="row"><div align="right" class="style4"><strong>Status:</strong></div></th>
          <td colspan="2" class="style2">#Status#</td>
        </tr>
        <tr>
          <th colspan="3" bgcolor="##CCCCCC" class="pageheader style4" scope="row">Travel Section </th>
        </tr>
        <tr>
          <th class="maincontent" scope="row"><div align="right" class="style4"><strong>TR Status: </strong></div></th>
          <td colspan="2" class="style2">#trcurrent.tr_status#</td>
        </tr>
        <tr>
          <th class="maincontent style4" scope="row">&nbsp;</th>
          <td colspan="2" class="maincontent style4"><strong>Flight: </strong><span class="style2">#trcurrent.flight# </span><strong>Hotel: </strong><span class="style2">#trcurrent.hotel#</span><strong> Car Rental:</strong><span class="style2"> #trcurrent.rental#</span></td>
        </tr>
        <tr>
          <th class="maincontent" scope="row"><div align="right" class="style4"><strong>Travel Notes: </strong></div></th>
          <td colspan="2" class="style2">#trcurrent.travelnotes#</td>
        </tr>
        <tr>
          <th colspan="3" bgcolor="##CCCCCC" class="pageheader style4" scope="row">LOE Information </th>
        </tr>
        <tr>
          <th class="maincontent" scope="row"><div align="right" class="style4"><strong>LOE AMT $: </strong></div></th>
          <td colspan="2" class="maincontent">
            <span class="style2"><strong>#LOE_Price#</strong></span><span class="style4"><strong> 
            TRAVEL $: 
            </strong></span><span class="style2"><strong>#Travel_price#</strong></span><span class="style4"><strong> TRAVEL BILLABLE: </strong></span><span class="style2"><strong>#Bill_travel#</strong></span>            </td>
        </tr>
        
        <tr>
          <th colspan="3" bgcolor="##CCCCCC" class="pageheader style4" scope="row">Project Information </th>
        </tr>
        <tr>
          <th class="maincontent" scope="row"><div align="right" class="style4"><strong>Project Summary:</strong></div></th>
          <td colspan="2" class="style2">#projectsummary#</td>
        </tr>
        <tr>
          <th class="maincontent" scope="row"><div align="right" class="style4"><strong>Project Notes:</strong></div></th>
          <td colspan="2"><textarea name="ProjectNotes" cols="60" rows="5" readonly="yes" class="style2">#ProjectNotes#</textarea></td>
        </tr>
  </table>


</cfoutput>