<cfcomponent output="false">

	<!--- <cfif dateCompare(now(), '2014-04-02') gte 0>
		<cfheader statuscode="410" statustext="The requested resource is no longer available at this address.">
		<cfabort>
	</cfif> --->

	<!--- set up the application --->
	<cfset this.name = "Barclaycard_FandomNation_Contest">
	<cfset this.title = "NFL Extra Points ##FandomNation Contest">
	<cfset this.applicationTimeout = createtimespan(0,1,0,0)>
	<cfset this.adminEmail = "egrimm@mardenkane.com">
	<cfset this.custServEmail = "fandomnation@mkpromosource.com">
	<cfset this.sessionmanagement = true>
	<cfset this.setclientcookies = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>
	<cfset this.dsn = "BarclaycardFandomNationContest">
	<cfset this.cfcPath = "BarclaycardFandomNationContest.components">
	<cfset this.facebookAppId = "613897718731717">

	<cfset init("Helpers","oHelpers","BaseComponents")>
	<cfset this.debugMode = oHelpers.isDevServer()>
	<cfif this.debugMode>
		<!--- test version of live app --->
		<cfset this.facebookAppId = "613900485398107">
	</cfif>


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
	</cffunction>


	<!--- onSessionStart --->
	<cffunction name="onSessionStart">
		<!--- if this.setclientcookies is set to false.... --->
		<!--- <cfheader name="Set-Cookie" value="CFID=#session.CFID#;path=/;HTTPOnly">
		<cfheader name="Set-Cookie" value="CFTOKEN=#session.CFTOKEN#;path=/;HTTPOnly"> --->
		<cfset session.entrantId = "">
		<cfset session.entryKey = "">
		<cfset session.photoId = "">
		<cfset session.videoId = "">
		<cfset session.facebook_connected = false>
		<cfset session.facebook = {}>
		<cfset session.stamp = hash(getTickCount(), "sha-1")>
		<cfset session.suspect = false>
		<cfset session.suspectReasons = []>
	</cffunction>


	<!--- onRequestStart --->
	<cffunction name="onRequestStart" output="yes">

		<cfargument name="template" required="yes" type="string">
		<cfsetting requesttimeout="999" showdebugoutput="false" enablecfoutputonly="false">
		<cfset startAt = getTickCount()>
		<cfset init("Helpers","oHelpers","BaseComponents")>
		<cfset browserShort = oHelpers.browserDetect(cgi.http_user_agent)>

		<!--- determine root url of site (am i really going back to this?) --->
		<cfset local = {}>
		<cfset local.basePath = getDirectoryFromPath(getCurrentTemplatePath())>
		<cfset local.targetPath = getDirectoryFromPath(expandPath(arguments.template))>
		<cfset local.requestDepth = (listLen(local.targetPath, "\/") - listLen(local.basePath, "\/"))>
		<cfif findNoCase("tests", cgi.script_name)>
			<cfset local.requestDepth += 1>
		</cfif>
		<cfset request.webRoot = repeatString("../", local.requestDepth)>

		<cfset request.siteUrl = "http://#cgi.server_name#/Barclaycard/FandomNation/">

		<cfif findNoCase("promotions", cgi.server_name)>

			<cfset request.siteUrl = "https://promotions.mardenkane.com/Barclaycard/FandomNation/">

		</cfif>

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

		<cfif not findNoCase("services", cgi.script_name)
			and not findNoCase(".cfc", cgi.script_name)>
			<cfinclude template="header.cfm">
		</cfif>

	</cffunction>


	<!--- onRequest --->
	<cffunction name="onRequest" access="public" output="yes">

		<cfargument name="template" required="yes" type="string">

		<cfif not this.debugMode>
			<!--- <cfif (dateCompare(now(), '2014-07-14') lt 0 or dateCompare(now(), '2014-09-08') gte 0)>
				<cfif not findNoCase("winners", cgi.script_name)>
					<cfset arguments.template = "holding/index.cfm">
				</cfif>
			</cfif> --->
		</cfif>

		<cfinclude template="#arguments.template#">

	</cffunction>


	<!--- onRequestEnd --->
	<cffunction name="onRequestEnd">

		<cfargument name="template" required="yes" type="string">

		<cfif not findNoCase("services", cgi.script_name)
			and not findNoCase(".cfc", cgi.script_name)>
			<cfinclude template="footer.cfm">
		</cfif>

		<cfset init("Tracking","oTracking","BaseComponents")>
		<cfset endAt = getTickCount()>
		<cfset executionTime = endAt-startAt>

		<cftry>
			<cfscript>
				oTracking.insertPageHit (
					entrantID = session.entrantID,
					stamp = session.stamp,
					template = left(trim(cgi.script_name), 255),
					executionTime = executionTime,
					queryString = left(trim(cgi.query_string), 1000),
					suspect = session.suspect,
					suspectReasons = arrayToList(session.suspectReasons),
					IPAddress = oHelpers.getClientIP(),
					referer = left(trim(cgi.http_referer), 1000),
					browser = left(trim(cgi.http_user_agent), 1000),
					browserShort = browserShort
				);
			</cfscript>
			<cfcatch type="any">
			<!--- a cftransaction rollback can leave us with a session.entrantid that doesnt exist in the entrants table, and then page insert will fail against the foreign key contraints --->
			</cfcatch>
		</cftry>

	</cffunction>


	<!--- onSessionEnd --->
	<cffunction name="onSessionEnd"></cffunction>


	<!--- onMissingTemplate --->
	<cffunction name="onMissingTemplate">

		<cfheader statuscode="404" statustext="404 - File or directory not found.">
		<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
		<title>404 - File or directory not found.</title>
		<style type="text/css">
		<!--
		body{margin:0;font-size:.7em;font-family:Verdana, Arial, Helvetica, sans-serif;background:#EEEEEE;}
		fieldset{padding:0 15px 10px 15px;}
		h1{font-size:2.4em;margin:0;color:#FFF;}
		h2{font-size:1.7em;margin:0;color:#CC0000;}
		h3{font-size:1.2em;margin:10px 0 0 0;color:#000000;}
		#header{width:96%;margin:0 0 0 0;padding:6px 2% 6px 2%;font-family:"trebuchet MS", Verdana, sans-serif;color:#FFF;
		background-color:#555555;}
		#content{margin:0 0 0 2%;position:relative;}
		.content-container{background:#FFF;width:96%;margin-top:8px;padding:10px;position:relative;}
		-->
		</style>
		</head>
		<body>
		<div id="header"><h1>Server Error</h1></div>
		<div id="content">
		 <div class="content-container"><fieldset>
		  <h2>404 - File or directory not found.</h2>
		  <h3>The resource you are looking for might have been removed, had its name changed, or is temporarily unavailable.</h3>
		 </fieldset></div>
		</div>
		</body>
		</html>


		<!--- <cfargument name="template" required="no" type="string" default="">

		<div class="error">
			<!--- Sorry, but the page you've requested, <cfoutput>#HTMLEditFormat(arguments.template)#</cfoutput>, was not found on this server. --->
			Sorry, but the page you've requested was not found on this server.<!--- wu is being cranky about emitting the page the user entered that didnt exist, claiming its an xss vulnerability --->
		</div> --->

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
				<p>Error originated from calling IP #oHelpers.getClientIP()#</p>
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


	<cffunction name="showCards">
		<cfargument name="which" required="no" default="challenge">
		<cfargument name="col_size" required="no" default="col-xs-4">

		<cfif arguments.which eq "challenge">
			<cfloop from="1" to="7" index="i">
				<div class="<cfoutput>#arguments.col_size#</cfoutput>" style="padding:0;padding-top:1em;">
					<a href="<cfoutput>#request.webRoot#register/?challengeId=#Application.Challenges.challengeId[i]#</cfoutput>"><!---
					 ---><img src="<cfoutput>#request.webRoot#images/#Application.Challenges.challengeCardImage[i]#</cfoutput>">
					</a>
				</div>
			</cfloop>

		<cfelseif arguments.which eq "winner-placeholder">

			<div class="row">
				<div class="col-xs-2"></div>
				<cfloop from="1" to="2" index="i">
					<div class="<cfoutput>#arguments.col_size#</cfoutput>" style="padding:0;">
						<img src="<cfoutput>#request.webRoot#images/#replace(Application.Challenges.challengeCardImage[i], 'challenge-', 'winner-placeholder-')#</cfoutput>">
					</div>
				</cfloop>
				<div class="col-xs-2"></div>
			</div>

			<div class="row" style="padding-top:1em;">
				<cfloop from="3" to="5" index="i">
					<div class="<cfoutput>#arguments.col_size#</cfoutput>" style="padding:0;">
						<img src="<cfoutput>#request.webRoot#images/#replace(Application.Challenges.challengeCardImage[i], 'challenge-', 'winner-placeholder-')#</cfoutput>">
					</div>
				</cfloop>
			</div>

			<div class="row" style="padding-top:1em;">
				<div class="col-xs-2"></div>
				<cfloop from="6" to="7" index="i">
					<div class="<cfoutput>#arguments.col_size#</cfoutput>" style="padding:0;">
						<img src="<cfoutput>#request.webRoot#images/#replace(Application.Challenges.challengeCardImage[i], 'challenge-', 'winner-placeholder-')#</cfoutput>">
					</div>
				</cfloop>
				<div class="col-xs-2"></div>
			</div>

		</cfif>

	</cffunction>

</cfcomponent>
