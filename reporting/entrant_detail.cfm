<cfif session.accessLevel eq "Client">
	<cflocation url="reports.cfm" addtoken="no">
</cfif>

<cfparam name="entrantID" default="">

<cfif not len(trim(entrantID)) or not isNumeric(entrantID)>
	<cflocation url="lookup.cfm" addtoken="no">
</cfif>

<cfset entrantID = val(int(abs(entrantID)))>

<cfset init("Reports","oReports","BaseComponents")>
<cfset init("Entrants","oEntrants","BaseComponents")>


<cfset entrantDetail = oEntrants.getEntrantDetails(entrantID)>

<cfif entrantDetail.recordCount eq 0>
	<cflocation url="lookup.cfm" addtoken="no">
</cfif>

<cfquery name="entryHistory" datasource="#this.dsn#">
	select
		entrantId,
		firstName,
		lastName,
		city,
		state,
		emailAddress,
		entryId,
		entryKey,
		approved,
		entryDate,
		caption,
		photoUrl,
		videoUrl,
		thumbnail,
		challengeId,
		challengeName,
		teamId,
		teamName,
		user_id,
		profile_image_url
	from uvwSelectEntries
	where entrantId = <cfqueryparam value="#entrantID#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput query="entrantDetail">

	<div class="panel panel-default">

		<div class="panel-heading">
			<h1>
				Entrant Detail
			</h1>
		</div>

		<div class="panel-body">

			<div class="col-xs-12">

				<address>
					<p class="lead">
						First entry: #dateFormat(insertDate, 'mm/dd/yyyy')# #timeformat(insertDate, 'hh:mm TT')# #application.tzid#<br>
					</p>
					<strong>#HTMLEditFormat(firstName)# #HTMLEditFormat(lastName)#</strong><br>
					#HTMLEditFormat(city)# #HTMLEditFormat(state)#
					<a href="mailto:#HTMLEditFormat(emailAddress)#">#HTMLEditFormat(emailAddress)#</a>
				</address>

				<legend>Entry History</legend>

				<table class="table table-striped table-condensed table-bordered">

					<thead>

						<tr>
							<th>##</th>
							<th>Entry Date</th>
							<th>Challenge</th>
							<th>Team</th>
							<th>Caption</th>
							<th>Photo/Video</th>
							<th>Approved</th>
						</tr>

					</thead>

					<tbody>

						<cfset lc = 1>

						<cfloop query="entryHistory">

							<tr>
								<td>#lc#</td>
								<td>#dateFormat(entryHistory.entryDate, "mm/dd/yyyy")#</td>
								<td>#entryHistory.challengeName#</td>
								<td>#entryHistory.teamName#</td>
								<td>#HTMLEditformat(entryHistory.caption)#</td>
								<td>
									<cfif len(entryHistory.photoUrl)>
										<cfif left(entryHistory.photoUrl, 4) eq "http">
											<a href="#entryHistory.photoUrl#" title="click to view full size" target="_blank"><!---
												 ---><img src="#entryHistory.photoUrl#" style="width:100px;">
											</a>
										<cfelse>
											<a href="../photos/#entryHistory.photoUrl#" title="click to view full size" target="_blank"><!---
												 ---><img src="../photos/#entryHistory.photoUrl#" style="width:100px;">
											</a>
										</cfif>
									<cfelseif len(entryHistory.videoUrl)>
										<a href="##" data-id="#entryHistory.entryKey#" class="show-detail" title="click to view the video"><!---
											 ---><img src="../videos/#entryHistory.thumbnail#" style="width:100px;">
										</a>
									</cfif>
								</td>
								<td>
									<cfif len(entryHistory.approved)>
										#yesNoFormat(entryHistory.approved)#
									<cfelse>
										Pending
									</cfif>
								</td>
							</tr>

							<cfset lc += 1>

						</cfloop>

					</tbody>

				</table>

			</div>

		</div>

	</div>

</cfoutput>

<!--- modals for entry detail --->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-vertical-centered">
		<div class="modal-content">

		</div>
	</div>
</div>

<script>
	$(function(){
		$(document).on('click', '.show-detail', function(e){
			e.preventDefault();
			var entryKey = $(this).data('id');
			$('#myModal .modal-dialog .modal-content').empty();
			$.get('../services/entry-detail.cfm?entryKey='+entryKey, function(data){
				$('#myModal .modal-dialog .modal-content').html(data);
				$('#myModal').modal();
			});
		});
	});
</script>