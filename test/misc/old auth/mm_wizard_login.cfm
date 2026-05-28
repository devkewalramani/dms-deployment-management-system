
<cfparam name="errorMessage" default="">

<!--- output error message if it has been defined --->
<cfif len(trim(errorMessage))>
	<cfoutput>
	<ul>
		<li><font color="FF0000">#errorMessage#</font></li>
	</ul>
	</cfoutput>
</cfif>

<!--- This is the login form, you can change the font and color etc but please keep the username and password input names the same --->
<cfoutput>
<H2>Please Login using #args.authtype# authentication.</H2>

   <cfform  name="loginform" action="#CGI.script_name#?#CGI.query_string#" method="Post">
      <table>
         <tr>
            <td>username:</td>
            <td><cfinput type="text" name="j_username" required="yes" message="A username is required"></td>
         </tr>
         <tr>
            <td>password:</td>
            <td><cfinput type="password" name="j_password" required="yes" message="A password is required"></td>
         </tr>		 
      	 </table>
      <br>
      <input type="submit" value="Log In">
   </cfform>
</cfoutput>
