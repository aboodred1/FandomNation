<cfquery name="getTeams" datasource="#this.dsn#">
	select teamId, teamName, teamIcon
	from Teams
	order by TeamName
</cfquery>


<cfquery name="getSelectedTeamName" datasource="#this.dsn#">
	select teamId, teamName, teamIcon
	from Teams
	<cfif len(form.teamId)>
		where teamId = <cfqueryparam value="#form.teamId#" cfsqltype="cf_sql_integer">
	</cfif>
	order by TeamName
</cfquery>

<!--- <select class="form-control" name="teamId" required>
	<option value="">
		Select&hellip;
	</option>
	<cfoutput query="getTeams">
		<option value="#teamId#" <cfif form.teamId eq getTeams.teamId>selected="selected"</cfif>>
			#teamName#
	</option>
	</cfoutput>
</select> --->

<!--- this is the same as how i did for wrangler --->
<div class="btn-group btn-block custom-select <cfif listFindNoCase(errorFields, 'teamId')>has-error</cfif>">
	<button type="button" class="btn btn-default btn-select custom-select-label btn-block">
		<cfif len(form.teamId)><cfoutput>#HTMLEditFormat(getSelectedTeamName.teamName)#</cfoutput><cfelse>Team&hellip;</cfif>
	</button>
	<button type="button" class="btn btn-default btn-select dropdown-toggle" data-toggle="dropdown">
		<span class="caret"></span>
		<span class="sr-only">Select Team&hellip;</span>
	</button>
	<ul class="dropdown-menu custom-select-options" role="menu">
		<li>
			<a href="#" data-id="">Team&hellip;</a>
		</li>
		<cfoutput query="getTeams">
			<li>
				<a href="##" data-id="#teamId#">
					<cfif len(teamIcon)>
						<img src="#request.webRoot#images/#teamIcon#" style="max-width:16px;max-height:16px;">
					</cfif>
					#teamName#
				</a>
			</li>
		</cfoutput>
	</ul>
	<input type="hidden" name="teamId" value="<cfoutput>#HTMLEditFormat(form.teamId)#</cfoutput>">
</div>
