<cfprocessingdirective pageencoding="utf-8">
<cfquery name="getEntrants" datasource="#this.dsn#">
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
		convert(varchar, entryDate, 101) as entryDate,<!--- poi utility will output the date in an invalid format, otherwise (something like 898798.89797) --->
		caption,
		case substring(photoUrl, 1, 4)
			when 'http' then photoUrl
			else '#replace(request.siteUrl, "reporting/", "")#photos/' + photoUrl
		end as photoUrl,
		case substring(videoUrl, 1, 4)
			when 'http' then videoUrl
			else '#replace(request.siteUrl, "reporting/", "")#videos/' + videoUrl
		end as videoUrl,
		case substring(thumbnail, 1, 4)
			when 'http' then thumbnail
			else '#replace(request.siteUrl, "reporting/", "")#videos/' + thumbnail
		end as thumbnail,
		challengeId,
		challengeName,
		teamId,
		teamName,
		user_id,
		profile_image_url
	from uvwSelectEntries
	order by entryDate
</cfquery>

<div class="panel panel-default">

	<cfif getEntrants.recordCount>

		<div class="panel-heading">

			<h1>Building your file. Please be patient.</h1><cfflush>

			<cfset init("POIUtility","oReader","BaseComponents")>

			<cfset objSheet = oReader.GetNewSheetStruct()>
			<cfset objSheet.Query = getEntrants>
			<cfset objSheet.ColumnList = "entryDate,firstName,lastName,emailAddress,city,state,approved,caption,photoUrl,videoUrl,challengeName,teamName">
			<cfset objSheet.ColumnNames = "Entry Date,First Name,Last Name,Email Address,City,State,Approved,Caption,Photo,Video,Challenge,Team">
			<cfset objSheet.SheetName = "Entrants">

			<cfset strFileName = "barclaycard_fandomnation_entrants_#dateFormat(now(), 'mmddyyyy')#.xls">

			<cfif not directoryExists(expandPath('files'))>
				<cfdirectory action="create" directory="#expandPath('files')#">
			</cfif>

			<cfset oReader.WriteExcel(
										FilePath = expandPath('files\#strFileName#'),
										Sheets = objSheet,
										HeaderCSS = "font-weight:bold;"
									)>

			<p>Your file has been generated. Please right-click and select save-as.</p>
			<cfoutput><p><a href="files/#strFileName#">#strFileName#</a></p></cfoutput>

			<!--- insert them into Exported_Winners
			<cfloop query="getEntrants">
				<cfquery datasource="#this.dsn#">
					insert into Exported_Winners (entryID)
					values (<cfqueryparam value="#getEntrants.entryID#" cfsqltype="cf_sql_integer">)
				</cfquery>
			</cfloop> --->

		</div>

	<cfelse>

		<div class="panel-heading">
			<h1>No valid records were found. Please try your request again later.</h1>
		</div>

	</cfif>


	<!--- get existing files --->
	<cfdirectory action="list" directory="#expandPath('files')#" name="dirList"/>

	<cfif dirList.recordCount>

		<div class="panel-body">

			<h2>Existing Files:</h2>
			<cfoutput query="dirList">
				<cfif findNoCase("barclaycard_fandomnation", Name)>
					<p><a href="files/#Name#">#Name#</a></p>
				</cfif>
			</cfoutput>

		</div>

	</cfif>

</div>