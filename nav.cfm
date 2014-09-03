<div id="nav">
	<a href="<cfoutput>#request.webRoot#</cfoutput>"><!---
		 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/nav-challenges<cfif local.requestDepth eq 0>-active</cfif>.png">
	</a>
	<a href="<cfoutput>#request.webRoot#</cfoutput>register/"><!---
		 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/nav-enter<cfif findNoCase('register', cgi.script_name)>-active</cfif>.png">
	</a>
	<a href="<cfoutput>#request.webRoot#</cfoutput>gallery/"><!---
		 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/nav-view-entries<cfif findNoCase('gallery', cgi.script_name)>-active</cfif>.png">
	</a>
	<a href="<cfoutput>#request.webRoot#</cfoutput>winners/"><!---
		 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/nav-winners<cfif findNoCase('winners', cgi.script_name)>-active</cfif>.png">
	</a>
</div>