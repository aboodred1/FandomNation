<cfset fsVideoFile = expandPath("#request.webRoot#videos/3D1A333B3F46C5B3998534830C1AAB64A19D9474.mov")>
<!--- <cfset fsVideoFile = "http://staging.mardenkane.com/barclaycard/FandomNation/videos/18B248ED93061D6D3A5E67019779B93EF3F4E920.mov"> --->

<cfexecute
   name="c:\ffmpeg\bin\ffplay.exe"
   arguments="#fsVideoFile#"
   timeout="60"
   variable="jsonInfo"
   errorVariable="errorOut" />

<cfdump var="#jsonInfo#">

<cfdump var="#errorOut#">