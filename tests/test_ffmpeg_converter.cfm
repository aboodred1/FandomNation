<!--- get all video files --->
<cfset videoDirectory = expandPath('../videos')>
<cfdirectory action="list" directory="#videoDirectory#" name="videoList" filter="*.wmv|*.mov|*.mpeg|*.mpg|*.qt|*.avi|*.mp4|*.flv">
<cfif videoList.recordCount>
	<cfset init("Videos", "oVideos", "BaseComponents")>
	<cfloop query="videoList">
		<cfset fileName = getToken(videoList.name, 1, '.')>
		<!--- check for mp4 version --->
		<cfif not fileExists('#videoDirectory#\#fileName#.mp4')>
			<!--- try convert video --->
			<p><cfoutput>convert #fileName# to MP4</cfoutput></p>
			<!--- <cfexecute
				name="c:\ffmpeg\bin\ffmpeg.exe"
				arguments="-i #videoDirectory#\#videoList.name# -vcodec h264 -acodec aac -strict -2 #videoDirectory#\#fileName#.mp4"
				timeout="60"
				variable="jsonInfo"
				errorVariable="errorOut" />
			<div><cfdump var="#jsonInfo#" label="jsonInfo"></div>
			<div><cfdump var="#errorOut#" label="errorOut"></div> --->
			<cfset result = oVideos.convertVideo(videoFile='#videoDirectory#\#videoList.name#', toFormat='mp4')>
			<cfdump var="#result#">
		</cfif>
		<cfif not fileExists('#videoDirectory#\#fileName#.flv')>
			<!--- try convert video --->
			<p><cfoutput>convert #fileName# to FLV</cfoutput></p>
			<!--- <cfexecute
				name="c:\ffmpeg\bin\ffmpeg.exe"
				arguments="-i #videoDirectory#\#videoList.name# -c:v libx264 -ar 22050 -crf 28 #videoDirectory#\#fileName#.flv"
				timeout="60"
				variable="jsonInfo"
				errorVariable="errorOut" />
			<div><cfdump var="#jsonInfo#" label="jsonInfo"></div>
			<div><cfdump var="#errorOut#" label="errorOut"></div> --->
			<cfset result = oVideos.convertVideo(videoFile='#videoDirectory#\#videoList.name#', toFormat='flv')>
			<cfdump var="#result#">
		</cfif>
	</cfloop>
</cfif>