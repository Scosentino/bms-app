$(document).ready(function(){
    $('.customer_show_tabs').on('click', '.tabs_changer', function(){
        var type = $(this).data('type');
        $('.customer_show_tabs li.active').each(function(i, element){
            $(element).removeClass('active')
        });

        $('#' + type + '_li').addClass('active');
    });
});