
$(document).on('turbolinks:load', function() {
    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
        $('#content').toggleClass('padded');
        $('#sidebarCollapseWrapper').toggleClass('padded');
    });
});
