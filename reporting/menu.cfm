<div class="navbar navbar-inverse navbar-fixed-top">

	<div class="container">

		<div class="navbar-header">

			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>

			<a class="navbar-brand" href="#"></a>

		</div>

		<div class="navbar-collapse collapse pull-right">
			<ul class="nav navbar-nav">
				<cfif session.loggedIn>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="<cfoutput>#request.adminRoot#</cfoutput>reports.cfm?reporttype=entries">Entries</a></li>
						</ul>
					</li>
					<cfif session.accessLevel neq "Client">
						<li><a href="<cfoutput>#request.adminRoot#</cfoutput>lookup.cfm" data-target="#"><span class="add-on"><i class="glyphicon glyphicon-search"></i></span> Search</a></li>
					</cfif>
					<li><a href="<cfoutput>#request.adminRoot#</cfoutput>logout.cfm" data-target="#"><span class="add-on"><i class="glyphicon glyphicon-user"></i></span> Sign Out</a></li>
				<cfelse>
					<li><a href="<cfoutput>#request.adminRoot#</cfoutput>login.cfm" data-target="#"><span class="add-on"><i class="glyphicon glyphicon-user"></i></span> Sign In</a></li>
				</cfif>
			</ul>
		</div><!--/.nav-collapse -->
	</div>

</div>