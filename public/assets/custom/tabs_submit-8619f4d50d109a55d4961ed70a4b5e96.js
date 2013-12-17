/*loads default tabs*/

$.ajax({
    url: "burials/submit",
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
