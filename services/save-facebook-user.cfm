<cfparam name="form.__token" default="">
<cfparam name="form.user_id" default="">
<cfparam name="form.email" default="">
<cfparam name="form.first_name" default="">
<cfparam name="form.last_name" default="">
<cfparam name="form.username" default="">
<cfparam name="form.profile_url" default="">
<cfparam name="form.profile_image_url" default="">
<cfparam name="form.accessToken" default="">

<cfif len(form.__token) and form.__token eq session.stamp>

	<cfif len(form.user_id)>

		<cfquery datasource="#this.dsn#">
			if not exists (
				select 1
				from FacebookUsers
				where user_id = <cfqueryparam value="#form.user_id#" cfsqltype="cf_sql_varchar">
			)
			begin
				insert into FacebookUsers (
					user_id,
					stamp,
					entrantId,
					email,
					first_name,
					last_name,
					username,
					profile_url,
					profile_image_url
				)
				values (
					<cfqueryparam value="#form.user_id#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#session.stamp#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#session.entrantId#" null="#not len(session.entrantId)#" cfsqltype="cf_sql_integer">,
					<cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#form.first_name#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#form.last_name#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#form.profile_url#" cfsqltype="cf_sql_varchar">,
					<cfqueryparam value="#form.profile_image_url#" cfsqltype="cf_sql_varchar">
				)
			end
		</cfquery>

		<cflock scope="session" timeout="4" throwontimeout="no">
			<cfset session.facebook_connected = true>
			<!--- store facebook user info in session for prepopulations --->
			<cfset facebook = structGet('session.facebook')>
			<cfset facebook['user_id'] = form.user_id>
			<cfset facebook['first'] = form.first_name>
			<cfset facebook['last'] = form.last_Name>
			<cfset facebook['email'] = form.email>
			<cfset facebook['profile_image_url'] = form.profile_image_url>
			<cfset facebook['accessToken'] = form.accessToken>
		</cflock>

	</cfif>
<cfelse>
	<!--- csrf attempt --->
</cfif>