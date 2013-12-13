
$(document).ready(function() {
    if(location.hash != ''){
	$('a[ref="'+location.hash+'"]').tab('show');
    }
    return $('a[data-toggle="tab"]').on('shown', function(e) {
	return location.hash = $(e.target).attr('href').substr(1);
    });

});

/*if(window.location.hash){
    $(this).find('a[ref="'+window.location.hash+'"]').tab('show');
}*/

/*loads default tab*/
$.ajax({
    url: "cemeteries/search",
    cache: false,
    success: function(html){ 
    }
});

$('#submit_tab a').click(function (e) {
    $('ul.nav-tabs li.active').removeClass('active');
    $(this).parent('li').addClass('active');
    $(this).tab('show');
});

$('#search_tab a').click(function (e) {
    e.preventDefault()
    // save tab hash to make persistent
    window.location.hash = $(this).attr('href')
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')
    $(this).tab('show')
});

