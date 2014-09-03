<cfparam name="form.uname" default="">
<cfparam name="form.upass" default="">

<cfif structKeyExists(form, "signInKey")>
	<cfinclude template="login_submit.cfm">
</cfif>

<style type="text/css">
	.form-signin {
        max-width: 300px;
		min-width:300px;
		width:300px;
        padding: 19px 29px 29px;
        margin: auto;
        background-color: #fff;
        border: 1px solid #e5e5e5;
        -webkit-border-radius: 5px;
           -moz-border-radius: 5px;
                border-radius: 5px;
        -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
           -moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
                box-shadow: 0 1px 2px rgba(0,0,0,.05);
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"],
      .form-signin input[type="password"] {
        font-size: 16px;
        height: auto;
        margin-bottom: 15px;
        padding: 7px 9px;
      }
</style>
<form class="form-signin" method="post" action="login.cfm">
	<h2 class="form-signin-heading">Please sign in</h2>
	
	<input type="text" name="uName" id="uName" class="form-control" placeholder="User Name">
	<input type="password" name="uPass" id="uPass" class="form-control" placeholder="Password" autocomplete="false">
	
	<p>
		<button class="btn btn-large btn-primary" type="submit">Sign in</button>
	</p>
	<input type="hidden" name="signInKey" id="signInKey" value="<cfoutput>#hash(getTickCount(), 'sha-1')#</cfoutput>">
</form>