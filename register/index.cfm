<cfinclude template="form_defaults.cfm">

<cfif structKeyExists(form, "__token")>
	<cfinclude template="register-submit.cfm">
</cfif>

<div class="row">
	<div class="col-xs-12">
		<div class="page-title register">&nbsp;</div>
		<div class="header-copy">
			<p>Ready to prove your fanhood? Check out the Challenges tab and complete any, or all, challenges you want, capturing it with a photo or 15-second video. Upload your entry below and fill out the form.</p>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-xs-12" style="padding:0;">
		<div class="form-wrapper">
			<cfinclude template="register-form.cfm">
		</div>
	</div>
</div>

