jQuery.ajax({
	url: '/courses.json',
	type: 'GET',
	dataType: 'script',
	success: function(response){
		courseAuto(response);
	}
});


function courseAuto(response){
	var obj = jQuery.parseJSON(response);

	jQuery('#Department').blur(function(){
		if(objContains(jQuery(this).val(), obj) > -1) console.log('ok');
		else jQuery(this).val('');
	});
}

function objContains(value, objects){
	var index = -1;
	for(var i = 0; i < objects.length; i++){
		if(objects[i].department_code == value) index = i;
	}
	return index;
}