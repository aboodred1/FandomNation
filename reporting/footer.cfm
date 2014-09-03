

			</div><!--- /container --->

		</div><!--- /content --->

	</div><!--- /page-container --->

	<script src="//promotions.mardenkane.com/common/bootstrap3/js/bootstrap.min.js"></script>

	<script>
		$(function(){
			// bootstrap button dropdown functioning as select element
			$(document).on('click', '.custom-select-options a', function(e){
				e.preventDefault();
				$(this).parent().parent().parent().find('.custom-select-label').text($(this).text());
				$(this).parent().parent().parent().find('input[type=hidden]').val($(this).data('id')).trigger('change');
			});
			$('.dropdown-menu input').click(function(){return false;}); //prevent menu hide
			$(document).on('click', '.custom-select-label', function(e){
				e.stopPropagation();
				$(this).next('.dropdown-toggle').dropdown('toggle');
			});
		});
	</script>

</body>

</html>