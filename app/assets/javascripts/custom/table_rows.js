$(document).ready(function($) {
    $('.row-clickable').click(function() {
	window.document.location = $(this).attr("href");
    });
});