<cfif session.accessLevel eq "Client">
	<cflocation url="reports.cfm" addtoken="no">
</cfif>

<cfset init("Entrants","oEntrants","BaseComponents")>
<cfset init("Entries","oEntries","BaseComponents")>
<cfset init("Pagination","oPager","BaseComponents")>
<cfset init("Reports","oReports","BaseComponents")>

<cfparam name="form.firstName" default="">
<cfparam name="form.lastName" default="">
<cfparam name="form.emailAddress" default="">
<cfparam name="form.insertDate" default="">
<cfparam name="form.hasEntry" default=1>
<cfparam name="form.challengeId" default="">
<cfparam name="form.teamId" default="">

<cfif isDefined("url.firstName")><cfset form.firstName = url.firstName></cfif>
<cfif isDefined("url.lastName")><cfset form.lastName = url.lastName></cfif>
<cfif isDefined("url.emailAddress")><cfset form.emailAddress = url.emailAddress></cfif>
<cfif isDefined("url.insertDate")><cfset form.insertDate = url.insertDate></cfif>
<cfif isDefined("url.hasEntry")><cfset form.hasEntry = url.hasEntry></cfif>
<cfif isDefined("url.challengeId")><cfset form.challengeId = url.challengeId></cfif>
<cfif isDefined("url.teamId")><cfset form.teamId = url.teamId></cfif>

<cfif structKeyExists(form, "fieldNames")>
	<cfloop list="#form.fieldNames#" index="key">
		<cfset structInsert(url, key, evaluate("form.#key#"))>
	</cfloop>
</cfif>

<cfquery name="entrantSelect" datasource="#this.dsn#">
	select e.entrantID
	from Entrants e
	where isdate(e.deleteDate) = 0
	<cfif len(form.firstName)>
		and e.firstName = <cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">
	</cfif>
	<cfif len(form.lastName)>
		and e.lastName = <cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_varchar">
	</cfif>
	<cfif len(form.emailAddress)>
		and e.emailAddress = <cfqueryparam value="#form.emailAddress#" cfsqltype="cf_sql_varchar">
	</cfif>
	<cfif len(form.insertDate)>
		<!--- and cast(convert(varchar, E.insertDate, 101) as datetime) = cast(convert(varchar, <cfqueryparam value="#form.insertDate#" cfsqltype="cf_sql_varchar">, 101) as datetime) --->
		and dateadd(dd, datediff(dd, 0, e.insertDate), 0) = dateadd(dd, datediff(dd, 0, <cfqueryparam value="#form.insertDate#" cfsqltype="cf_sql_timestamp">), 0)
		or exists (
			select 1
			from Entries
			where isdate(deleteDate) = 0
			and entrantID = e.entrantID
			and dateadd(dd, datediff(dd, 0, insertDate), 0) = dateadd(dd, datediff(dd, 0, <cfqueryparam value="#form.insertDate#" cfsqltype="cf_sql_timestamp">), 0)
		)
	</cfif>
	<cfif form.hasEntry>
		and exists (
			select 1
			from Entries
			where isdate(deleteDate) = 0
			and entrantID = e.entrantID
		)
	</cfif>
	<cfif len(form.challengeId)>
		and exists (select 1 from Entries where entrantId = e.entrantId and challengeId = <cfqueryparam value="#form.challengeId#" cfsqltype="cf_sql_integer">)
	</cfif>
	<cfif len(form.teamId)>
		and exists (select 1 from Entries where entrantId = e.entrantId and teamId = <cfqueryparam value="#form.teamId#" cfsqltype="cf_sql_integer">)
	</cfif>
</cfquery>

<cfset entrantCount = entrantSelect.recordCount>
<cfparam name="url.page" default=1>
<cfset page = val(url.page)>
<cfif page lt 1><cfset page = 1></cfif>
<cfset currentPage = int(page)>
<cfset recordsPerPage = 20>
<cfset startNdx = (currentPage * recordsPerPage) - (recordsPerPage - 1)>


<div class="panel panel-default">

	<div class="panel-heading">
		<h1>
			Search Results
		</h1>
	</div>

	<div class="panel-body">

		<cfif entrantCount gt 0>

			<cfset linkTarget = "entrant_detail.cfm">

			<p class="lead"><cfoutput>#numberFormat(entrantCount, ",")# record<cfif entrantCount gt 1>s were<cfelse> was</cfif> found matching your criteria.</cfoutput></p>

			<cfoutput>#oPager.showPagination(totalRecords=entrantCount,recordsPerPage=recordsPerPage,currentPage=currentPage,url_params=url,bootstrap=true,version=3)#</cfoutput>

			<p>Entrants <cfif entrantCount gt recordsPerPage>(<cfoutput>#recordsPerPage#</cfoutput> per page)</cfif></p>

			<table class="table table-striped table-condensed table-bordered">

				<thead>

					<tr>
						<th>#</th>
						<th>Entry Date</th>
		                <th>Name</th>
						<th>Email Address</th>
						<th class="text-right">Entries</th>
					</tr>

				</thead>

				<tbody>

					<cfset totalEntries = 0>

					<cfoutput query="entrantSelect" startrow="#startNdx#" maxrows="#recordsPerPage#">

						<cfset entrantDetail = oEntrants.getEntrantDetails(entrantID)>
						<cfset entryCount = oReports.getEntryCount(entrantID=entrantID)>

						<tr>
							<td>#currentRow#</td>
		                    <td>#dateFormat(entrantDetail.insertDate, 'mm/dd/yyyy')#<br>#timeFormat(entrantDetail.insertDate, 'h:mm TT')# #application.tzid#</td>
		                    <td>#entrantDetail.firstName# #entrantDetail.lastName#</td>
		                    <td><a href="#linkTarget#?entrantID=#entrantSelect.entrantID#">#entrantDetail.emailAddress#</a></td>
		                   <td class="text-right">#numberFormat(entryCount, ",")#</td>
						</tr>

						<cfset totalEntries += entryCount>

					</cfoutput>

				</tbody>

				<tfoot>
					<tr class="success">
						<td colspan="4" class="text-right"><strong>Total:</strong></td>
						<td class="text-right"><cfoutput>#numberFormat(totalEntries, ",")#</cfoutput></td>
					</tr>
				</tfoot>

			</table>

		<cfelse>

			<div class="alert alert-warning">
				<strong>No entries were found matching your criteria.</strong>
				<p>Please go back and try again.</p>
			</div>


		</cfif>

	</div>

</div>