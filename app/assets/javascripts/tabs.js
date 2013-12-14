
/*if(window.location.hash){
    $(this).find('a[ref="'+window.location.hash+'"]').tab('show');
}*/

/*loads default tab for search*/
$.ajax({
    url: "cemeteries/search",
    cache: false,
    success: function(html){ 
    }
});

$('#submit_tab a').click(function (e) {
    e.preventDefault()
    $('ul.nav-tabs li.active').removeClass('active');
    $(this).parent('li').addClass('active');
    $(this).tab('show');
});

$('#search_tab a').click(function (e) {
    e.preventDefault()
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')
    $(this).tab('show')
});
