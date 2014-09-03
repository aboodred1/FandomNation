<cfif session.accessLevel eq "Client">
	<cflocation url="reports.cfm" addtoken="no">
</cfif>
<cfparam name="form.challengeId" default="">
<cfparam name="form.teamId" default="">
<cfparam name="errorFields" default="">

<div class="panel panel-default">

	<div class="panel-heading">
		<h1>
			Search
		</h1>
	</div>

	<div class="panel-body">

		<form name="lookupform" action="lookup_submit.cfm" method="post" class="form-horizontal" novalidate>

			<div class="form-group">
				<label for="lastName" class="control-label col-xs-2">Name</label>
				<div class="col-xs-5">
					<input type="text" name="firstName" id="firstName" maxlength="25" value="" class="form-control" placeholder="First">
					<span class="help-block">exact match</span>
				</div>
				<div class="col-xs-5">
					<input type="text" name="lastName" id="lastName" maxlength="25" value="" class="form-control" placeholder="Last">
				</div>
			</div>

			<div class="form-group">
				<label for="emailAddress" class="control-label col-xs-2">Email</label>
				<div class="col-xs-10">
					<input type="text" name="emailAddress" id="emailAddress" maxlength="50" value="" class="form-control" placeholder="handle@domain.com">
					<span class="help-block">exact match</span>
				</div>
			</div>

			<div class="form-group">
				<label for="insertDate" class="col-xs-2 control-label">Entry Date</label>
				<div class="col-xs-3">
					<div class="input-group">
						<input type="text" id="insertDate" name="insertDate" placeholder="mm/dd/yyyy" class="form-control datepicker">
						<span class="glyphicon glyphicon-calendar input-group-addon"></span>
					</div>
					<span class="help-block">first entered on this date</span>
				</div>
			</div>

			<div class="form-group">
				<label for="challengeId" class="col-xs-2 control-label">Challenge</label>
				<div class="col-xs-3">
					<div class="input-group">
						<cfinclude template="../register/challengeddl.cfm">
					</div>
				</div>
			</div>



			<div class="form-group">
				<label for="teamId" class="col-xs-2 control-label">Team</label>
				<div class="col-xs-3">
					<cfinclude template="../register/teamddl.cfm">
				</div>
			</div>

			<div class="form-group">
				<div class="col-xs-10 col-xs-offset-2">
					<button type="submit" class="btn btn-primary">Search</button>
					<button type="reset" class="btn btn-sm btn-link"><span class="text-danger">Reset</span></button>
				</div>
			</div>

		</form>

	</div>

</div>

<script type="text/javascript">
	$(function(){
		$('.datepicker').datepicker({
			changeMonth: true,
			changeYear: true,
			//yearRange: "-100",
			showAnim: "slideDown",//show,slideDown,fadeIn,blind,bounce,clip,drop,fold,slide
			dateFormat:'mm/dd/yy'//,
			//showOn: "button",
			//buttonImage: "//promotions.mardenkane.com/common/images/calendar.gif",
			//buttonImageOnly: true
		});
	});
</script>