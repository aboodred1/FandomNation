
<!--- placeholder --->

<div class="row">
	<div class="col-xs-12">
		<div class="page-title winners"></div>
		<div class="header-copy">
			<p class="text-center">CHECK BACK HERE ON OCTOBER 2ND TO SEE THE WINNERS!</p>
		</div>
	</div>
</div>
<div class="hidden-xs"><cfoutput>#showCards(which='winner-placeholder')#</cfoutput></div>
<div class="visible-xs"><cfoutput>#showCards(which='winner-placeholder', col_size='col-xs-12 text-center')#</cfoutput></div>


<!--- announced --->

<!--- <div class="row">
	<div class="col-xs-12">
		<div class="page-title">
			<img src="<cfoutput>#request.webRoot#</cfoutput>images/page-header-the-winners.png">
		</div>
		<div style="padding:1em;margin-top:-1.5em;">

			<p>CONGRATULATIONS TO THE ULTIMATE FANS OF THE NFL EXTRA POINTS #FANDOMNATION</p>

		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12 text-center" style="padding:0;">
		<cfloop from="1" to="7" index="i">
			<div class="winner-card-frame">
				<div class="winner-card-header">
					<img src="<cfoutput>#request.webRoot#</cfoutput>images/winner-card-title-<cfoutput>#i#</cfoutput>.jpg">
				</div>
				<div class="winner-card-body" style="background:transparent url(<cfoutput>#request.webRoot#images/winner-image-sample-#i#.jpg</cfoutput>) center center no-repeat;background-size:cover;">&nbsp;</div>
				<div class="winner-card-footer">
					<div class="winner-info">
						<span class="winner-name">RYAN S.</span>
						<span class="winner-place">New York, NY</span>
					</div>
					<div class="winner-challenge">Show us what pose is on your rookie trading card</div>
				</div>
			</div>
		</cfloop>
	</div>
</div> --->