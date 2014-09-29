
<!--- placeholder --->

<!--- <div class="row">
	<div class="col-xs-12">
		<div class="page-title winners"></div>
		<div class="header-copy">
			<p class="text-center">CHECK BACK HERE ON OCTOBER 2ND TO SEE THE WINNERS!</p>
		</div>
	</div>
</div>
<div class="hidden-xs"><cfoutput>#showCards(which='winner-placeholder')#</cfoutput></div>
<div class="visible-xs"><cfoutput>#showCards(which='winner-placeholder', col_size='col-xs-12 text-center')#</cfoutput></div> --->


<!--- announced --->
<div class="row">
	<div class="col-xs-12">
		<div class="page-title">
			<img src="<cfoutput>#request.webRoot#</cfoutput>images/page-header-the-winners.png">
		</div>
		<div style="padding:1em;margin-top:-1.5em;">

			<p class="text-center">CONGRATULATIONS TO THE ULTIMATE FANS OF THE NFL EXTRA POINTS #FANDOMNATION</p>

		</div>
	</div>
</div>
<div class="hidden-xs"><cfoutput>#showCards(which='winners')#</cfoutput></div>
<div class="visible-xs"><cfoutput>#showCards(which='winners', col_size='col-xs-12 text-center')#</cfoutput></div>

<!--- modals for entry detail --->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg"><!---  modal-vertical-centered --->
		<div class="modal-content">

		</div>
	</div>
</div>


<script>
	$(function(){
		$(document).on('click', '.winner-card-frame', function(e){
			e.preventDefault();
			var entryKey = $(this).data('id');
			var scrollTop = $(window).scrollTop();
			var offset = $(this).offset().top;
			var distance = (offset - scrollTop);
			$('#myModal .modal-dialog .modal-content').empty();
			$.get('<cfoutput>#request.webRoot#</cfoutput>services/entry-detail.cfm?entryKey='+entryKey, function(data){
				$('#myModal .modal-dialog .modal-content').html(data);
				$('#myModal').modal();
				$('.modal-dialog').css({'margin-top': distance});
			});
		});
	});
</script>