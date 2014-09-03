<form name="registerForm" id="registerForm" action="" method="post" enctype="multipart/form-data" novalidate>

	<cfoutput>

		<div class="alert alert-danger form-errors" <cfif not listLen(errorFields)>style="display:none;"</cfif>>
		    <button type="button" class="close" data-dismiss="alert">&times;</button>
		    <div class="invalid-fields form-error">
		        All highlighted fields below need to be completed.
		    </div>
			<div class="already-entered form-error" style="display:none;">
		        Sorry! You can only enter once.
		    </div>
			<div class="upload-failed form-error" style="display:none;">
		        Sorry! Your upload failed. Please make sure your image is in an accepted format, and does not exceed 10MB.
		    </div>
			<div class="facebook-permissions form-error" style="display:none;">
		        Sorry! You must sign in to Facebook and grant the requested permissions to use this feature.
		    </div>
		</div>

		<div class="row" style="padding:1em 0;">
			<div class="col-xs-12">
				<a href="##" class="connect-to-facebook"><!---
					 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/button-use-your-facebook-information.png" class="hidden-xs"><img src="<cfoutput>#request.webRoot#</cfoutput>images/button-use-your-facebook-information-sm.png" class="visible-xs" style="margin:auto;">
				</a>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 text-center">
				<p><strong class="photo-label <cfif listFindNoCase(errorFields, 'fileUpload')>error</cfif>">Upload a photo or video to enter</strong></p>
			</div>
		</div>

		<div class="row text-center">

			<div id="upload_from_facebook_button" class="col-xs-12 col-sm-6">
				<a href="" class="photo-from-facebook"><!---
					 ---><img src="<cfoutput>#request.webRoot#</cfoutput>images/button-upload-from-facebook.png">
				</a>
			</div>
			<div id="upload_from_facebook_text" class="col-xs-12 col-sm-2" style="line-height:30px;">
				-OR-
			</div>
			<div class="col-xs-4 col-xs-offset-4 col-sm-4 col-sm-offset-0" style="line-height:30px;">
				<input type="file" name="fileUpload" id="fileUpload">
			</div>

		</div>

		<div class="facebook-photo text-center" style="padding-top:2em;">
			<cfif len(form.facebook_photo)>
				<img src="#form.facebook_photo#">
			</cfif>
			<cfif len(form.facebook_video)>
				<img src="#form.facebook_video#">
			</cfif>
		</div>

		<div class="row" style="padding:1em 0;">
			<div class="col-xs-12 text-center">
				<p style="padding-top:25px;"><strong>All fields required</strong></p>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12">
				<div class="form-group <cfif listFindNoCase(errorFields, 'caption')>has-error</cfif>">
					<label for="storyText">Caption</label>
					<textarea class="form-control" name="caption" cols="40" rows="2" required>#HTMLEditFormat(form.caption)#</textarea>
					<p class="help-block wordCount pull-right" style="font-size:.75em;">250 Words remaining</p>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 col-sm-6">
				<div class="form-group <cfif listFindNoCase(errorFields, 'firstName')>has-error</cfif>">
					<label for="firstName">First name</label>
					<input class="form-control" type="text" name="firstName" value="#HTMLEditFormat(form.firstName)#" maxlength="50" required>
				</div>
			</div>
			<div class="col-xs-12 col-sm-6">
				<div class="form-group <cfif listFindNoCase(errorFields, 'lastName')>has-error</cfif>">
					<label for="lastName">Last name</label>
					<input class="form-control" type="text" name="lastName" value="#HTMLEditFormat(form.lastName)#" maxlength="50" required>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 col-sm-8">
				<div class="form-group <cfif listFindNoCase(errorFields, 'emailAddress')>has-error</cfif>">
					<label for="emailAddress">Email</label>
					<input class="form-control" type="email" name="emailAddress" value="#HTMLEditFormat(form.emailAddress)#" maxlength="100" required>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 challenge-wrapper">
				<div class="form-group <cfif listFindNoCase(errorFields, 'challengeId')>has-error</cfif>">
					<label for="challengeId">Select a challenge</label>
					<cfinclude template="challengeddl.cfm">
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 col-sm-4">
				<div class="form-group <cfif listFindNoCase(errorFields, 'city')>has-error</cfif>">
					<label for="city">City</label>
					<input class="form-control" type="text" name="city" value="#HTMLEditFormat(form.city)#" maxlength="50" required>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4">
				<div class="form-group <cfif listFindNoCase(errorFields, 'state')>has-error</cfif>">
					<label for="state">State</label>
					<cfinclude template="stateddl.cfm">
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 team-wrapper" style="padding-right:0;">
				<div class="form-group <cfif listFindNoCase(errorFields, 'teamId')>has-error</cfif>">
					<label for="teamId">Select your NFL team</label>
					<cfinclude template="teamddl.cfm">
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 col-sm-7">
				<div class="checkbox <cfif listFindNoCase(errorFields, 'agree_to_rules')>has-error</cfif>">
					<label>
						<input type="checkbox" name="agree_to_rules" value="1" <cfif form.agree_to_rules eq 1>checked="checked"</cfif>>
						Yes, I agree to the <a href="#request.webRoot#rules/" target="_blank">Official Rules</a>
					</label>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12 col-sm-7">
				<div class="checkbox">
					<label>
						<input type="checkbox" name="share_on_timeline" value="1" checked="checked">
						Share my entry on my Facebook timeline (Optional)
					</label>
				</div>
			</div>
			<div class="col-xs-12 col-sm-5 text-right">
				<input type="image" src="#request.webRoot#images/button-submit.png">
			</div>
		</div>

		<input type="hidden" name="facebook_photo" value="#HTMLEditFormat(form.facebook_photo)#">
		<input type="hidden" name="facebook_video" value="#HTMLEditFormat(form.facebook_video)#">
		<input type="hidden" name="facebook_video_thumbnail" value="#HTMLEditFormat(form.facebook_video_thumbnail)#">
		<input type="hidden" name="__token" value="#session.stamp#">

	</cfoutput>

</form>

<!--- Markup for Carson Shold's Photo Selector --->
<!--- https://github.com/cshold/jQuery-Facebook-Photo-Selector --->
<div id="CSPhotoSelector">
  <div class="CSPhotoSelector_dialog">
    <a href="#" id="CSPhotoSelector_buttonClose">x</a>
    <div class="CSPhotoSelector_form">
      <div class="CSPhotoSelector_header">
        <p>Choose from Photos or Videos</p>
      </div>

      <div class="CSPhotoSelector_content CSAlbumSelector_wrapper">
        <p>Browse your albums until you find a picture or video you want to use</p>
        <div class="CSPhotoSelector_searchContainer CSPhotoSelector_clearfix">
          <div class="CSPhotoSelector_selectedCountContainer">Select an album</div>
        </div>
        <div class="CSPhotoSelector_photosContainer CSAlbum_container"></div>
      </div>

      <div class="CSPhotoSelector_content CSPhotoSelector_wrapper">
        <p>Select a new photo or video</p>
        <div class="CSPhotoSelector_searchContainer CSPhotoSelector_clearfix">
          <div class="CSPhotoSelector_selectedCountContainer"><span class="CSPhotoSelector_selectedPhotoCount">0</span> / <span class="CSPhotoSelector_selectedPhotoCountMax">0</span> photos/videos selected</div>
          <a href="#" id="CSPhotoSelector_backToAlbums">Back to albums</a>
        </div>
        <div class="CSPhotoSelector_photosContainer CSPhoto_container"></div>
      </div>

      <div id="CSPhotoSelector_loader"></div>


      <div class="CSPhotoSelector_footer CSPhotoSelector_clearfix">
        <a href="#" id="CSPhotoSelector_pagePrev" class="CSPhotoSelector_disabled">Previous</a>
        <a href="#" id="CSPhotoSelector_pageNext">Next</a>
        <div class="CSPhotoSelector_pageNumberContainer">
          Page <span id="CSPhotoSelector_pageNumber">1</span> / <span id="CSPhotoSelector_pageNumberTotal">1</span>
        </div>
        <a href="#" id="CSPhotoSelector_buttonOK">OK</a>
        <a href="#" id="CSPhotoSelector_buttonCancel">Cancel</a>
      </div>
    </div>
  </div>
</div>

<script>
	$(function(){

		// if we are on an xs device, i want to move the challenge ddl to appear beofre the team ddl
		if($('body').width() < 767) {
			$('.challenge-wrapper').insertBefore('.team-wrapper');
		}

		var maxWords = 250;

		$('.numbersOnly').bind('keyup change paste', function() {
			this.value = this.value.replace(/[^0-9]/g, '');
		});

		$('textarea[name=caption]').bind('keyup click blur focus change paste', function() {
			countWords($(this), maxWords, '.wordCount');
		});

		function countWords(elem, limit, elementToUpdate) {
			var wordsRemaining = limit;
			var $this = elem;
			var words = 0;
			if($this.val().length) words = $this.val().split(/\s+/).length;
			wordsRemaining = limit - words;
			if (wordsRemaining < 0) {
				$this.parent().addClass('has-error');
				$(elementToUpdate).addClass('text-danger');
				wordsRemaining = 0;
				//words = limit;
				<!--- //truncate input to first 250 words
				var wordArr = $this.val().split(/\s+/);
				var arrSlice = wordArr.slice(0, limit);
				var newStr = arrSlice.join(' ');
				$this.val(newStr); --->
			}
			else {
				$this.parent().removeClass('has-error');
				$(elementToUpdate).removeClass('text-danger');
			}
			if(wordsRemaining === 1){
				$(elementToUpdate).html('' + wordsRemaining + ' Word remaining');
			}
			else {
				$(elementToUpdate).html('' + wordsRemaining + ' Words remaining');
			}
		}

		<cfif len(form.caption)>
			countWords($('textarea[name=caption]'), maxWords);
		</cfif>

		$('form[name=registerForm]').submit(function(e){

			$('.has-error').removeClass('has-error');
			$('.error').removeClass('error');
			$('.form-errors, .already-entered, .email-match').hide();

			var $errorsFound = false;

			$first = $('input[name=firstName]');
			$last = $('input[name=lastName]');
			$addr = $('input[name=address1]');
			$city = $('input[name=city]');
			$state = $('select[name=state]');
			$email = $('input[name=emailAddress]');

			$story = $('textarea[name=caption]');
			$photo = $('input[name=fileUpload]');
			$fbphoto = $('input[name=facebook_photo]');
			$fbvideo = $('input[name=facebook_video]');

			//$team = $('select[name=teamId]');
			$team = $('input[name=teamId]');

			$challenge = $('select[name=challengeId]');

			//use client for validation
			if($first.val() == ''){
				$first.parent().addClass('has-error');
				$errorsFound = true;
			}
			if($last.val() == ''){
				$last.parent().addClass('has-error');
				$errorsFound = true;
			}
			if($addr.val() == ''){
				$addr.parent().addClass('has-error');
				$errorsFound = true;
			}
			if($city.val() == ''){
				$city.parent().addClass('has-error');
				$errorsFound = true;
			}
			if($state.val() == ''){
				$state.parent().addClass('has-error');
				$errorsFound = true;
			}
			if($team.val() == ''){
				$team.parent().addClass('has-error');
				$errorsFound = true;
			}
			if($challenge.val() == ''){
				$challenge.parent().addClass('has-error');
				$errorsFound = true;
			}

			var emailRegex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
			if(!emailRegex.test($email.val())){
				$email.parent().addClass('has-error');
				$errorsFound = true;
			}

			if($story.val() == '' || countWords($story, maxWords) > maxWords){
				$story.parent().addClass('has-error');
				$errorsFound = true;
			}


			if($photo.val() == '' && $fbphoto.val() == '' && $fbvideo.val() == ''){
				//$photo.parent().addClass('has-error');
				$('.photo-label').addClass('error');
				$errorsFound = true;
			}


			if(!$('input[name=agree_to_rules]').is(':checked')){
				$('input[name=agree_to_rules]').parent().parent().addClass('has-error');
				$errorsFound = true;
			}

			if($errorsFound){
				<!--- error message may be way back up the page, so scroll there! --->
				<!--- $('html,body').animate({scrollTop: $('a[name=form-errors]').offset().top}, 'slow'); --->
				<!--- padding top and fixed header are making this not-quite-right, so just all the way to the top, and THEN fade in errors! --->
				$('html, body').animate({scrollTop: 0}, 'slow', function(){
					$('.form-errors').fadeIn('slow');
					$('.invalid-fields').show();<!--- this can be hidden by a form submission, so make sure its visibibble --->
				});
			}

			return !$errorsFound;
		});
	});
</script>