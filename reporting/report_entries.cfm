<cfset init("Reports","oReports","BaseComponents")>

<cfset entryCount = oReports.getEntryCount()>
<cfset entrantCount = oReports.getEntrantCount(hasEntry=true)>

<cfquery name="entriesByChallenge" datasource="#this.dsn#">
	select challengeId, challengeName, count(1) as cnt
	from uvwSelectEntries
	group by challengeId, challengeName
	order by count(1) desc
</cfquery>

<cfoutput>
<p class="lead well success">Entries: #numberFormat(entryCount, ",")#<cfif session.accessLevel eq "Admin"><a class="btn btn-info pull-right" href="tasks/export_entries.cfm">Export</a></cfif></p>
</cfoutput>

<cfset entriesByDate = oReports.getEntryCountByDate()>

<div class="panel-group" id="accordion2">

	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
					Entries By Date
				</a>
			</h4>
		</div>
		<div id="collapseOne" class="panel-collapse collapse in">
			<div class="panel-body">
				<table class="table table-striped table-condensed table-bordered">

					<thead>
						<tr>
							<th>Date</th>
							<th class="text-right">Entries</th>
							<th class="text-right">Facebook</th>
							<th class="text-right">Microsite</th>
						</tr>
					</thead>
					<tbody>

						<cfset totalFacebookEntries = 0>
						<cfset totalMicrositeEntries = 0>

						<cfoutput query="entriesByDate">

							<cfquery name="getFacebookEntries" datasource="#this.dsn#">
								select count(1) as cnt
								from uvwSelectEntries
								where dateadd(dd, datediff(dd, 0, entryDate), 0) = dateadd(dd, datediff(dd, 0, <cfqueryparam value="#entryDate#" cfsqltype="cf_sql_timestamp">), 0)
								and user_id is not null
							</cfquery>

							<cfquery name="getMicrositeEntries" datasource="#this.dsn#">
								select count(1) as cnt
								from uvwSelectEntries
								where dateadd(dd, datediff(dd, 0, entryDate), 0) = dateadd(dd, datediff(dd, 0, <cfqueryparam value="#entryDate#" cfsqltype="cf_sql_timestamp">), 0)
								and user_id is null
							</cfquery>

							<tr>
								<cfif session.accessLevel eq "Client">
									<td>#dateFormat(entryDate, "mm/dd/yyyy")#</td>
								<cfelse>
									<td><a href="lookup_submit.cfm?insertDate=#dateFormat(entryDate, 'mm/dd/yyyy')#">#dateFormat(entryDate, "mm/dd/yyyy")#</a></td>
								</cfif>
								<td class="text-right">#numberFormat(entryCount, ",")#</td>
								<td class="text-right">#numberFormat(getFacebookEntries.cnt, ",")#</td>
								<td class="text-right">#numberFormat(getMicrositeEntries.cnt, ",")#</td>
							</tr>

							<cfset totalFacebookEntries += getFacebookEntries.cnt>
							<cfset totalMicrositeEntries += getMicrositeEntries.cnt>

						</cfoutput>
					</tbody>
					<tfoot>
						<cfoutput>
							<tr class="success">
								<td class="text-right"><strong>Total:</strong></td>
								<td class="text-right">#numberFormat(entryCount, ",")#</td>
								<td class="text-right">#numberFormat(totalFacebookEntries, ",")#</td>
								<td class="text-right">#numberFormat(totalMicrositeEntries, ",")#</td>
							</tr>
						</cfoutput>
					</tfoot>
				</table>
			</div>
		</div>
	</div><!--- /accordion-group --->



	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
					Entries By Challenge
				</a>
			</h4>
		</div>
		<div id="collapseTwo" class="panel-collapse collapse">
			<div class="panel-body">
				<table class="table table-striped table-condensed table-bordered">

					<thead>
						<tr>
							<th>Challenge</th>
							<th class="text-right">Entries</th>
							<th class="text-right">Facebook</th>
							<th class="text-right">Microsite</th>
						</tr>
					</thead>
					<tbody>

						<cfset totalFacebookEntries = 0>
						<cfset totalMicrositeEntries = 0>

						<cfoutput query="entriesByChallenge">

							<cfquery name="getFacebookEntries" datasource="#this.dsn#">
								select count(1) as cnt
								from uvwSelectEntries
								where challengeId = <cfqueryparam value="#challengeId#" cfsqltype="cf_sql_integer">
								and user_id is not null
							</cfquery>

							<cfquery name="getMicrositeEntries" datasource="#this.dsn#">
								select count(1) as cnt
								from uvwSelectEntries
								where challengeId = <cfqueryparam value="#challengeId#" cfsqltype="cf_sql_integer">
								and user_id is null
							</cfquery>

							<tr>
								<td>#challengeName#</td>
								<td class="text-right">#numberFormat(cnt, ",")#</td>
								<td class="text-right">#numberFormat(getFacebookEntries.cnt, ",")#</td>
								<td class="text-right">#numberFormat(getMicrositeEntries.cnt, ",")#</td>
							</tr>

							<cfset totalFacebookEntries += getFacebookEntries.cnt>
							<cfset totalMicrositeEntries += getMicrositeEntries.cnt>

						</cfoutput>
					</tbody>
					<tfoot>
						<cfoutput>
							<tr class="success">
								<td class="text-right"><strong>Total:</strong></td>
								<td class="text-right">#numberFormat(entryCount, ",")#</td>
								<td class="text-right">#numberFormat(totalFacebookEntries, ",")#</td>
								<td class="text-right">#numberFormat(totalMicrositeEntries, ",")#</td>
							</tr>
						</cfoutput>
					</tfoot>
				</table>
			</div>
		</div>
	</div><!--- /accordion-group --->

</div>