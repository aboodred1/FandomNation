<cfprocessingdirective suppressWhitespace="true">
<cfsetting enablecfoutputonly="true">
<cfparam name="url.entryKey" default="">
<cfif len(url.entryKey)>
	<cfquery name="getEntryDetail" datasource="#this.dsn#">
		select entrantId, firstName, lastName, city, state, emailAddress, entryId, entryKey, approved, entryDate, caption, photoUrl, videoUrl, thumbnail, challengeId, challengeName, teamId, teamName, user_id, profile_image_url
		from uvwSelectEntries
		where entryKey = <cfqueryparam value="#url.entryKey#" cfsqltype="cf_sql_varchar">
	</cfquery>
	<cfif getEntryDetail.recordCount>

	</cfif>
</cfif>
<!--- display form that will appear in a modal --->
<cfoutput query="getEntryDetail">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span>&times;</span></button>
		<h4 class="modal-title serif" id="myModalLabel">#challengeName# &rsaquo; #teamName#</h4>
	</div>
	<div class="modal-body clearfix">
		<div class="col-xs-12 col-sm-6" style="padding:0;">
			<div class="user-image-frame user-image-frame-sm">
				<div class="user-image user-image-sm">
					<cfif len(videoUrl)>
						<!--- <img src="#request.webRoot#videos/#thumbnail#"> --->
						<cfset thisVideoUrl = videoUrl>
						<cfif left(thisVideoUrl, 4) neq 'http'>
							<cfset thisVideoUrl = request.siteUrl & 'videos/' & thisVideoUrl>
						</cfif>
						<style type="text/css">
							.jwplayerwrapper{
								width:305px;
								height:229px;
								overflow:hidden;
								background:transparent;
								margin:2em auto;
							}

							##jwcontainer{
								width:100%;
								height:100%;
							}
						</style>

						<div class="jwplayerwrapper">
							<div id="jwcontainer">Loading the player &hellip;</div>
						</div>

						<script type="text/javascript">
							jwplayer("jwcontainer").setup({
								id: "jwplayer",
								width: 305,
								height: 229,
								screencolor: "eeeeee",
								backcolor: "eeeeee",
								image: "<cfif len(thumbnail)><cfif left(thumbnail, 4) eq 'http'>#thumbnail#<cfelse>#request.webRoot#videos/#thumbnail#</cfif></cfif>",
								autostart: false,
								stretching: "exactfit",
								levels: [
									{file: "#thisVideoUrl#"}
								],
								modes: [
									{type: "flash", src: "//promotions.mardenkane.com/common/mediaplayer/player.swf"},
									{type: "html5"},
									{type: "download"}
								],
								events: {
									onPlay: function(event){},
								    onComplete: function(event){},
								    onError: function(event){}
								}
							});
						</script>
					<cfelseif len(photoUrl)>
						<cfif left(photoUrl, 4) eq "http">
							<img src="#photoUrl#">
						<cfelse>
							<img src="#request.siteUrl#photos/#photoUrl#">
						</cfif>
					</cfif>
				</div>
			</div>
		</div>

		<div class="col-xs-12 col-sm-6" style="padding:0;">

			<div class="row hidden-xs">

				<cfif len(profile_image_url)>
					<div class="col-xs-2">
						<div class="facebook-profile-image">
							<img src="#profile_image_url#">
						</div>
					</div>
				</cfif>
				<div class="col-xs-10" style="padding-top:10px;">
					<div class="user-name">#HTMLEditFormat(firstName)#</div>
					<div class="user-place">#HTMLEditFormat(city)#, #state#</div>
				</div>

				<h1 class="user-caption" style="padding-top:130px;">#HTMLEditFormat(caption)#</h1>

			</div>

			<div class="row visible-xs">
				<div class="col-xs-8 col-xs-offset-2" style="padding-top:2em;">

					<cfif len(profile_image_url)>
						<div class="col-xs-12">
							<div class="facebook-profile-image">
								<img src="#profile_image_url#">
							</div>
						</div>
					</cfif>

					<div class="col-xs-12" style="padding-top:10px;">
						<div class="user-name">#HTMLEditFormat(firstName)#</div>
						<div class="user-place">#HTMLEditFormat(city)#, #state#</div>
					</div>

					<h1 class="user-caption" style="padding-top:100;">#HTMLEditFormat(caption)#</h1>

				</div>

			</div>

		</div>
	</div>
</form>
</cfoutput>
</cfprocessingdirective>