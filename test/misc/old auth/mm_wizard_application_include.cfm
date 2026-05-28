<!--- MM WIZARD CODE: BEGIN   --->

	<!--- Set the Simple Authentication Logic parameters --->
	<cfset args = StructNew()>

	<!--- Authentication Type ---->
	<cfset args.authtype = "Simple">
	<cfset args.suser = "efdmanager">
	<cfset args.spwd = "A8D55B38B518EDCFDA4DC1CA9A0CA9311FFA4C5E">

	<!--- Login type--->
	<cfset args.authLogin = "challenge">

	<!--- Login Page ---->
	<cfset args.loginform = "mm_wizard_login.cfm">

	<!--- Call the CFC to do the authentication --->
	<cfinvoke component="mm_wizard_authenticate" method="performlogin">
		<cfinvokeargument name="args" value="#args#">
	</cfinvoke>

<!--- MM WIZARD CODE: END --->