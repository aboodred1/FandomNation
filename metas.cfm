<cfset og_url  = request.siteUrl>
<cfset og_title = this.title>
<cfset og_description = "I accepted an NFL Extra Points ##FandomNation challenge for a chance to win NFL prizes and tickets. Do you have what it takes to be the ultimate fan?">
<cfset og_image = "#request.siteUrl#images/NFL_FandomNation_ShareIcon.jpg">

<cfquery name="getEntryDetail" datasource="#this.dsn#">
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
	where entryKey = <cfqueryparam value="#url.key#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif getEntryDetail.recordCount>
	<cfset og_url  = request.siteUrl & "?key=#url.key#">
	<cfif len(getEntryDetail.photoUrl)>
		<cfif left(getEntryDetail.photoUrl, 4) eq 'http'>
			<cfset og_image = getEntryDetail.photoUrl>
		<cfelse>
			<cfset og_image = '#request.siteUrl#photos/#getEntryDetail.photoUrl#'>
		</cfif>
	<cfelseif len(getEntryDetail.thumbnail)>
		<cfif left(getEntryDetail.thumbnail, 4) eq "http">
			<cfset og_image = getEntryDetail.thumbnail>
		<cfelse>
			<cfset og_image = '#request.siteUrl#videos/#getEntryDetail.thumbnail#'>
		</cfif>
	</cfif>
</cfif>


<meta property="og:url" content="<cfoutput>#og_url#</cfoutput>">
<meta property="og:title" content="<cfoutput>#og_title#</cfoutput>">
<meta property="og:description" content="<cfoutput>#og_description#</cfoutput>">
<meta property="og:image" content="<cfoutput>#og_image#</cfoutput>">
