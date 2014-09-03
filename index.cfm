<!--- <cfinclude template="/Common/detectmobile.cfm"> --->

<div class="row">
	<div class="col-xs-12 home-wrapper">
		<div class="page-title home">&nbsp;</div>
		<div class="header-copy">
			<p>Welcome to the NFL Extra Points <strong>#FandomNation</strong>.  Where fan love and loyalty has its rewards.<br>
			<strong>Are you the ultimate fan?</strong> Show us what you've got for a chance to win great NFL prizes and tickets!<br>
			Every challenge has a winner. Contest closes September 7th.</p>
		</div>
		<div class="row hidden-xs">
			<div class="col-xs-8">
				<img src="<cfoutput>#request.webRoot#</cfoutput>images/text-the-challenges.png" style="margin:2em 0;">

				<!--- <img src="<cfoutput>#request.webRoot#</cfoutput>images/text-may-the-ultimate-fans-win.png"> --->
				<ul style="padding:0 0 0 1.125em;">
					<li style="font-size:1.125em;">Perform and enter any, or all, challenges<br>(One entry per challenge)</li>
					<li style="font-size:1.125em;">Take a photo or video of your challenge</li>
					<li style="font-size:1.125em;">Upload your photo or video in the Enter tab above</li>
				</ul>

				<p class="serif-bold">The better your performance, the more likely you are to win!</p>
			</div>


			<!--- <div class="row">
				<div class="col-xs-2"></div>
				<cfloop from="1" to="2" index="i">
					<div class="col-xs-4" style="padding:0;">
						<a href="<cfoutput>#request.webRoot#register/?challengeId=#Application.Challenges.challengeId[i]#</cfoutput>"><!---
						 ---><img src="<cfoutput>#request.webRoot#images/#Application.Challenges.challengeCardImage[i]#</cfoutput>">
						</a>
					</div>
				</cfloop>
				<div class="col-xs-2"></div>
			</div>

			<div class="row">
				<cfloop from="3" to="5" index="i">
					<div class="col-xs-4" style="padding:0;">
						<a href="<cfoutput>#request.webRoot#register/?challengeId=#Application.Challenges.challengeId[i]#</cfoutput>"><!---
						 ---><img src="<cfoutput>#request.webRoot#images/#Application.Challenges.challengeCardImage[i]#</cfoutput>">
						</a>
					</div>
				</cfloop>
			</div>

			<div class="row">
				<div class="col-xs-2"></div>
				<cfloop from="6" to="7" index="i">
					<div class="col-xs-4" style="padding:0;">
						<a href="<cfoutput>#request.webRoot#register/?challengeId=#Application.Challenges.challengeId[i]#</cfoutput>"><!---
						 ---><img src="<cfoutput>#request.webRoot#images/#Application.Challenges.challengeCardImage[i]#</cfoutput>">
						</a>
					</div>
				</cfloop>
				<div class="col-xs-2"></div>
			</div> --->
			<cfoutput>#showCards()#</cfoutput>

		</div>

		<div class="row visible-xs">
			<div class="col-xs-12 text-center">
				<div style="height:1em;">&nbsp;</div>
				<hr style="color:black;background-color:black;height:1px;width:80%;">
				<div style="height:1em;">&nbsp;</div>
				<img src="<cfoutput>#request.webRoot#</cfoutput>images/text-the-challenges-sm.png">
			</div>
			<div class="col-xs-10 col-xs-offset-1">
				<ul style="padding:2em 0 0 1.125em;">
					<li style="margin-bottom:1em;">Perform and enter any, or all, challenges<br>(One entry per challenge)</li>
					<li style="margin-bottom:1em;">Take a photo or video of your challenge</li>
					<li style="margin-bottom:1em;">Upload your photo or video in the Enter tab above</li>
				</ul>
			</div>
			<div class="col-xs-10 col-xs-offset-1 text-center">
				<p style="font-size:1.125em;"><strong>The better your performance,<br>the more likely you are to win!</strong></p>
			</div>
			<cfoutput>#showCards(which='challenge', col_size='col-xs-12 text-center')#</cfoutput>
		</div>

	</div>
</div>

<!--- <cfif mobile_device eq "no"> --->
<cfif not oHelpers.isMobileBrowser() and not this.debugMode><!---  and not oHelpers.isStagingServer() --->
  <script type="text/javascript">
    if(window == window.top){
      window.location = "https://www.facebook.com/NFLextrapoints/app_613897718731717";
    }
    </script>
</cfif>



