/*loads default tab*/
$.ajax({
    url: "cemeteries/search",
    cache: false,
    success: function(html){ 
    }
});

$('#submit_tab a').click(function (e) {
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')
});

$('#search_tab a').click(function (e) {
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')
});

