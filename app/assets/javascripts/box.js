$('.hide_add').click(function(){
	$(this).closest('td').find('.white_content, .black_overlay').hide();
	return false;
});

$('.show_add').click(function(){
	$(this).closest('td').find('.white_content, .black_overlay').show();
	return false;
});