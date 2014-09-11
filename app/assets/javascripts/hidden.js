$(document).ready(function() {

	jQuery('.add').click(function(){
		var base = jQuery(this).parent('td');
		var add = jQuery(this);

		jQuery(base).find('.modal').modal({
			keyboard: true
		});

		jQuery(base).find('.close').click(function(){
			jQuery(add).parent('td').find('.modal').modal('hide').addClass('bound');
			clearForms(add);

		});

		jQuery(base).find('.show-button').click(function(){
			jQuery(base).find('.input-form').show();
			jQuery(this).hide();
		});

		jQuery(base).find('.input-form').hide();
		jQuery(base).find('.show-button').show();

		var className = jQuery(base).parent('tr').find('td:nth-child(2)').text();
		var section = jQuery(base).parent('tr').find('td:nth-child(3)').text();

		jQuery(base).find(".header-content").text("Adding " + className + " Section " + section);
	});


	//this function is called and clears all the inputs of the respective modal
	function clearForms(modal){
		jQuery(modal).parent('td').find('.form-control').val('');
	}

	//todo: bind create button
	//show schedules properly

});

