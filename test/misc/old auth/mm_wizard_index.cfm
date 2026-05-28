
<cfset path = ExpandPath("*.*")>
<cfset directory = GetDirectoryFromPath(path)>

<strong>You have successfully logged into the new application that the Wizard created for you</strong> 
<ul>
  <li>This application is secure, not only this file but any file that you created in the <cfoutput>#directory#</cfoutput> folder      </li>
  <li>This file is the entry point for your application and can be renamed to index.cfm or anything you want, if you so desire        </li>
  <li>You can also remove any or all of this text and replace it with any valid browser code that you choose, such as CFML or HTML</li>
</ul>
