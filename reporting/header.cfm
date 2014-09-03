<!DOCTYPE html>
	<html lang="en">
		<head>
			<meta charset="utf-8">
			<title><cfoutput>#this.title#</cfoutput></title>
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<meta name="description" content="">
			<meta name="author" content="">

			<link href="//promotions.mardenkane.com/common/bootstrap3/css/bootstrap.min.css" rel="stylesheet">

			<!--[if IE]>
				<script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
			<![endif]-->

			<!--- jquery foo magicalness --->
			<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
			<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
			<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/start/jquery-ui.min.css" />

			<!--- jwplayer --->
			<script type="text/javascript" src="//promotions.mardenkane.com/common/mediaplayer/jwplayer.js"></script>
			<style type="text/css">
				body{padding-top:50px;}
				body{font-family:Arial,sans-serif !important;}
				.btn-select, .btn-select:hover, .btn-select.dropdown-toggle{background:#ffffff;}
				.btn-select span{color:#000000;background:#ffffff;}
				.has-error .btn-select{border:1px solid #990000;/*background-color:red;color:white;*/}
				.custom-select{}
				.custom-select-label{max-width:77%;padding-left:1em;text-align:left;overflow:hidden;}
				.custom-select .caret{color:#000000;}
				.custom-select-options{max-height:200px;overflow-y:auto;}
				.custom-select-options a{text-decoration:none;font-size:.85em;}
				.user-image-frame{width:340px;height:346px;padding:21px 17px;background-image:url(../images/image-frame.png);overflow:hidden;}
				.user-image{width:305px;height:305px;overflow:hidden;}
				.facebook-profile-image{width:59px;height:59px;}
				.user-name,.user-place,.user-caption{font-family:EndzoneTechCondBold,sans-serif;font-weight:bold;}
				.user-name{font-size:1.125em;text-transform:uppercase;}
				.user-place{font-size:.875em;}
				.user-caption, h1{font-size:1.4375em;font-weight:normal;}
				.user-caption::before{content:"\201C";}
				.user-caption::after{content:"\201D";}
				/* SOME MODAL STUFF */
				.modal-header .close span{font-size:1.25em;color:#000000 !important;opacity: 1 !important;}
				.modal-vertical-centered {
				  transform: translate(0, 80%) !important;
				  -ms-transform: translate(0, 80%) !important; /* IE 9 */
				  -webkit-transform: translate(0, 80%) !important; /* Safari and Chrome */
				}
				.modal-content{background:#ffffff url(../images/body-background.jpg);}
				.modal-lg{width:764px;margin:auto;}
			</style>

		</head>

		<body>

			<div id="page-container" class="clearfix" style="min-width:320px;">

			    <cfinclude template="menu.cfm">

			    <header class="jumbotron" id="banner">
			    	<div class="container">
				    	<h2><cfoutput>#this.title#</cfoutput></h2>
					</div>
			    </header>

				<div id="content">

					<div class="container">
