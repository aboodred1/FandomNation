/*globals $, jQuery, CSPhotoSelector */

$(document).ready(function () {
	var selector, logActivity, callbackAlbumSelected, callbackPhotoUnselected, callbackSubmit;
	var buttonOK = $('#CSPhotoSelector_buttonOK');
	var o = this;
	
	
	/* --------------------------------------------------------------------
	 * Photo selector functions
	 * ----------------------------------------------------------------- */
	
	fbphotoSelect = function(id) {
		// if no user/friend id is sent, default to current user
		if (!id) id = 'me';
		
		callbackAlbumSelected = function(albumId) {
			var album, name;
			album = CSPhotoSelector.getAlbumById(albumId);
			// show album photos
			if ( album.id === 'videos') {
				selector.showVideoSelector(null, album.id);
			}
			else {
				selector.showPhotoSelector(null, album.id);
			}
		};

		callbackAlbumUnselected = function(albumId) {
			var album, name;
			album = CSPhotoSelector.getAlbumById(albumId);
		};

		callbackPhotoSelected = function(photoId) {
			var photo;
			photo = CSPhotoSelector.getPhotoById(photoId);
			buttonOK.show();
			//logActivity('Selected ID: ' + photo.id);
		};
		
		callbackVideoSelected = function(videoId) {
			var video;
			video = CSPhotoSelector.getVideoById(videoId);
			buttonOK.show();
			//logActivity('Selected video ID: ' + video.id);
		};

		callbackPhotoUnselected = function(photoId) {
			var photo;
			album = CSPhotoSelector.getPhotoById(photoId);
			buttonOK.hide();
		};
		
		callbackVideoUnselected = function(videoId) {
			var video;
			album = CSPhotoSelector.getVideoById(videoId);
			buttonOK.hide();
		};

		callbackSubmit = function(photoId) {
			var photo, video;
			try {
				photo = CSPhotoSelector.getPhotoById(photoId);
				$('.facebook-photo').html('<img src="'+photo.source+'">')
				$('input[name=facebook_photo]').val(photo.source);
				$('input[name=facebook_video]').val('');
				$('input[name=facebook_video_thumbnail]').val('');
			} catch (e) {
				videoId = photoId;
				video = CSPhotoSelector.getVideoById(videoId);
				$('.facebook-photo').html('<img src="'+video.picture+'">')
				$('input[name=facebook_photo]').val('');
				$('input[name=facebook_video]').val(video.source);
				$('input[name=facebook_video_thumbnail]').val(video.picture);
			}
			//logActivity('<br><strong>Submitted</strong><br> Photo ID: ' + photo.id + '<br>Photo URL: ' + photo.source + '<br>');
			
		};


		// Initialise the Photo Selector with options that will apply to all instances
		CSPhotoSelector.init({debug: false});

		// Create Photo Selector instances
		selector = CSPhotoSelector.newInstance({
			callbackAlbumSelected	: callbackAlbumSelected,
			callbackAlbumUnselected	: callbackAlbumUnselected,
			callbackPhotoSelected	: callbackPhotoSelected,
			callbackVideoSelected	: callbackVideoSelected,
			callbackPhotoUnselected	: callbackPhotoUnselected,
			callbackVideoUnselected	: callbackVideoUnselected,
			callbackSubmit			: callbackSubmit,
			maxSelection			: 1,
			albumsPerPage			: 6,
			photosPerPage			: 200,
			autoDeselection			: true
		});

		// reset and show album selector
		selector.reset();
		selector.showAlbumSelector(id);
	}
	
	logActivity = function (message) {
		//$("#results").append('<div>' + message + '</div>');
		console.log(message);
	};
});