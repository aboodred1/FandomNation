<select class="form-control" name="challengeId" required style="font-size:.85em;">
	<option value="">Challenge&hellip;</option>
	<cfoutput query="Application.Challenges">
		<option value="#challengeId#" <cfif form.challengeId eq Application.Challenges.challengeId>selected="selected"</cfif>>#challengeName#</option>
	</cfoutput>
</select>
