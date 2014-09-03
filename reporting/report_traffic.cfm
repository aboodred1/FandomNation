
<cfset init("Reports","oReports","BaseComponents")>

<!--- get page hits --->
<cfset pageHitCount = oReports.getPageHits(exceptionList="chromeless,tasks,services")>
<!--- <cfset nonMobilePageHitCount = oReports.getPageHits(mobile='no')>
<cfset mobilePageHitCount = oReports.getPageHits(mobile='yes')> --->

<!--- get page hits by date --->
<cfset pageHitsByDate = oReports.getPageHitsByDate(exceptionList="chromeless,tasks,services")>

<!--- get page hits by template --->
<cfset pageHitsByTemplate = oReports.getPageHitsByTemplate(exceptionList="chromeless,tasks,services")>

<!--- get page hits by browswer --->
<cfset pageHitsByBrowser = oReports.getPageHitsByBrowser(exceptionList="chromeless,tasks,services")>

<p class="lead well success">Page Hits: <cfoutput>#numberFormat(pageHitCount, ",")#</cfoutput></p>

<div class="accordion" id="accordion2">
	<div class="accordion-group">
		
		<div class="accordion-heading">
			<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
				Page Hits By Date
			</a>
		</div>
		<div id="collapseOne" class="accordion-body collapse in">
			<div class="accordion-inner">
				<table class="table table-striped table-condensed table-bordered">
					<thead>
			        	<tr>
							<th>Date</th>
							<th class="text-right">Hits</th>
							<!--- <th class="text-right">Non-Mobile</th>
							<th class="text-right">Mobile</th> --->
							<th class="text-right">pct</th>
						</tr>
					</thead>
					<cfset totalHits = 0>
					<!--- <cfset totalNonMobileHits = 0>
					<cfset totalMobileHits = 0> --->
			        <cfloop query="pageHitsByDate">
						<!--- <cfset nonMobileHits = oReports.getPageHits(mobile='no',insertDate=pageHitsByDate.hitDate)>
						<cfset mobileHits = oReports.getPageHits(mobile='yes',insertDate=pageHitsByDate.hitDate)> --->
						<cfoutput>
			                <tr>
			                    <td><a href="lookup_submit.cfm?insertDate=#dateFormat(pageHitsByDate.hitDate, 'yyyy-mm-dd')#">#dateFormat(pageHitsByDate.hitDate, "mmmm d, yyyy")#</a></td>
			                    <td class="text-right">#numberFormat(pageHitsByDate.hitCount, ",")#</td>
								<!--- <td class="text-right">#numberFormat(nonMobileHits, ",")#</td>
								<td class="text-right">#numberFormat(mobileHits, ",")#</td> --->
								<td class="text-right">#numberFormat((pageHitsByDate.hitCount/pageHitCount)*100, '99.99')#%</td>
			                </tr>
			            </cfoutput>
			            <cfset totalHits += pageHitsByDate.hitCount>
			           <!---  <cfset totalNonMobileHits += nonMobileHits>
			            <cfset totalMobileHits += mobileHits> --->
			        </cfloop>
			        <tfoot>
						<tr class="success">
							<td>&nbsp;</td>
							<td class="text-right"><cfoutput>#numberFormat(totalHits, ",")#</cfoutput></td>
							<!--- <td class="text-right"><cfoutput>#numberFormat(totalNonMobileHits, ",")#</cfoutput></td>
							<td class="text-right"><cfoutput>#numberFormat(totalMobileHits, ",")#</cfoutput></td> --->
							<td class="text-right"><cfoutput>#numberFormat((totalHits/pageHitCount)*100, '99.99')#%</cfoutput></td>
			            </tr>
					</tfoot>
			    </table>
			</div>
		</div>
		
		<div class="accordion-heading">
			<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
				Page Hits by Template
			</a>
		</div>
		<div id="collapseTwo" class="accordion-body collapse">
			<div class="accordion-inner">
				<table class="table table-striped table-condensed table-bordered">
					<thead>
			        	<tr>
							<th>Template</th>
							<th class="text-right">Hits</th>
							<!--- <th class="text-right">Non-Mobile</th>
							<th class="text-right">Mobile</th> --->
							<th class="text-right">pct</th>
						</tr>
					</thead>
					<cfset totalHits = 0>
					<!--- <cfset totalNonMobileHits = 0>
					<cfset totalMobileHits = 0> --->
			        <cfloop query="pageHitsByTemplate">
						<!--- <cfset nonMobileHits = oReports.getPageHitsByTemplate(mobile='no',template=pageHitsByTemplate.template).hitCount>
						<cfset mobileHits = oReports.getPageHitsByTemplate(mobile='yes',template=pageHitsByTemplate.template).hitCount> --->
						<cfoutput>
			                <tr>
			                    <!--- <td>#replaceNoCase(replaceNoCase(replaceNoCase(pageHitsByTemplate.template, '/seattlesbestcoffee', ''), '/alohawintersweeps', ''), 'index.cfm', '')#</td> --->
								<td>#replaceList(pageHitsByTemplate.template, '/facebook,/kia,/customer360,index.cfm', '')#</td>
			                    <td class="text-right">#numberFormat(pageHitsByTemplate.hitCount, ",")#</td>
								<!--- <td class="text-right">#numberFormat(nonMobileHits, ",")#</td>
								<td class="text-right">#numberFormat(mobileHits, ",")#</td> --->
								<td class="text-right">#numberFormat((pageHitsByTemplate.hitCount/pageHitCount)*100, '99.99')#%</td>
			                </tr>
			            </cfoutput>
			            <cfset totalHits += pageHitsByTemplate.hitCount>
			           <!---  <cfset totalNonMobileHits += val(nonMobileHits)>
			            <cfset totalMobileHits += val(mobileHits)> --->
			        </cfloop>
			        <tfoot>
						<tr class="success">
							<td>&nbsp;</td>
							<td class="text-right"><cfoutput>#numberFormat(totalHits, ",")#</cfoutput></td>
							<!--- <td class="text-right"><cfoutput>#numberFormat(totalNonMobileHits, ",")#</cfoutput></td>
							<td class="text-right"><cfoutput>#numberFormat(totalMobileHits, ",")#</cfoutput></td> --->
							<td class="text-right"><cfoutput>#numberFormat((totalHits/pageHitCount)*100, '99.99')#%</cfoutput></td>
			            </tr>
					</tfoot>
			    </table>
			</div>
		</div>
		
		<div class="accordion-heading">
			<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
				Page Hits by Browser (only top 25 displayed)
			</a>
		</div>
		<div id="collapseThree" class="accordion-body collapse">
			<div class="accordion-inner">
				<table class="table table-striped table-condensed table-bordered">
					<thead>
			        	<tr>
							<th>Browser</th>
							<th class="text-right">Hits</th>
							<!--- <th class="text-right">Non-Mobile</th>
							<th class="text-right">pct</th>
							<th class="text-right">Mobile</th>
							<th class="text-right">pct</th> --->
							<th class="text-right">pct</th>
						</tr>
					</thead>
					<cfset totalHits = 0>
					<!--- <cfset totalNonMobileHits = 0>
					<cfset totalMobileHits = 0> --->
					<cfset lc = 1>
			        <cfloop query="pageHitsByBrowser">
						<!--- <cfset nonMobileHits = oReports.getpageHitsByBrowser(mobile='no',browser=pageHitsByBrowser.browserShort).hitCount>
						<cfset mobileHits = oReports.getpageHitsByBrowser(mobile='yes',browser=pageHitsByBrowser.browserShort).hitCount> --->
						<cfif lc lte 25>
							<cfoutput>
				                <tr>
				                    <td>#browserShort#</td>
				                    <td class="text-right">#numberFormat(pageHitsByBrowser.hitCount, ",")#</td>
									<!--- <td class="text-right">#numberFormat(nonMobileHits, ",")#</td>
									<td><cfif val(nonMobileHits) neq 0>#numberFormat((nonMobileHits/pageHitsByBrowser.hitCount)*100, '99.99')#%<cfelse>0%</cfif></td>
									<td class="text-right">#numberFormat(mobileHits, ",")#</td>
									<td><cfif val(mobileHits) neq 0>#numberFormat((mobileHits/pageHitsByBrowser.hitCount)*100, '99.99')#%<cfelse>0%</cfif></td> --->
									<td class="text-right">#numberFormat((pageHitsByBrowser.hitCount/pageHitCount)*100, '99.99')#%</td>
				                </tr>
				            </cfoutput>
				        </cfif>
			            <cfset totalHits += pageHitsByBrowser.hitCount>
			           <!---  <cfset totalNonMobileHits += val(nonMobileHits)>
			            <cfset totalMobileHits += val(mobileHits)> --->
						<cfset lc += 1>
			        </cfloop>
					<cfoutput>
				        <tfoot>
							<tr class="success">
								<td>&nbsp;</td>
								<td class="text-right">#numberFormat(totalHits, ",")#</td>
								<!--- <td class="text-right">#numberFormat(totalNonMobileHits, ",")#</td>
								<td><cfif val(totalNonMobileHits) neq 0>#numberFormat((totalNonMobileHits/totalHits)*100, '99.99')#%<cfelse>0%</cfif></td>
								<td class="text-right">#numberFormat(totalMobileHits, ",")#</td>
								<td><cfif val(totalMobileHits) neq 0>#numberFormat((totalMobileHits/totalHits)*100, '99.99')#%<cfelse>0%</cfif></td> --->
								<td class="text-right">#numberFormat((pageHitCount/totalHits)*100, '99.99')#%</td>
				            </tr>
						</tfoot>
					</cfoutput>
			    </table>
			</div>
		</div>
		
	</div>
</div>