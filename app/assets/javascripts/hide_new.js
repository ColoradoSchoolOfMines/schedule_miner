jQuery('#create_schedules_btn').hide();

jQuery('#create_schedule').attr('disabled', 'disabled');

jQuery('.form-control').focus(function(){
	jQuery('#create_schedule').removeAttr('disabled');
});

jQuery('#create_schedule').click(function(){
	if(jQuery('.form-control').val().length == 0) jQuery('#create_schedules').attr('disabled','disabled');
	else
	{
		jQuery('#create_schedule').attr('disabled','disabled');
		jQuery('.form-control').attr('disabled','disabled');
	}
});

jQuery('.form-control').blur(function(){
	if(jQuery(this).val().length == 0) jQuery('#create_schedule').attr('disabled', 'disabled');
	else jQuery('#create_schedule').removeAttr('disabled');
});

jQuery('a:contains("Create")').css('color', 'black');
//jQuery('a:contains("Back")').css('color', 'white');
