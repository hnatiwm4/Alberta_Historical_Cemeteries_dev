/*loads default tabs*/
$.ajax({
    url: "cemeteries/search",
    cache: false,
    success: function(html){ 
    }
});

$('#search_tab a').click(function (e) {
    e.preventDefault()
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')
    $(this).tab('show')
});
