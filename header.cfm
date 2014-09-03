<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title><cfoutput>#this.title#</cfoutput></title>
		<meta name="description" content="">
		<meta name="author" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<cfheader name="P3P" value="CP='IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT'">
		<cfif structKeyExists(url, "key")>
			<cfinclude template="metas.cfm">
		<cfelse>
			<meta property="og:url" content="<cfoutput>#request.siteUrl#</cfoutput>">
			<meta property="og:title" content="<cfoutput>#this.title#</cfoutput>">
			<meta property="og:description" content="I accepted an NFL Extra Points #FandomNation challenge for a chance to win NFL prizes and tickets. Do you have what it takes to be the ultimate fan?">
			<meta property="og:image" content="<cfoutput>#request.siteUrl#images/NFL_FandomNation_ShareIcon.jpg</cfoutput>">
		</cfif>


		<!--- bootstrappin --->
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
		<!--- custom bootstrap with new breakpoints (320, 480, 768, 1024) --->
		<!--- <link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>css/bootstrap.min.css">
		<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>css/bootstrap-theme.min.css"> --->

		<!--- jquery ui styles --->
		<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.0/themes/start/jquery-ui.min.css" />

		<!--- google font orbitron --->
		<!--- <link href='http://fonts.googleapis.com/css?family=Orbitron:400,700' rel='stylesheet' type='text/css'> --->
		<!--- endzone font --->
		<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>css/fonts.css">
		<!--- https://github.com/cshold/jQuery-Facebook-Photo-Selector --->
		<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>css/csphotoselector.css">

		<link rel="stylesheet" href="<cfoutput>#request.webRoot#</cfoutput>css/layout.css">
		<link href="<cfoutput>#request.webRoot#css/1024.css</cfoutput>" rel="stylesheet" media="screen and (min-width:1024px)">
		<link href="<cfoutput>#request.webRoot#css/810.css</cfoutput>" rel="stylesheet" media="screen and (min-width:810px) and (max-width:1023px)">
		<link href="<cfoutput>#request.webRoot#css/768.css</cfoutput>" rel="stylesheet" media="screen and (min-width:768px) and (max-width:809px)">
		<link href="<cfoutput>#request.webRoot#css/480.css</cfoutput>" rel="stylesheet" media="screen and (min-width:480px) and (max-width:767px)">
		<link href="<cfoutput>#request.webRoot#css/320.css</cfoutput>" rel="stylesheet" media="screen and (max-width:479px)">


		<!--[if IE]>
			<script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<!--[if lt IE 9]>
			<script src="//promotions.mardenkane.com/common/bootstrap3/js/respond.min.js"></script>
		<![endif]-->

		<!--- jQuery+jqueryui --->
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.0/jquery-ui.min.js"></script>

		<!--- jwplayer --->
		<script type="text/javascript" src="//promotions.mardenkane.com/common/mediaplayer/jwplayer.js"></script>
		<!--- https://github.com/cshold/jQuery-Facebook-Photo-Selector --->
		<script type="text/javascript" src="<cfoutput>#request.webRoot#</cfoutput>scripts/csphotoselector.js?t=<cfoutput>#getTickCount()#</cfoutput>"></script>
		<script type="text/javascript" src="<cfoutput>#request.webRoot#</cfoutput>scripts/example.js?t=<cfoutput>#getTickCount()#</cfoutput>"></script>

		<cfif not this.debugMode>
			<script>
			  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
			  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

			  ga('create', 'UA-45638937-20', 'auto');
			  ga('send', 'pageview');

			</script>
		</cfif>


		<cfif not this.debugMode and not oHelpers.isStagingServer()>
			<cfif findNoCase('success', cgi.script_name)>
				<!-- Facebook Conversion Code for Entries 1L -->
				<script>(function() {
				var _fbq = window._fbq || (window._fbq = []);
				if (!_fbq.loaded) {
				var fbds = document.createElement('script');
				fbds.async = true;
				fbds.src = '//connect.facebook.net/en_US/fbds.js';
				var s = document.getElementsByTagName('script')[0];
				s.parentNode.insertBefore(fbds, s);
				_fbq.loaded = true;
				}
				})();
				window._fbq = window._fbq || [];
				window._fbq.push(['track', '6016102010929', {'value':'0.01','currency':'USD'}]);
				</script>
				<noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6016102010929&amp;cd[value]=0.01&amp;cd[currency]=USD&amp;noscript=1" /></noscript>

				<!-- Facebook Conversion Code for Entries -->
				<script>(function() {
				var _fbq = window._fbq || (window._fbq = []);
				if (!_fbq.loaded) {
				var fbds = document.createElement('script');
				fbds.async = true;
				fbds.src = '//connect.facebook.net/en_US/fbds.js';
				var s = document.getElementsByTagName('script')[0];
				s.parentNode.insertBefore(fbds, s);
				_fbq.loaded = true;
				}
				})();
				window._fbq = window._fbq || [];
				window._fbq.push(['track', '6016101707329', {'value':'0.01','currency':'USD'}]);
				</script>
                <noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6016101707329&amp;cd[value]=0.01&amp;cd[currency]=USD&amp;noscript=1" /></noscript>


                <!-- Facebook Conversion Code for Entries 3L -->
				<script>(function() {
                var _fbq = window._fbq || (window._fbq = []);
                if (!_fbq.loaded) {
                var fbds = document.createElement('script');
                fbds.async = true;
                fbds.src = '//connect.facebook.net/en_US/fbds.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(fbds, s);
                _fbq.loaded = true;
                }
                })();
                window._fbq = window._fbq || [];
                window._fbq.push(['track', '6016133587729', {'value':'0.01','currency':'USD'}]);
                </script>
                <noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6016133587729&amp;cd[value]=0.01&amp;cd[currency]=USD&amp;noscript=1" /></noscript>


                <!-- Facebook Conversion Code for Entries 2L -->
                <script>(function() {
                var _fbq = window._fbq || (window._fbq = []);
                if (!_fbq.loaded) {
                var fbds = document.createElement('script');
                fbds.async = true;
                fbds.src = '//connect.facebook.net/en_US/fbds.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(fbds, s);
                _fbq.loaded = true;
                }
                })();
                window._fbq = window._fbq || [];
                window._fbq.push(['track', '6016133406729', {'value':'0.01','currency':'USD'}]);
                </script>
                <noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6016133406729&amp;cd[value]=0.01&amp;cd[currency]=USD&amp;noscript=1" /></noscript>

                <!-- Facebook Conversion Code for Entries 3C -->
                <script>(function() {
                var _fbq = window._fbq || (window._fbq = []);
                if (!_fbq.loaded) {
                var fbds = document.createElement('script');
                fbds.async = true;
                fbds.src = '//connect.facebook.net/en_US/fbds.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(fbds, s);
                _fbq.loaded = true;
                }
                })();
                window._fbq = window._fbq || [];
                window._fbq.push(['track', '6016131912729', {'value':'0.01','currency':'USD'}]);
                </script>
                <noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6016131912729&amp;cd[value]=0.01&amp;cd[currency]=USD&amp;noscript=1" /></noscript>


                <!-- Facebook Conversion Code for Entries 2C -->
                <script>(function() {
                var _fbq = window._fbq || (window._fbq = []);
                if (!_fbq.loaded) {
                var fbds = document.createElement('script');
                fbds.async = true;
                fbds.src = '//connect.facebook.net/en_US/fbds.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(fbds, s);
                _fbq.loaded = true;
                }
                })();
                window._fbq = window._fbq || [];
                window._fbq.push(['track', '6016129803729', {'value':'0.01','currency':'USD'}]);
                </script>
                <noscript><img height="1" width="1" alt="" style="display:none" src="https://www.facebook.com/tr?ev=6016129803729&amp;cd[value]=0.01&amp;cd[currency]=USD&amp;noscript=1" /></noscript>
			</cfif>
		</cfif>

	</head>

	<body>

		<!--- bust dem frames! --->
		<!--- <script type="text/javascript">
			if (top.frames.length!=0)
				top.location=self.document.location;
		</script> --->

		<div id="page-wrapper">

			<cfif this.debugMode>
				<div class="row">
					<div class="col-xs-2">
						<span class="visible-lg">lg</span>
						<span class="visible-md">md</span>
						<span class="visible-sm">sm</span>
						<span class="visible-xs">xs</span>
					</div>
					<div class="col-xs-2">
						<span class="wid"></span>
					</div>
				</div>
			</cfif>

			<cfinclude template="mobile-nav.cfm">

			<div id="header">
				<cfinclude template="nav.cfm">
			</div>

			<div id="content">