<cfset which = "too-soon">
<cfif dateCompare(now(), '2014-07-14') lt 0>
	<cfset which = "too-soon">
</cfif>
<cfif structKeyExists(url, 'too-soon')>
	<cfset which = "too-soon">
</cfif>
<cfif dateCompare(now(), '2014-09-08') gte 0>
	<cfset which = "too-late">
</cfif>
<cfif structKeyExists(url, 'too-late')>
	<cfset which = "too-late">
</cfif>

<div class="row" id="rules">

	<div class="col-xs-12">

		<p class="text-center"><strong>NFL EXTRA POINTS #FANDOMNATION CHALLENGE<br>

		<cfif which eq "too-soon">
			COMING SOON!
		<cfelse>

			Sorry fans, but the NFL Extra Points #FandomNation Challenge has closed. <br>
			Check back on October 2nd for a complete list of winners. <br>
			In the meantime, see all of our #FandomNation Challenge submissions on the <a href="<cfoutput>#request.webRoot#</cfoutput>gallery/">View Entries</a> tab.

		</cfif>

		</strong></p>

	</div>

</div>