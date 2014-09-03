<!--- note: the gallery would be a good candidate for an angular app --->
<cfparam name="form.teamId" default="">
<cfparam name="form.challengeId" default="">
<cfparam name="form.friends_only" default=0>
<cfparam name="errorFields" default="">
<!--- teamddl is expecting these... --->

<!--- get random approved gallery entries --->
<cfif not structKeyExists(session, 'selectGallery') or cgi.request_method eq "POST">
<cfquery name="getEntries" datasource="#this.dsn#">
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
	from uvwSelectApprovedEntries
	where 0=0
	<cfif len(form.teamId)>
		and teamId = <cfqueryparam value="#form.teamId#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif len(form.challengeId)>
		and challengeId = <cfqueryparam value="#form.challengeId#" cfsqltype="cf_sql_integer">
	</cfif>
	<cfif form.friends_only eq 1 and structKeyExists(session.facebook, "friend_ids") and len(session.facebook['friend_ids'])>
		and user_id in (<cfqueryparam value="#session.facebook['friend_ids']#" list="yes" cfsqltype="cf_sql_varchar">)
	</cfif>
	order by newid()
</cfquery>
<cflock scope="session" timeout="4" throwontimeout="no">
	<cfset session.selectGallery = getEntries>
</cflock>
</cfif>

<div class="row">
	<div class="col-xs-12">
		<div class="page-title gallery"></div>
		<div class="header-copy">
			<form name="sortForm" method="post" action="<cfoutput>#request.webRoot#</cfoutput>gallery/" style="padding-bottom:20px;">
				<div class="row" style="padding:0 1em;text-align:left;">
					<div class="col-xs-4 col-sm-2" style="line-height:30px;padding:0;"><label>SORT BY:</label></div>
					<div class="col-xs-7 col-sm-4"><cfinclude template="../register/teamddl.cfm"></div>

					<div class="col-xs-7 col-xs-offset-4 col-sm-4 col-sm-offset-0"><cfinclude template="../register/challengeddl.cfm"></div>
					<div class="col-xs-12 col-sm-5" style="line-height:30px;padding:0;padding-top:10px;"><label>FACEBOOK FRIENDS ONLY</label> <input type="checkbox" name="friends_only" value="1" <cfif form.friends_only eq 1>checked="checked"</cfif>></div>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="gallery-wrapper">

<cfif session.selectGallery.recordCount>

	<cfset groups = ceiling(session.selectGallery.recordCount/12)>

	<cfloop from="1" to="#groups#" index="g">
		<div class="row" id="group-<cfoutput>#g#</cfoutput>" style="padding:0;<cfif g neq 1>display:none;</cfif>">
			<div class="col-xs-12" style="padding:0;">
				<cfloop from="1" to="12" index="i">
					<cfoutput>
						<cfif session.selectGallery.recordCount gte i+(12*(g-1))>
							<div class="gallery-image-frame" data-id="#session.selectGallery.entryKey[i+(12*(g-1))]#">

								<cfset backgroundImg = "">

								<!--- photo or video? --->
								<cfif len(session.selectGallery.videoUrl[i+(12*(g-1))])>
									<cfif left(session.selectGallery.thumbnail[i+(12*(g-1))], 4) eq "http">
										<cfset backgroundImg ="#session.selectGallery.thumbnail[i+(12*(g-1))]#">
									<cfelse>
										<cfset backgroundImg ="#request.webRoot#videos/#session.selectGallery.thumbnail[i+(12*(g-1))]#">
									</cfif>
								<cfelseif len(session.selectGallery.photoUrl[i+(12*(g-1))])>
									<cfif left(session.selectGallery.photoUrl[i+(12*(g-1))], 4) eq "http">
										<cfset backgroundImg ="#session.selectGallery.photoUrl[i+(12*(g-1))]#">
									<cfelse>
										<cfset backgroundImg ="#request.siteUrl#photos/#session.selectGallery.photoUrl[i+(12*(g-1))]#">
									</cfif>
								</cfif>

								<div class="gallery-image" style="background-image:url(#backgroundImg#);background-size:cover;-ms-behavior: url(#request.webRoot#scripts/backgroundsize.min.htc);">
									<cfif len(session.selectGallery.videoUrl[i+(12*(g-1))])>
										<div class="play-button"></div>
									</cfif>
									<div class="gallery-user-name">
										#session.selectGallery.firstName[i+(12*(g-1))]# #left(session.selectGallery.lastName[i+(12*(g-1))], 1)#.
									</div>
								</div>
							</div>
						</cfif>
					</cfoutput>
				</cfloop>
			</div>
		</div>
	</cfloop>

	<cfif groups gt 1>

		<div class="row">
			<div class="col-xs-12 text-center" style="padding:1em 0;">
				<a href="#" class="load-more"><!---
					 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/button-load-more.png">
				</a>
			</div>
		</div>

	</cfif>

	<!--- modals for entry detail --->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg"><!---  modal-vertical-centered --->
			<div class="modal-content">

			</div>
		</div>
	</div>

<cfelse>

	<div class="row">

		<div class="col-xs-12 text-center" style="padding:0;">

			<h1 class="serif">No approved entries match your criteria. Please check back later.</h1>

		</div>

	</div>

	<cfset groups = 1>

	<!--- <div class="row">

		<div class="col-xs-12 text-center" style="padding:0;">

			<div class="gallery-image-frame">
				<div class="gallery-image">
					<img src="<cfoutput>#request.siteUrl#</cfoutput>images/submission-placeholder-1.jpg">
					<div class="gallery-user-name">
						Meghan Y.
					</div>
				</div>
			</div>

			<div class="gallery-image-frame">
				<div class="gallery-image">
					<img src="<cfoutput>#request.siteUrl#</cfoutput>images/submission-placeholder-2.jpg">
					<div class="gallery-user-name">
						John S.
					</div>
				</div>
			</div>

			<div class="gallery-image-frame">
				<div class="gallery-image">
					<img src="<cfoutput>#request.siteUrl#</cfoutput>images/submission-placeholder-3.jpg">
					<div class="gallery-user-name">
						Ryan S.
					</div>
				</div>
			</div>

			<div class="gallery-image-frame">
				<div class="gallery-image">
					<img src="<cfoutput>#request.siteUrl#</cfoutput>images/submission-placeholder-4.jpg">
					<div class="gallery-user-name">
						Amy B.
					</div>
				</div>
			</div>

			<div class="gallery-image-frame">
				<div class="gallery-image">
					<img src="<cfoutput>#request.siteUrl#</cfoutput>images/submission-placeholder-5.jpg">
					<div class="gallery-user-name">
						Ashley R.
					</div>
				</div>
			</div>

			<div class="gallery-image-frame">
				<div class="gallery-image">
					<img src="<cfoutput>#request.siteUrl#</cfoutput>images/submission-placeholder-6.jpg">
					<div class="gallery-user-name">
						Scott J.
					</div>
				</div>
			</div>

			<div class="gallery-image-frame">
				<div class="gallery-image">
					<img src="<cfoutput>#request.siteUrl#</cfoutput>images/submission-placeholder-7.jpg">
					<div class="gallery-user-name">
						Andy P.
					</div>
				</div>
			</div>

		</div>

	</div> --->

</cfif>

</div>

<script>
	$(function(){

		$(document).on('mouseover', '.gallery-image-frame', function(){
			$(this).css({'background-image': 'url(<cfoutput>#request.webRoot#</cfoutput>images/gallery-image-background-active.png)', 'cursor': 'pointer'});
		});
		$(document).on('mouseout', '.gallery-image-frame', function(){
			$(this).css('background-image', 'url(<cfoutput>#request.webRoot#</cfoutput>images/gallery-image-background.png)');
		});

		$('input[name=teamId], select[name=challengeId], input[name=friends_only]').change(function(){
			$('form[name=sortForm]').submit();
		});

		$(document).on('click', '.gallery-image-frame', function(e){
			e.preventDefault();
			var entryKey = $(this).data('id');
			var scrollTop = $(window).scrollTop();
			var offset = $(this).offset().top;
			var distance = (offset - scrollTop);
			$('#myModal .modal-dialog .modal-content').empty();
			$.get('<cfoutput>#request.webRoot#</cfoutput>services/entry-detail.cfm?entryKey='+entryKey, function(data){
				$('#myModal .modal-dialog .modal-content').html(data);
				$('#myModal').modal();
				$('.modal-dialog').css({'margin-top': distance});
			});
		});

		var groupShowing = 1;
		var maxGroups = <cfoutput>#groups#</cfoutput>;

		$(document).on('click', '.load-more', function(e){
			e.preventDefault();
			groupShowing += 1;
			$('#group-'+ groupShowing).fadeIn('slow');
			if (groupShowing == maxGroups){
				$(this).hide();
			}
		});
	});
</script>