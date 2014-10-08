jQuery.ajax({
	url: '/courses.json',
	type: 'GET',
	dataType: 'script',
	success: function(response){
		courseAuto(response);
	}
});

function getSections(id){
	jQuery.ajax({
		url: '/courses/' + id + '/sections.json',
		type: 'GET',
		dataType: 'script',
		success: function(response){
			return response;
		}
	});
}

function courseAuto(response){
	var obj = jQuery.parseJSON(response);
	var departments = [];
	for(var i = 0; i < obj.length; i++){
		if(departments.indexOf(obj[i].department_code) <= -1) departments.push(obj[i].department_code);
	}
	jQuery('#Department').typeahead({
		hint: true,
		highlight: true,
		minLength: 1
	},
	{
		name: 'departments',
		displayKey: 'value',
		source: substringMatcher(departments)
	});

	jQuery('#Department').blur(function(){
		var index = objContains(jQuery(this).val(), obj);
		if(index > -1){
			var sections = [];
			for(var i = 0; i < obj.length; i++){
				if(obj[i].department_code == jQuery('#Department').val() && sections.indexOf(obj[i].department_code) <= -1){
					sections.push(obj[i].id);
				}
			}
			console.log(sections);
		}
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

var substringMatcher = function(strs) {
	return function findMatches(q, cb) {
		var matches, substrRegex;
		 
		matches = [];
		 
		substrRegex = new RegExp(q, 'i');
		 
		jQuery.each(strs, function(i, str) {
			if (substrRegex.test(str)) {
				matches.push({ value: str });
			}
		});
		 
		cb(matches);
	};
};