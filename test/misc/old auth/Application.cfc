<cfcomponent>
	<cffunction name = "onRequestStart">
		<cfargument name = "thisRequest" required="true"/>
		<cfinclude template="mm_wizard_application_include.cfm">
		<cfif GetAuthUser() NEQ "">
			<cfoutput>
				<cfform action="mm_wizard_authenticate.cfc?method=logout&loginType=arguments.authType" method="Post">
					<cfinput type="submit" Name="Logout" value="Logout">
				</cfform>
			</cfoutput>
		</cfif>
	</cffunction>

</cfcomponent>