$(function() {

	$('#resove').on('click', function() {

		var door = "";
		$("input[name='tt']:checked").each(function() {
			door = door + ($(this).val()) + ",";
		});

		$.ajax({
			url : "filter/readCard/resoveCard",
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

	var cardRecord = Handlebars.compile($("#cardRecord").html());
	getCardRecord = function() {
		$.ajax({
			url : "filter/readCard/getCardRecord",
			data : {},
			type : 'POST',
			dataType : "json",
			success : function(data) {
				$('#tid').html(cardRecord(data.jsonArray));
			},
			error : function(XMLResponse) {
			}
		});

	}
	getCardRecord();

})