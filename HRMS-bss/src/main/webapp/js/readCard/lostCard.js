$(function() {

	$('#lostOrderSearch')
			.on(
					'click',
					function() {
						$('#lostOrderSearchCondition').val(
								$('#foridLost').serialize());
						$('#tid')
								.load(
										"filter/readCard/getLostCard",
										$('#foridLost').serialize(),
										function() {
											$('.pagination>li>a').on('click',
													pageFunc);
										});
					})

	$('#revoke').on('click', function() {

		var door = "";
		$("input[name='tt']:checked").each(function() {
			door = door + ($(this).val()) + ",";
		});

		$.ajax({
			url : "filter/readCard/revokeCard",
			data : {
				door : door
			},
			type : 'POST',
			dataType : "json",
			success : function(data) {

			},
			error : function(XMLResponse) {
			}
		});

	})

});
