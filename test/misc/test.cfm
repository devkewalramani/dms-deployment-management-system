<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<cfmail from = "dms@sbsplanet.com" To = "dkewalramani@sbsplanet.com" 
Subject = "ingore testing email from webapp">
   <cfmailpart 
      type="text"
      wraptext="74">
         You are reading this message as plain text, because your mail reader 
         does not handle HTML text.
		 
		 <table width="100%" border="1">
  <tr>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Dexterra ID </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Omni</span></th>
    
  </tr>
  <tr>
    <td><span class="style2">1</span></td>
    <td><span class="style2">2</span></td>
 
  </tr>
</table>

   </cfmailpart>>
   <cfmailpart 
      type="html">
         <h3>HTML Mail Message</h3>
         <p>You are reading this message as <strong>HTML</strong>.</p>
         <p>Your mail reader handles HTML text.</p>
		 
		  <table width="100%" border="1">
  <tr>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Dexterra ID </span></th>
    <th bgcolor="##FFCC66" scope="col"><span class="style2">Omni</span></th>
    
  </tr>
  <tr>
    <td><span class="style2">1</span></td>
    <td><span class="style2">2</span></td>
 
  </tr>
</table>
   </cfmailpart>
</cfmail>

</body>
</html>
