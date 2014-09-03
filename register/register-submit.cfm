<!--- checking for suspicious activity or attempts to directly access the action page --->
<cfif form.__token neq session.stamp>
	<cflock scope="session" timeout="4" throwontimeout="no">
		<cfset session.suspect = true>
		<cfif not listFindNoCase(arrayToList(session.suspectReasons), 'csrf')>
			<cfset arrayAppend(session.suspectReasons, 'csrf')>
		</cfif>
	</cflock>
</cfif>
<cfif compareNoCase(right(cgi.script_name, 9), "index.cfm") neq 0>
	<cflock scope="session" timeout="4" throwontimeout="no">
		<cfset session.suspect = true>
		<cfif not listFindNoCase(arrayToList(session.suspectReasons), 'direct access')>
			<cfset arrayAppend(session.suspectReasons, 'direct access')>
		</cfif>
	</cflock>
</cfif>
<cfif not len(cgi.http_referer)>
	<cflock scope="session" timeout="4" throwontimeout="no">
		<cfset session.suspect = true>
		<cfif not listFindNoCase(arrayToList(session.suspectReasons), 'blank referer')>
			<cfset arrayAppend(session.suspectReasons, 'blank referer')>
		</cfif>
	</cflock>
</cfif>
<cfif len(cgi.http_referer) and not findNoCase(cgi.server_name, cgi.http_referer)>
	<cflock scope="session" timeout="4" throwontimeout="no">
		<cfset session.suspect = true>
		<cfif not listFindNoCase(arrayToList(session.suspectReasons), 'external referer')>
			<cfset arrayAppend(session.suspectReasons, 'external referer')>
		</cfif>
	</cflock>
</cfif>
<cfif oHelpers.isClientIPInBlackList()>
	<cflock scope="session" timeout="4" throwontimeout="no">
		<cfset session.suspect = true>
		<cfif not listFindNoCase(arrayToList(session.suspectReasons), 'blacklisted ip address')>
			<cfset arrayAppend(session.suspectReasons, 'blacklisted ip address')>
		</cfif>
	</cflock>
</cfif>
<cfif cgi.request_method neq "POST">
	<cflock scope="session" timeout="4" throwontimeout="no">
		<cfset session.suspect = true>
		<cfif not listFindNoCase(arrayToList(session.suspectReasons), 'GET attempt on form action page')>
			<cfset arrayAppend(session.suspectReasons, 'GET attempt on form action page')>
		</cfif>
	</cflock>
</cfif>
<cfif not len(oHelpers.getClientIP())>
	<cflock scope="session" timeout="4" throwontimeout="no">
		<cfset session.suspect = true>
		<cfif not listFindNoCase(arrayToList(session.suspectReasons), 'blank IP address')>
			<cfset arrayAppend(session.suspectReasons, 'blank IP address')>
		</cfif>
	</cflock>
<cfelse>
	<!--- this only tests for ipv4 addresses, though --->
	<cfif REFindNoCase("^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", oHelpers.getClientIP()) neq 1>
		<cflock scope="session" timeout="4" throwontimeout="no">
			<cfset session.suspect = true>
			<cfif not listFindNoCase(arrayToList(session.suspectReasons), 'malformed IP address')>
				<cfset arrayAppend(session.suspectReasons, 'malformed IP address')>
			</cfif>
		</cflock>
	</cfif>
</cfif>
<!--- <cfif session.suspect>
	<!--- flag the entrant/entry --->
	<!--- log the activity --->
	<!--- forward to success page with no indication that somethings awry --->
	<cflocation url="#request.webRoot#success/" addtoken="no">
	<cfset onRequestEnd(cgi.script_name)>
	<cfabort>
</cfif> --->

<!--- <p>validating form fields for content, format</p> --->
<cfif not len(form.fileUpload) and not len(form.facebook_photo) and not len(form.facebook_video)>
	<cfset errorFields = listAppend(errorFields, "fileUpload")>
</cfif>

<cfif not len(form.caption)>
	<cfset errorFields = listAppend(errorFields, "caption")>
</cfif>

<cfif not len(form.firstName)>
	<cfset errorFields = listAppend(errorFields, "firstName")>
</cfif>

<cfif not len(form.lastName)>
    <cfset errorFields = listAppend(errorFields, "lastName")>
</cfif>

<cfif not isValid("email", form.emailAddress)>
	<cfset errorFields = listAppend(errorFields, "emailAddress")>
</cfif>

<cfif not len(form.challengeId)>
	<cfset errorFields = listAppend(errorFields, "challengeId")>
</cfif>

<cfif not len(form.city)>
    <cfset errorFields = listAppend(errorFields, "city")>
</cfif>

<cfif not len(form.state)>
    <cfset errorFields = listAppend(errorFields, "state")>
</cfif>

<cfif not len(form.teamId)>
	<cfset errorFields = listAppend(errorFields, "teamId")>
</cfif>

<cfif form.agree_to_rules eq 0>
	<cfset errorFields = listAppend(errorFields, "agree_to_rules")>
</cfif>


<cfif not len(errorFields)>

	<cfset uploadSuccess = false>

	<cftry>

		<cftransaction>

			<cfif not len(session.entrantId)>

				<!--- check for entrant --->
				<cfquery name="checkForEntrant" datasource="#this.dsn#">
					select entrantId
					from Entrants
					where emailAddress = <cfqueryparam value="#form.emailAddress#" cfsqltype="cf_sql_varchar">
					or (
						firstName = <cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">
						and lastName = <cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_varchar">
						and city = <cfqueryparam value="#form.city#" cfsqltype="cf_sql_varchar">
						and [state] =  <cfqueryparam value="#form.state#" cfsqltype="cf_sql_varchar">
					)
				</cfquery>

				<cfif checkForEntrant.recordCount>
					<cflock scope="session" timeout="4" throwontimeout="no">
						<cfset session.entrantId = checkForEntrant.entrantId>
					</cflock>
				<cfelse>
					<!--- insert entrant --->
					<cfquery name="entrantInsert" datasource="#this.dsn#">
						insert into Entrants (
							stamp,
							firstName,
							lastName,
							city,
							[state],
							emailAddress,
							suspect,
							suspectReasons,
							IPAddress,
							browser,
							browserShort
						)
						values (
							<cfqueryparam value="#session.stamp#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.firstName#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.lastName#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.city#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.state#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#form.emailAddress#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#session.suspect#" cfsqltype="cf_sql_bit">,
							<cfqueryparam value="#arrayToList(session.suspectReasons)#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#oHelpers.getClientIP()#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#left(trim(cgi.http_user_agent), 1000)#" cfsqltype="cf_sql_varchar">,
							<cfqueryparam value="#browserShort#" cfsqltype="cf_sql_varchar">
						)

						select entrantId = scope_identity()
					</cfquery>
					<cflock scope="session" timeout="4" throwontimeout="no">
						<cfset session.entrantId = entrantInsert.entrantId>
					</cflock>
				</cfif>

				<!--- link up to facebook user if plausible --->
				<cfif session.facebook_connected and structKeyExists(session, 'facebook')>
					<cfquery datasource="#this.dsn#">
						update FacebookUsers
						set entrantId = <cfqueryparam value="#session.entrantId#" cfsqltype="cf_sql_integer">
						where user_id = <cfqueryparam value="#session.facebook['user_id']#" cfsqltype="cf_sql_varchar">
						and entrantId is null
					</cfquery>
				</cfif>

			</cfif><!--- check for session.entrantId --->

		</cftransaction>

		<cftransaction>

			<!--- check for entry in this challenge from this entrant --->
			<cfquery name="checkForEntry" datasource="#this.dsn#">
				select 1
				from Entries
				where entrantId = <cfqueryparam value="#session.entrantId#" cfsqltype="cf_sql_integer">
				and challengeId = <cfqueryparam value="#form.challengeId#" cfsqltype="cf_sql_integer">
			</cfquery>

			<cfif checkforEntry.recordCount>

				<cfset errorFields = listAppend(errorFields, "alreadyEntered")>

			<cfelse>

				<cfif len(form.fileUpload)>

					<!--- try upload photo or video --->
					<cfset init("Photos","oPhotos","BaseComponents")>
					<cfset uploadResult = oPhotos.uploadPhotoSimplified (
						photoFile = "form.fileUpload",
						localDirectory = expandPath("#request.webRoot#photos"),
						acceptedFileTypeList = "image/gif,image/jpeg,image/pjpeg,image/jpg,image/jpe,image/png",
						acceptedFileExtensionList = "gif,jpg,jpeg,jpe,png",
						maxFileSize = 1024*1024*10
					)>

					<cfif uploadResult.success>

						<!--- insert photo --->
						<cfset photoId = oPhotos.insertPhoto (
							entrantId = session.entrantId,
							stamp = session.stamp,
							originalFileName = uploadResult.originalFileName,
							fileName = uploadResult.fileName,
							fileSize = uploadResult.fileSize,
							fileType = uploadResult.fileType,
							IPAddress = oHelpers.getClientIP(),
							browser = left(trim(cgi.http_user_agent), 1000),
							browserShort = browserShort
						)>

						<cflock scope="session" timeout="4" throwontimeout="no">
							<cfset session.photoId = photoId>
						</cflock>

						<cfset uploadSuccess = true>

					<cfelse>

						<cfset init("Videos","oVideos","BaseComponents")>
						<cfset uploadResult = oVideos.uploadVideoSimplified (
							videoFile = "form.fileUpload",
							localDirectory = expandPath("#request.webRoot#videos"),
							acceptedFileTypeList = "video/mp4,video/mpeg,video/quicktime,video/x-msvideo,video/x-ms-wmv,application/octet-stream",
							acceptedFileExtensionList = "mp4,mpeg,mpg,mov,qt,avi,wmv,flv",
							maxFileSize = 1024*1024*50
						)>

						<cfif uploadResult.success>

							<cfset videoFile = expandPath('#request.webRoot#videos\#uploadResult.fileName#')>
							<cfset newFileName = uploadResult.fileName>

							<!--- convert the video to mp4 and flv formats (i should probably move this to a scheduled task...) --->
							<cfif right(videoFile, 3) neq 'mp4'>
								<cfset result = oVideos.convertVideo(videoFile=videoFile, toFormat='mp4')>
								<cfif result.success>
									<cfset newFileName = getToken(newFileName, 1, '.') & '.mp4'>
								</cfif>
							</cfif>

							<cfif right(videoFile, 3) neq 'flv'>
								<cfset result = oVideos.convertVideo(videoFile=videoFile, toFormat='flv')>
								<cfif result.success>
									<cfset newFileName = getToken(newFileName, 1, '.') & '.flv'>
								</cfif>
							</cfif>

							<!--- insert video --->
							<cfset videoId = oVideos.insertVideo (
								entrantId = session.entrantId,
								stamp = session.stamp,
								originalFileName = uploadResult.originalFileName,
								fileName = newFileName,
								fileSize = uploadResult.fileSize,
								fileType = uploadResult.fileType,
								IPAddress = oHelpers.getClientIP(),
								browser = left(trim(cgi.http_user_agent), 1000),
								browserShort = browserShort
							)>

							<!--- try create thumbnail --->
							<cfset thumbnailResult = oVideos.createVideoThumbnail(expandPath('#request.webRoot#videos\#uploadResult.fileName#'))>

							<cfif thumbnailResult.success>
								<cfquery datasource="#this.dsn#">
									update Videos
									set thumbnail = <cfqueryparam value="#thumbnailResult.thumbnailFileName#" cfsqltype="cf_sql_varchar">
									where videoId = <cfqueryparam value="#videoId#" cfsqltype="cf_sql_integer">
								</cfquery>
							</cfif>

							<cflock scope="session" timeout="4" throwontimeout="no">
								<cfset session.videoId = videoId>
							</cflock>

							<cfset uploadSuccess = true>

						<cfelse>

							<cfset errorFields = listAppend(errorFields, "fileUpload")>

						</cfif>

					</cfif>

				<cfelse>

					<cfif len(form.facebook_photo)>

						<!--- facebook photo --->
						<cfquery name="insertPhoto" datasource="#this.dsn#">
							insert into Photos (
								entrantId,
								stamp,
								photoUrl,
								suspect,
								suspectReasons,
								IPAddress,
								browser,
								browserShort
							)
							values (
								<cfqueryparam value="#session.entrantId#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#session.stamp#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#form.facebook_photo#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#session.suspect#" cfsqltype="cf_sql_bit">,
								<cfqueryparam value="#arrayToList(session.suspectReasons)#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#oHelpers.getClientIP()#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#left(trim(cgi.http_user_agent), 1000)#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#browserShort#" cfsqltype="cf_sql_varchar">
							)

							select photoId = scope_identity()
						</cfquery>

						<cflock scope="session" timeout="4" throwontimeout="no">
							<cfset session.photoId = insertPhoto.photoId>
						</cflock>

						<cfset uploadSuccess = true>

					<cfelseif len(form.facebook_video)>

						<!--- facebook video --->
						<cfquery name="insertVideo" datasource="#this.dsn#">
							insert into Videos (
								entrantId,
								stamp,
								videoUrl,
								thumbnail,
								suspect,
								suspectReasons,
								IPAddress,
								browser,
								browserShort
							)
							values (
								<cfqueryparam value="#session.entrantId#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#session.stamp#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#form.facebook_video#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#form.facebook_video_thumbnail#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#session.suspect#" cfsqltype="cf_sql_bit">,
								<cfqueryparam value="#arrayToList(session.suspectReasons)#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#oHelpers.getClientIP()#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#left(trim(cgi.http_user_agent), 1000)#" cfsqltype="cf_sql_varchar">,
								<cfqueryparam value="#browserShort#" cfsqltype="cf_sql_varchar">
							)

							select videoId = scope_identity()
						</cfquery>

						<cflock scope="session" timeout="4" throwontimeout="no">
							<cfset session.videoId = insertVideo.videoId>
						</cflock>

						<cfset uploadSuccess = true>

					</cfif>

				</cfif>

			</cfif>

		</cftransaction>

		<cfif not listFind(errorFields, "alreadyEntered") and uploadSuccess>

			<cftransaction>

				<!--- finalize their entry --->
				<cfquery name="insertEntry" datasource="#this.dsn#">
					insert into Entries (
						entrantId,
						stamp,
						teamId,
						challengeId,
						caption,
						photoId,
						videoId,
						share_on_timeline,
						suspect,
						suspectReasons,
						IPAddress,
						browser,
						browserShort
					)
					values (
						<cfqueryparam value="#session.entrantId#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#session.stamp#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#form.teamId#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#form.challengeId#" cfsqltype="cf_sql_integer">,
						<cfqueryparam value="#form.caption#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#session.photoId#" null="#not len(session.photoId)#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#session.videoId#" null="#not len(session.videoId)#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#form.share_on_timeline#" cfsqltype="cf_sql_bit">,
						<cfqueryparam value="#session.suspect#" cfsqltype="cf_sql_bit">,
						<cfqueryparam value="#arrayToList(session.suspectReasons)#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#oHelpers.getClientIP()#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#left(trim(cgi.http_user_agent), 1000)#" cfsqltype="cf_sql_varchar">,
						<cfqueryparam value="#browserShort#" cfsqltype="cf_sql_varchar">
					)

					select entryId = scope_identity()
				</cfquery>

				<!--- link back to photo or video --->
				<cfif len(session.photoId)>
					<cfquery datasource="#this.dsn#">
						if exists (
							select 1
							from Photos
							where photoId = <cfqueryparam value="#session.photoId#" cfsqltype="cf_sql_integer">
						)
						begin
							update Photos
							set entryId = <cfqueryparam value="#insertEntry.entryId#" cfsqltype="cf_sql_integer">
							where photoId = <cfqueryparam value="#session.photoId#" cfsqltype="cf_sql_integer">
						end
					</cfquery>
				</cfif>
				<cfif len(session.videoId)>
					<cfquery datasource="#this.dsn#">
						if exists (
							select 1
							from Videos
							where videoId = <cfqueryparam value="#session.videoId#" cfsqltype="cf_sql_integer">
						)
						begin
							update Videos
							set entryId = <cfqueryparam value="#insertEntry.entryId#" cfsqltype="cf_sql_integer">
							where videoId = <cfqueryparam value="#session.videoId#" cfsqltype="cf_sql_integer">
						end
					</cfquery>
				</cfif>

				<cfquery name="getEntryKey" datasource="#this.dsn#">
					select top 1 entryKey
					from Entries
					where entrantId = <cfqueryparam value="#session.entrantId#" cfsqltype="cf_sql_integer">
					and stamp = <cfqueryparam value="#session.stamp#" cfsqltype="cf_sql_varchar">
					order by insertDate desc
				</cfquery>

				<cflock scope="session" timeout="4" throwontimeout="no">
					<cfset session.entryKey = getEntryKey.entryKey>
				</cflock>

			</cftransaction>

			<cfif form.share_on_timeline eq 1>
				<!--- <cfif structKeyExists(session, 'facebook') and structKeyExists(session.facebook, 'accessToken') and len(session.facebook['accessToken'])>
					<!--- id rather us the js sdk for this, but keep this here for now cause it works --->
					<cfhttp url="https://graph.facebook.com/#session.facebook.user_id#/feed" method="post" charset="utf-8">
						<cfhttpparam type="formfield" name="access_token" value="#session.facebook.accessToken#">
						<cfhttpparam type="formfield" name="message" value="I accepted an NFL Extra Points ##FandomNation challenge for a chance to win NFL prizes and tickets. Do you have what it takes to be the ultimate fan?">
					</cfhttp>
					<!--- <cfset postResult = deserializeJson(cfhttp.fileContent)> --->
					<!--- not sure if we care right now if the post is successful or not --->
				</cfif> --->
				<cflock scope="session" timeout="4" throwontimeout="no">
					<cfset session.share_on_timeline = 1>
				</cflock>
			</cfif>

		<cfelseif not uploadSuccess>

			<cfset errorFields = listAppend(errorFields, "fileUpload")>

		</cfif>

		<cfcatch type="any">

			<!--- clear session entry data --->
			<cflock scope="session" timeout="4" throwontimeout="no">
				<cfset session.entryKey = ''>
				<cfset session.videoId = ''>
				<cfset session.photoId = ''>
			</cflock>

			<div class="alert alert-danger">
				<h4>Error!</h4>
				<p>I'm sorry, but something has gone terribly awry.</p>
				<p>A system administrator has been notified. Please try your request again later.</p>
			</div>

			<cfif this.debugMode>
				<div class="alert alert-warning">
					<cfoutput>#handleErrors(cfcatch, true)#</cfoutput>
				</div>
			</cfif>
			<cfset onError(cfcatch)>
			<!--- <cfset onRequestEnd(cgi.script_name)> --->
			<cfabort>

		</cfcatch>

	</cftry>

</cfif>

<!--- check again! --->
<cfif len(errorFields)>

	<cfif listFindNoCase(errorFields, "alreadyEntered")>
		<cflocation url="#request.webRoot#register/already-entered/" addtoken="no">
	</cfif>

	<script>
		$(function(){
			<cfif listFindNoCase(errorFields, "alreadyEntered")>
				$('.already-entered').show();
				//$('.form-error').not('.already-entered').hide();
			</cfif>
			<cfif listFindNoCase(errorFields, "photoUploadFailed")>
				$('.upload-failed').show();
				//$('.form-error').not('.upload-failed').hide();
			</cfif>
			<cfif listFindNoCase(errorFields, "wordCount")>
				$('.story-len').show();
				//$('.form-error').not('.story-len').hide();
			</cfif>
			$('.form-errors').fadeIn('slow');
		});
	</script>

<cfelse>

	<cflocation url="#request.webRoot#register/success/?key=#session.entryKey#" addtoken="no">

	<cfset onRequestEnd(cgi.script_name)>

</cfif>