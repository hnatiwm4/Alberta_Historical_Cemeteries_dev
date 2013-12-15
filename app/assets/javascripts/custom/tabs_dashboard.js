$.ajax({
    url: "users/profile",
    cache: false,
    success: function(html){ 
    }
});

$('#dash_tabs a').click(function (e) {
    e.preventDefault()
    $('ul.nav-tabs li.active').removeClass('active')
    $(this).parent('li').addClass('active')
    $(this).tab('show')
});

