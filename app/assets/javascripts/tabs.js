$('#submit_tab a').click(function (e) {
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')
});

$('#search_tab a').click(function (e) {
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')
});
