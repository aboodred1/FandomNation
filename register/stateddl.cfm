<cfquery name="stateSelect" datasource="reference">
	select
		  st_desc
		, st_code
	from uvwus50
	order by st_desc
</cfquery>

<cfparam name="stateField" default="state">

<select class="form-control" name="<cfoutput>#stateField#</cfoutput>" required style="font-size:.85em;">
	<option value="">Select&hellip;</option>
	<cfoutput query="stateSelect">
		<option value="#st_code#" <cfif form["#stateField#"] eq st_code>selected="true"</cfif>>#st_desc#</option>
	</cfoutput>
</select>