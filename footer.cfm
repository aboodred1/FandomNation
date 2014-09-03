


		</div><!--- #content --->
		<div id="footer">
			<div>
				<p>You could perform challenges for a chance to win NFL prizes and tickets,<br>but there&#8217;s a better way to earn them. The NFL Extra Points Card. <a href="http://www.barclaycardus.com/apply/Landing.action?campaignId=2038&cellNumber=706&referrerid=BCSBA030814" target="_blank">Apply here</a>.</p>
				<p>See contest <a href="<cfoutput>#request.webRoot#</cfoutput>rules/">Official Rules</a> | <a href="http://www.nflextrapoints.com/nfl-extra-points-credit-card/nfl-credit-card/terms" target="_blank">Terms & Conditions</a> | <a href="http://www.nflextrapoints.com/app/japply/legal/privacyPopUp.jsp" target="_blank">Privacy Policy</a></p>
			</div>
		</div><!--- #footer --->

		<div class="row disclaimer" style="margin-top:2em;">
			<div class="col-xs-12">
				<p style="font-size:.6875em;">
					NO PURCHASE NECESSARY. The National Football League, its member professional football clubs, NFL Ventures, Inc., NFL Ventures, L.P., NFL Properties LLC, NFL Enterprises LLC and each of their respective subsidiaries, affiliates, owners, shareholders, officers, directors, agents, representatives and employees (collectively, the “NFL Entities”) will have no liability or responsibility for any claim arising in connection with participation in this contest or any prize awarded.  The NFL Entities have not offered or sponsored this contest in any way.
				</p>
			</div>
		</div>

	</div><!--- #page-wrapper --->

	<!--- Placed at the end of the document so the pages load faster --->
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<!--- <script src="<cfoutput>#request.webRoot#</cfoutput>scripts/bootstrap.min.js"></script> --->

	<div id="fb-root"></div>
	<script>
		(function() {
			var e = document.createElement('script'); e.async = true;
			e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
			document.getElementById('fb-root').appendChild(e);
		}());

		window.fbAsyncInit = function() {
			FB.init({
				appId: '<cfoutput>#this.facebookAppId#</cfoutput>',
				status: true,
				cookie: true,
				xfbml: true,
				oauth: true
			});

			FB.Canvas.setAutoGrow();

			fbApiInit = true; //init flag

			FB.Event.subscribe('auth.statusChange', function(response) {
				//console.log('auth.statusChange response: ');
				//console.log(response);
				if (response.status === 'connected') {
					FB.api('/me', function(response) {
						//console.log('/me response:');
						//console.log(response);
					});
					// check permissions
					FB.api('/me/permissions', function(response){
						//console.log('/me/permissions response:');
						//console.log(response);
						granted_permissions = []
						for(var i=0; i<response.data.length; i++){
							//console.log(response.data[i].permission);
							granted_permissions.push(response.data[i].permission);
						}
					});

					<cfif structKeyExists(session, "share_on_timeline") and session.share_on_timeline eq 1>
						FB.ui({
						  method: 'share',
						  href: '<cfoutput>#request.siteUrl#</cfoutput><cfif structKeyExists(url, "key")>?key=<cfoutput>#url.key#</cfoutput></cfif>',
						}, function(response){
							//console.log('response:');
							//console.log(response);
						});
					</cfif>

				}
			});
		};

		var granted_permissions = [];

		function checkPermission(perm){
			return $.inArray(perm, granted_permissions) > 0;
		}

		<!--- this should really be broken down into smaller steps --->
		<!--- ALSO NOTE: THIS WILL FAIL IF THE APP IS IN SANDBOX MODE AND YOU TRY TO CONNECT WITH A DIFFERENT FB ACCOUNT --->
		function loginUser(perms) {

			perms = 'email,user_photos,user_friends,user_videos';//user_videos,publish_actions

			var $authResponse = '',
				$accessToken = '',
				$signedRequest = '',
				$userID = '',
				$first = '',
				$last = '',
				$username = '',
				$email = '',
				$profile_url = '',
				$profile_image_url = '';

			FB.login(function($loginresponse) {

				<!--- <cfif this.debugMode>
					console.log('loginresponse:');
					console.log($loginresponse);
				</cfif> --->

	     		if($loginresponse.authResponse){

	     			$authResponse = $loginresponse.authResponse;
	     			$accessToken = $authResponse.accessToken;
	     			$signedRequest = $authResponse.signedRequest;
	     			$userID = $authResponse.userID;

	     			<!--- collect and store user information --->
					<!--- <cfif this.debugMode>
		     			console.log('authresponse:');
		     			console.log($authResponse);
		     			console.log($authResponse.grantedScopes);
		     		</cfif> --->

	     			FB.api('/me', function($me){

	     				<!--- <cfif this.debugMode>
		     				console.log('$me:');
		     				console.log($me);
		     			</cfif> --->

	     				$first = $me.first_name;
		     			$last = $me.last_name;
	     				$email = $me.email;
	     				$profile_url = $me.link;

	     				FB.api('/me/picture', function($picture){
		     				<!--- <cfif this.debugMode>
			     				console.log('$picture:');
			     				console.log($picture);
			     			</cfif> --->
			     			$profile_image_url = $picture.data.url;

			     			<!--- savories --->
			     			$.post('<cfoutput>#request.webRoot#services/save-facebook-user.cfm</cfoutput>', {
			     				<cfif structKeyExists(session, "stamp")>
			     				__token: '<cfoutput>#session.stamp#</cfoutput>',
			     				</cfif>
			     				user_id: $userID,
			     				email: $email,
			     				first_name: $first,
			     				last_name: $last,
			     				username: $username,
			     				profile_url: $profile_url,
			     				profile_image_url: $profile_image_url,
			     				accessToken: $accessToken
		     				})
							.done(function(data){
								<cfif findNoCase('register', cgi.script_name)>
									<!--- populate form with fb user data --->
									$('input[name=firstName]').val($first);
									$('input[name=lastName]').val($last);
									$('input[name=emailAddress]').val($email);
									<!--- hide the 'connect' button --->
									<!--- $('.connect-to-facebook').fadeOut('slow'); --->
								</cfif>
							})
							.fail(function(){})
							.always(function(){});

		     			});

	     			});
					//console.log('returning true from loginUser('+perms+')');
	     			return true;
	     		}
	     		else {
	     			<!--- handle the rejection --->
					//console.log('returning FALSE from loginUser('+perms+')');
	     			return false;
	     		}
	     	}, {scope: perms, return_scopes: true});
		}

		$(document).on('click', '.connect-to-facebook', function(e){
			e.preventDefault();
			//if(!checkPermission('email')){
				loginUser('email');
			//}
		});

		<!--- $(document).on('click', 'input[name=share_on_timeline]', function(e){
			if($(this).is(':checked')){
				if(!checkPermission('publish_actions')){
					$(this).attr('checked', false);
					$('html, body').animate({scrollTop: 0}, 'slow', function(){
						$('.form-errors').fadeIn('slow');
						$('.invalid-fields').hide();
						$('.facebook-permissions').show();
					});
				}
			}
		}); --->

		<!--- https://github.com/cshold/jQuery-Facebook-Photo-Selector --->
		$(document).on('click', '.photo-from-facebook', function(e){
		    e.preventDefault();
		    // check for user_photos permission
		    if(checkPermission('user_photos')){
		        id = null;
			    if ( $(this).attr('data-id') ) id = $(this).attr('data-id');
			    fbphotoSelect(id);
		   	} else {
				$('html, body').animate({scrollTop: 0}, 'slow', function(){
					$('.form-errors').fadeIn('slow');
					$('.invalid-fields').hide();
					$('.facebook-permissions').show();
				});
			}
		});

		// bootstrap button dropdown functioning as select element
		$(document).on('click', '.custom-select-options a', function(e){
			e.preventDefault();
			/*console.log($(this).text());*/
			$(this).parent().parent().parent().find('.custom-select-label').text($(this).text());
			//$(this).parent().parent().parent().find('input[type=hidden]').val($(this).text());
			$(this).parent().parent().parent().find('input[type=hidden]').val($(this).data('id')).trigger('change');
		});
		$('.dropdown-menu input').click(function(){return false;}); //prevent menu hide
		<!--- $(document).on('keypress, keyup', '.other-input', function(e){
			$(this).parent().parent().parent().parent().find('.custom-select-label').text($(this).val());
			$(this).parent().parent().parent().parent().find('input[type=hidden]').val($(this).val());
			if(e.keyCode==13){
				e.preventDefault();//prevent form from submitting
				$('[data-toggle="dropdown"]').parent().removeClass('open');//close menu instead
			}
		}); --->
		$(document).on('click', '.custom-select-label', function(e){
			e.stopPropagation();
			$(this).next('.dropdown-toggle').dropdown('toggle');
		});


		function getFriends(){
			//https://developers.facebook.com/docs/graph-api/reference/v2.1/user/friends/
			//https://developers.facebook.com/docs/apps/faq
			//This will only return any friends who have used (via Facebook Login) the app making the request.
			//Further, each user must grant the user_friends permission in order to appear in the response to /me/friends.
			<!--- FB.api('/me/friends', function(response){
				console.log('getFriends response: ')
				console.log(response);
			}); --->

			<!--- FB.api('/me/taggable_friends', function(response){
				console.log('getFriends response: ')
				console.log(response);
			}); --->
		}

		$(document).on('click', '.get-friends', function(e){
			e.preventDefault();
			getFriends();
		});

		$(document).on('click', '.mobile-nav', function(e){
			$('.mobile-nav-active').toggle();
		});

		<!--- function centerModal() {
		    $(this).css('display', 'block');
		    var $dialog = $(this).find(".modal-dialog");
		    var offset = ($(window).height() - $dialog.height()) / 2;
		    // Center modal vertically in window
		    $dialog.css("margin-top", offset);
		}

		$('.modal').on('show.bs.modal', centerModal);
		$(window).on("resize", function () {
		    $('.modal:visible').each(centerModal);
		}); --->

	</script>

	<script type="text/javascript">
		$(function(){
			<cfif this.debugMode>
				$(window).bind('resize', function(){
					$('.wid').html($('body').width());//this is what media queries target
				}).trigger('resize');
			</cfif>
		});
	</script>

  </body>
</html>
