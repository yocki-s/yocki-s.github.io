// MARKDOWN HACKS
// Nested Tables
$('table tr').each(function() {
	var nest1 = $(this).children('td:contains(":1"), td:contains("1:")');
	var nest2 = $(this).children('td:contains(":2"), td:contains("2:")');
	var nest3 = $(this).children('td:contains(":3"), td:contains("3:")');
	var nest4 = $(this).children('td:contains(":4"), td:contains("4:")');
	if(nest1.length){
    	nest1.addClass('child1 closed')
    	.parent('tr').addClass('nest1');
		nest1.html(function (i, t) {
		    return t.replace(':1', '').replace('1:', '');
		})
    }
    if(nest2.length){
    	nest2.addClass('child2 closed')
    	.parent('tr').addClass('nest2');
		nest2.html(function (i, t) {
		    return t.replace(':2', '').replace('2:', '');
		})
    }
    if(nest3.length){
    	nest3.addClass('child3 closed')
    	.parent('tr').addClass('nest3');
		nest3.html(function (i, t) {
		    return t.replace(':3', '').replace('3:', '');
		})
    }
    if(nest4.length){
    	nest4.addClass('child4 closed')
    	.parent('tr').addClass('nest4');
		nest4.html(function (i, t) {
		    return t.replace(':4', '').replace('4:', '');
		})
    }
});
$('table tr td a').click(function(){
	var nest1 = $(this).parents('tr').nextUntil('tr:not(".nest1")').children('.child1');
	var nest2 = $(this).parents('tr').nextUntil('tr:not(".nest2")').children('.child2');
	var nest3 = $(this).parents('tr').nextUntil('tr:not(".nest3")').children('.child3');
	var nest4 = $(this).parents('tr').nextUntil('tr:not(".nest4")').children('.child4');
	if(nest1.hasClass('closed')){
		nest1.removeClass('closed').slideDown(200);
	} else {
		nest4.addClass('closed');
		nest4.slideUp('200');
		nest3.addClass('closed');
		nest3.slideUp('200');
		nest2.addClass('closed');
		nest2.slideUp('200');
		nest1.addClass('closed');
		nest1.slideUp('200');
	}
	if(nest2.hasClass('closed')){
		nest2.removeClass('closed');
		nest2.slideDown(200);
	} else {
		nest4.addClass('closed');
		nest4.slideUp('200');
		nest3.addClass('closed');
		nest3.slideUp('200');
		nest2.addClass('closed');
		nest2.slideUp('200');
	}
	if(nest3.hasClass('closed')){
		nest3.removeClass('closed');
		nest3.slideDown(200);
	} else {
		nest4.addClass('closed');
		nest4.slideUp('200');
		nest3.addClass('closed');
		nest3.slideUp('200');
	}
	if(nest4.hasClass('closed')){
		nest4.removeClass('closed');
		nest4.slideDown(200);
	} else {
		nest4.addClass('closed');
		nest4.slideUp('200');
	}
});
