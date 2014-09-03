<!--- look for any uploaded reports to make available for download --->
<cfdirectory action="list" directory="#expandPath('reports')#" name="reportList">
<cfif reportList.recordCount>
	<h2>Downloadable Reports: <cfoutput>#reportList.recordCount#</cfoutput></h2>
	<h3 onclick="$('#reportList').toggle();">View/Download</h3>
	<div id="reportList" class="rpt">
		<cfoutput query="reportList">
			<p><a href="reports/#name#">#name#</a></p>
		</cfoutput>
	</div>
</cfif>

<cfparam name="reporttype" default="entries">

<div class="panel panel-default">

	<div class="panel-heading">
		<h1>
			Reports &raquo; <cfoutput>#ucase(left(reporttype, 1))##lcase(right(reporttype, len(reporttype)-1))#</cfoutput>
		</h1>
		<p class="text-muted">(accurate as of <cfoutput>#dateFormat(now(), "mmmm d, yyyy")# at #timeFormat(now(), "h:mm TT")# #application.TZID#</cfoutput>)</p>
	</div>
	
	<div class="panel-body">
	
	
		<cfif fileExists(expandPath('report_#reporttype#.cfm'))>
			<cfinclude template="report_#reporttype#.cfm">
		</cfif>
	
	</div>
	
</div>