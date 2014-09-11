$(document).ready(function() {

	jQuery('.add').click(function(){
		jQuery(this).parent('td').find('.modal').modal({
			keyboard: true
		});
		var add = jQuery(this);
		jQuery(this).parent('td').find('.close').click(function(){
			jQuery(add).parent('td').find('.modal').modal('hide').addClass('bound');
			clearForms(add);

		});
		jQuery(this).parent('td').find('.show-button').click(function(){
			jQuery(this).parent('td').find('.input-form').show();
			jQuery(this).hide();
		});
		jQuery(this).parent('td').find('.input-form').hide();

	});


	//this function is called and clears all the inputs of the respective modal
	function clearForms(modal){

	}

	//todo: bind create button
	//show schedules properly
	//add which course you are adding in the modal

});

