
<cfquery name="suspectEntrantSelect" datasource="#this.dsn#">
	select e.*
	from Entrants e
	where e.suspect = 1
</cfquery>
<cfquery name="suspectEntrySelect" datasource="#this.dsn#">
	select e.*
	from Entries e
	where e.suspect = 1
</cfquery>
<cfquery name="suspectTrafficSelect" datasource="#this.dsn#">
	select e.*
	from PageHits e
	where e.suspect = 1
</cfquery>

<cfset suspectEntrantCount = suspectEntrantSelect.recordCount>
<cfset suspectEntryCount = suspectEntrySelect.recordCount>
<cfset suspectTrafficCount = suspectTrafficSelect.recordCount>

<cfoutput>
	<p class="lead well success">
		Entrants: #numberFormat(suspectEntrantCount, ",")# |
		Entries: #numberFormat(suspectEntryCount, ",")# | 
		Traffic: #numberFormat(suspectTrafficCount, ",")#
	</p>
</cfoutput>

<div class="accordion" id="accordion2">
	<div class="accordion-group">
		
		<cfif suspectEntrantCount gt 0>
			<div class="accordion-heading">
				<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
					Suspect Entrants
				</a>
			</div>
			<div id="collapseOne" class="accordion-body collapse in">
				<div class="accordion-inner">
					
					<table class="table table-striped table-condensed table-bordered">
					
						<thead>
							<tr>
								<th>#</th>
								<th>Name</th>
								<th>Email</th>
								<th>Date</th>
								<th>Suspect Reasons</th>
							</tr>
						</thead>
						<tbody>
						
							<cfoutput query="suspectEntrantSelect">
								
								<tr>
									<td>#currentRow#</td>
									<td>#firstName# #lastName#</td>
									<td><a href="entrant_detail.cfm?entrantID=#entrantID#">#emailAddress#</a></td>
									<td>#dateFormat(insertDate, "mm/dd/yyyy")#</td>
									<td>#suspectReasons#</td>
								</tr>
								
							</cfoutput>
							
						</tbody>
						
					</table>
					
				</div>
			</div>
		</cfif>
		
		<cfif suspectEntryCount gt 0>
			<div class="accordion-heading">
				<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
					Suspect Entries
				</a>
			</div>
			<div id="collapseTwo" class="accordion-body collapse in">
				<div class="accordion-inner">
				
				</div>
			</div>
		</cfif>
		
		<cfif suspectTrafficCount gt 0>
			<div class="accordion-heading">
				<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
					Suspect Traffic
				</a>
			</div>
			<div id="collapseThree" class="accordion-body collapse in">
				<div class="accordion-inner">
					
					<table class="table table-striped table-condensed table-bordered">
					
						<thead>
							<tr>
								<th>#</th>
								<th>Template</th>
								<th>Entrant ID</th>
								<th>IP Address</th>
								<th>Browser</th>
								<th>Date</th>
								<th>Suspect Reasons</th>
							</tr>
						</thead>
						<tbody>
						
							<cfoutput query="suspectTrafficSelect">
								
								<tr>
									<td>#currentRow#</td>
									<td>#suspectTrafficSelect.template#</td>
									<td>
										<cfif len(entrantID)>
											<a href="entrant_detail.cfm?entrantID=#entrantID#">#entrantID#</a>
										</cfif>
									</td>
									<td>#IPAddress#</td>
									<td>#browserShort#</td>
									<td>#dateFormat(insertDate, "mm/dd/yyyy")#</td>
									<td>#suspectReasons#</td>
								</tr>
								
							</cfoutput>
							
						</tbody>
						
					</table>
					
				</div>
			</div>
		</cfif>
		
	</div>
</div>