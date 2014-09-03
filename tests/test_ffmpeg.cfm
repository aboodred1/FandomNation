
<h1>Get all videos with no thumbnails</h1>

<cfquery name="getVideos" datasource="#this.dsn#">
	select videoId, fileName
	from Videos
	<!--- where thumbnail is null --->
</cfquery>

<cfif getVideos.recordCount>

	<cfloop query="getVideos">

		<cfset init("Videos", "oVideos", "BaseComponents")>

		<p><cfoutput>Creating thumbnail for video #getVideos.fileName#</cfoutput></p>

		<cfset fsVideoFile = expandPath("#request.webRoot#videos\#getVideos.fileName#")>

		<cfset result = oVideos.createVideoThumbnail(videoFile=fsVideoFile)>
		<cfdump var="#result#">


		<!--- <p><cfoutput>#oVideos.createVideoThumbnail(videoFile=fsVideoFile)#</cfoutput></p>


		<p><cfoutput>#getDirectoryFromPath(fsVideoFile)#</cfoutput></p><cfabort>
		<cfset thumbnail_name = getToken(getVideos.fileName, 1, ".") & ".jpg">
		<cfset thumbnail_file = expandPath("#request.webRoot#videos\#thumbnail_name#")>

		<cfexecute
			name="c:\ffmpeg\bin\ffmpeg.exe"
			arguments="-i #fsVideoFile# -vcodec mjpeg -ss 00:00:02 -vframes 1 -an -f rawvideo -y #thumbnail_file#"
			timeout="60"
			variable="jsonInfo"
			errorVariable="errorOut" />



		<cfif fileExists(thumbnail_file)>
			<img src="<cfoutput>#request.webRoot#videos/#thumbnail_name#</cfoutput>">
			<cfquery datasource="#this.dsn#">
				update Videos
				set thumbnail = <cfqueryparam value="#thumbnail_name#" cfsqltype="cf_sql_varchar">
				where videoId = <cfqueryparam value="#getVideos.videoId#" cfsqltype="cf_sql_integer">
			</cfquery>
		<cfelse>
			<p>Error creating file</p>
		</cfif> --->

	</cfloop>

<cfelse>

	<p>No thumbnails to create</p>

</cfif>

<!--- <cfset fsVideoFile = expandPath("#request.webRoot#videos/02567D710E8A179D7CD407EF44B53C71FDEB2BC9.mov")> --->

<!--- <cfexecute
   name="c:\ffmpeg\bin\ffprobe.exe"
   arguments="#fsVideoFile# -v quiet -print_format json -show_format -show_streams"
   timeout="60"
   variable="jsonInfo"
   errorVariable="errorOut" />

<cfdump var="#jsonInfo#">
<cfdump var="#errorOut#"> --->


<!--- <cfexecute
   name="c:\ffmpeg\bin\ffmpeg.exe"
   arguments="-i #fsVideoFile#"
   timeout="60"
   variable="jsonInfo"
   errorVariable="errorOut" />

<cfdump var="#jsonInfo#">
<cfdump var="#errorOut#"> --->

<!--- http://www.frieswiththat.com.au/post.cfm/coldfusion-ffmpeg-video-conversion-plus-thumbnails --->

<!--- CALL C:\ffmpeg\ffmpeg -i %1 -vcodec mjpeg -ss %3 -vframes 1 -an -f rawvideo -s 130x72 -y %2
EXIT --->

<!--- <cfexecute
   name="c:\ffmpeg\bin\ffmpeg.exe"
   arguments="-i #fsVideoFile# -vcodec mjpeg -ss 00:00:02 -vframes 1 -an -f rawvideo -s 130x72 -y c:\ffmpeg\thumb.jpg"
   timeout="60"
   variable="jsonInfo"
   errorVariable="errorOut" /> --->

<!--- <cfdump var="#jsonInfo#"> --->
<!--- <cfdump var="#errorOut#"> --->
