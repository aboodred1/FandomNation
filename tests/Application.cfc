<cfcomponent output="true" extends="BarclaycardFandomNationContest.Application">


	<!--- onRequest --->
	<cffunction name="onRequest" access="public" output="yes">

		<cfargument name="template" required="yes" type="string">


		<cfif not structKeyExists(session, "loggedIn")>
			<cfset session.loggedIn = false>
		</cfif>

		<cfif isDefined("form.upass")
			and len(trim(form.upass))
			and hash(form.upass, 'SHA-1') eq "213103332F2CB0DF6937452FE7BA287583D1E9ED"><!--- something obscure --->

			<cflock scope="session" type="exclusive" timeout="4">
				<cfset session.loggedIn = true>
			</cflock>

		</cfif>

		<cfif not session.loggedIn>

			<div class="row">

				<div class="col-xs-12">

					<p class="lead">Please enter the password to access this feature.</p>
					<form class="form-inline" method="post">
						<div class="row">
							<div class="form-group col-xs-6">
								<label class="sr-only" for="upass">Password</label><!--- only visible to screen readers --->
								<input type="password" name="upass" id="upass" placeholder="Some type of secret phrase" class="form-control">
							</div>
							<div class="form-group col-xs-6">
								<input type="submit" value="Sign In" class="btn btn-default">
							</div>
						</div>
					</form>

				</div>

			</div>

		<cfelse>

			<cfinclude template="#arguments.template#">

		</cfif>

		<!--- probably not the best place for this, but i want to clean up the output a bit on some pages --->
		<script type="text/javascript">
			$(function(){

			});
		</script>

	</cffunction>


</cfcomponent>