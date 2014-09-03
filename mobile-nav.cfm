<div class="mobile-nav">

	<div class="mobile-nav-active">
		<a href="<cfoutput>#request.webRoot#</cfoutput>" <cfif local.requestDepth eq 0>class="active"</cfif>><!---
			 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/nav-challenges<cfif local.requestDepth eq 0>-active</cfif>.png">
		</a>
		<a href="<cfoutput>#request.webRoot#</cfoutput>register/" <cfif findNoCase('register', cgi.script_name)>class="active"</cfif>><!---
			 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/nav-enter<cfif findNoCase('register', cgi.script_name)>-active</cfif>.png">
		</a>
		<a href="<cfoutput>#request.webRoot#</cfoutput>gallery/" <cfif findNoCase('gallery', cgi.script_name)>class="active"</cfif>><!---
			 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/nav-view-entries<cfif findNoCase('gallery', cgi.script_name)>-active</cfif>.png">
		</a>
		<a href="<cfoutput>#request.webRoot#</cfoutput>winners/" <cfif findNoCase('winners', cgi.script_name)>class="active"</cfif>><!---
			 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/nav-winners<cfif findNoCase('winners', cgi.script_name)>-active</cfif>.png">
		</a>
	</div>

</div>
