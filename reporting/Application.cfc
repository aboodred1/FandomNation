<cfcomponent
	output="false"
	hint="I define the application settings and event handlers.">

	<!--- set up the application --->
	<cfset this.name = "Reporting_#hash(getCurrentTemplatePath())#">
	<cfset this.title = "Reporting: NFLExtraPoints FandomNation Contest">
	<cfset this.applicationTimeout = createtimespan(0, 1, 0, 0)>
	<cfset this.adminEmail = "egrimm@mardenkane.com">
	<cfset this.sessionManagement = "true">
	<cfset this.sessionTimeout = createTimeSpan(0, 0, 20, 0)>
	<cfset this.dsn = "BarclaycardFandomNationContest">
	<cfset this.cfcPath = "BarclaycardFandomNationContest.components">

	<cfset init("Helpers","oHelpers","BaseComponents")>
	<cfset this.debugMode = oHelpers.isDevServer()>


	<!--- onApplicationStart --->
	<cffunction name="onApplicationStart">

		<cfset application.initialized = now()>

		<cfquery name="Application.Challenges" datasource="#this.dsn#" cachedwithin="#createTimespan(0, 1, 0, 0)#">
			select *
			from Challenges
			order by case challengeName
				when 'Touchdown Dance Extra Point Challenge' then 1
				when 'Slow-Mo Spectacular Challenge' then 2
				when 'Gadget Play Challenge' then 3
				when 'Wave Craze Challenge' then 4
				when 'Power Pose Challenge' then 5
				when 'Pet Pride Challenge' then 6
				when 'Fan Loyalty Challenge' then 7
			end
		</cfquery>

		<cfset application.tzid = "EST">
		<cfif getTimeZoneInfo().isDSTOn eq "yes"><cfset application.tzid = "EDT"></cfif>

	</cffunction>


	<!--- onSessionStart --->
	<cffunction name="onSessionStart">

        <cfset session.loginTrackingID = "">
		<cfset session.loggedin = false>
		<cfset session.loginID = "">
		<cfset session.uname = "">
		<cfset session.emailaddress = "">
		<cfset session.accesslevel = "">

	</cffunction>


	<!--- onRequestStart --->
	<cffunction name="onRequestStart" output="yes">

		<cfargument name="template" required="yes" type="string">

		<cfsetting requesttimeout="999" showdebugoutput="false" enablecfoutputonly="false">

        <cfset startAt = getTickCount()>

		<cfset init("Helpers","oHelpers","BaseComponents")>

		<cftry>
			<cfset browserShort = oHelpers.browserDetect(cgi.http_user_agent)>
			<cfcatch type="any">
				<cfset browserShort = "Unknown">
			</cfcatch>
		</cftry>

		<!--- determine root url of site (am i really going back to this?) --->
		<cfset local = {}>
		<cfset local.basePath = getDirectoryFromPath(getCurrentTemplatePath())>
		<cfset local.targetPath = getDirectoryFromPath(expandPath(arguments.template))>
		<cfset local.requestDepth = (listLen(local.targetPath, "\/") - listLen(local.basePath, "\/"))>
		<cfset request.webRoot = repeatString("../", local.requestDepth)>
		<cfset request.adminRoot = request.webRoot>
		<cfset request.webRoot &= "../"><!--- up one more level --->

		<cfset request.siteUrl = "http://#cgi.server_name#/Barclaycard/FandomNation/reporting/">

		<cfif findNoCase("promotions", cgi.server_name)>

			<cfset request.siteUrl = "https://promotions.mardenkane.com/Barclaycard/FandomNation/reporting/">

		</cfif>

		<cfset request.imgUrl = replaceNoCase(request.siteUrl,'reporting','images')>

		<cfif not structKeyExists(Application, "Challenges")>
			<cflock scope="Application" type="exclusive" timeout="4" throwontimeout="no">
				<cfquery name="Application.Challenges" datasource="#this.dsn#" cachedwithin="#createTimespan(0, 1, 0, 0)#">
					select *
					from Challenges
					order by case challengeName
						when 'Touchdown Dance Extra Point Challenge' then 1
						when 'Slow-Mo Spectacular Challenge' then 2
						when 'Gadget Play Challenge' then 3
						when 'Wave Craze Challenge' then 4
						when 'Power Pose Challenge' then 5
						when 'Pet Pride Challenge' then 6
						when 'Fan Loyalty Challenge' then 7
					end
				</cfquery>
			</cflock>
		</cfif>

		<cfif not findNoCase(".cfc", arguments.template)
			and not findNoCase("chromeless", arguments.template)>
			<cfinclude template="header.cfm">
		<cfelse>
			<cfsetting showdebugoutput="no">
		</cfif>

	</cffunction>


	<!--- onRequest --->
	<cffunction name="onRequest" access="public" output="yes">

		<cfargument name="template" required="yes" type="string">

		<!--- that user is logged in --->
		<cfif not session.loggedin
			and not findNoCase("login.cfm", arguments.template)>
			<cfset arguments.template = "login.cfm">
		</cfif>

		<cfinclude template="#arguments.template#">
	</cffunction>


	<!--- onRequestEnd --->
	<cffunction name="onRequestEnd">

		<cfargument name="template" required="yes" type="string">


		<!--- if requested template is a cfc, do not display header or footer --->
		<cfif not findNoCase(".cfc", arguments.template)
			and not findNoCase("chromeless", arguments.template)>
			<cfinclude template="footer.cfm">
		</cfif>

		<cfset init("Tracking","oTracking","BaseComponents")>

		<cfset endAt = getTickCount()>
		<cfset executionTime = endAt-startAt>

		<cftry>
			<cfset browserShort = oTracking.browserDetect(cgi.http_user_agent)>
			<cfcatch type="any">
				<cfset browserShort = "Unknown">
			</cfcatch>
		</cftry>

		<cfscript>
			oTracking.insertPageHit (
				loginTrackingID = session.loginTrackingID,
				loginID = session.loginID,
				template = left(trim(cgi.script_name), 255),
				executionTime = executionTime,
				queryString = left(trim(cgi.query_string), 1000),
				IPAddress = oHelpers.getClientIP(),
				referer = left(trim(cgi.http_referer), 1000),
				browser = left(trim(cgi.http_user_agent), 1000),
				browserShort = browserShort
			);
		</cfscript>

	</cffunction>


	<!--- onSessionEnd --->
	<cffunction name="onSessionEnd"></cffunction>

	<!--- onMissingTemplate --->
	<cffunction name="onMissingTemplate">

		<cfargument name="template" required="no" type="string" default="">

		<div class="error">
			Sorry, but the page you've requested, <cfoutput>#arguments.template#</cfoutput>, was not found on this server.
		</div>

	</cffunction>


	<!--- onError --->
	<cffunction name="onError">

		<cfargument name="Exception" type="any" required="no">

		<div class="alert alert-error alert-block error">An error was encountered, and a system administrator has been notified.</div>

		<!--- dont process cfaborts - these can be fired by cflocations, too --->
		<cfif exception.type eq "coldfusion.runtime.AbortException" or (isDefined("exception.rootcause.type") and exception.rootCause.type eq "coldfusion.runtime.AbortException")>
			<cfreturn>
		</cfif>

		<cfif this.debugMode>
			<cfoutput>#handleErrors(exception, true)#</cfoutput>
		</cfif>

		<cfif not this.debugMode>
			<cfmail from="mkexpert@gmail.com" to="#this.adminEmail#" subject="unhandled errors on #this.name#" type="html">
				<style>
					* {
						font-family:Georgia, "Times New Roman", Times, serif;
						color: ##444444;
						font-size: 85%;
					}
				</style>
				<p>Hello.</p>
				<p>An unhandled exception occurred at #dateFormat(now(), 'mm/dd/yy')# #timeFormat(now(), 'hh:mm:ss')#  in the #this.name# application.</p>
               	#handleErrors(exception, true)#
			</cfmail>
		</cfif>

		<!--- finish the page processing --->
		<cfset onRequestEnd(cgi.script_name)>

	</cffunction>


	<!--- handleErrors --->
	<cffunction name="handleErrors">
		<cfargument name="error" required="yes">
		<cfargument name="verbose" required="no" type="boolean" default=false>
		<cfsavecontent variable="errorOutput">
			<div class="error">
				<h1>Failed</h1>
				<cfoutput>
					<p>template: #arguments.error.TagContext[1].Template#</p>
					<p>line: #arguments.error.TagContext[1].Line#</p>
					<!--- <p>error: #arguments.error#</p> --->
					<cfif isDefined("arguments.error.cause.message") and len(arguments.error.cause.message)>
						<p>message: #arguments.error.cause.message#</p>
					<cfelse>
						<p>mesage: #arguments.error.Message#</p>
					</cfif>
					<p>detail: #arguments.error.Detail#</p>
				</cfoutput>
				<cfif arguments.verbose>
					<h2>Verbose Details</h2>
					<cfdump var="#arguments.error#" format="text" metainfo="false" label="EXCEPTION">
					<cfdump var="#cgi#" format="text" metainfo="false" label="CGI">
					<cfdump var="#session#" format="text" metainfo="false" label="SESSION">
					<cfif isStruct(form) and not structIsEmpty(form)>
						<cfdump var="#form#" format="text" metainfo="false" label="FORM">
					</cfif>
				</cfif>
			</div>
		</cfsavecontent>
		<cfreturn errorOutput>
	</cffunction>


	<!--- shortcut to init components - this is just a bit bril! --->
	<cffunction name="init">
		<cfargument name="component" required="yes">
		<cfargument name="objName" required="no" default="o#arguments.component#">
		<cfargument name="componentPath" required="no" default="#this.cfcPath#">
		<cfargument name="dsn" required="no" default="#this.dsn#">
		<cfif not isDefined("#arguments.objName#")>
			<cfset "#arguments.objName#" = createObject("component", "#arguments.componentPath#.#arguments.component#").init(arguments.dsn)>
		</cfif>
	</cffunction>

</cfcomponent>