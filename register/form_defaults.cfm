<!--- form_defaults.cfm --->
<cfparam name="formDefaultsIncluded" default=false>

<!--- include_once --->
<cfif not formDefaultsIncluded>

	<!--- may be passed here from home page --->
	<cfparam name="url.challengeId" default="">

	<cfif session.facebook_connected and structKeyExists(session, 'facebook')>
		<cfparam name="form.emailAddress" default="#session.facebook['email']#">
		<cfparam name="form.firstName" default="#session.facebook['first']#">
	    <cfparam name="form.lastName" default="#session.facebook['last']#">
	<cfelse>
		<cfparam name="form.emailAddress" default="">
		<cfparam name="form.firstName" default="">
	    <cfparam name="form.lastName" default="">
	</cfif>

	<cfparam name="form.address1" default="">
	<cfparam name="form.address2" default="">
	<cfparam name="form.city" default="">
	<cfparam name="form.state" default="">
    <cfparam name="form.zipCode" default="">

	<cfparam name="form.phone_ac" default="">
    <cfparam name="form.phone_pre" default="">
    <cfparam name="form.phone_suf" default="">
    <cfparam name="form.phoneNumber" default="#form.phone_ac##form.phone_pre##form.phone_suf#">

	<cfparam name="form.caption" default="">
	<cfparam name="form.fileUpload" default="">
	<cfparam name="form.facebook_photo" default="">
	<cfparam name="form.facebook_video" default="">
	<cfparam name="form.facebook_video_thumbnail" default="">
	<cfparam name="form.teamId" default="">
	<cfparam name="form.challengeId" default="#url.challengeId#">

	<cfparam name="form.optIn_Email" default=0>
    <cfparam name="form.agree_to_rules" default=0>
    <cfparam name="form.share_on_timeline" default=0>

	<cfparam name="errorMessage" default="">
	<cfparam name="errorFields" default="">

    <cfset formDefaultsIncluded = true>

</cfif>