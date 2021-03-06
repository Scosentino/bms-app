// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery-3.3.1.min.js
//= require jquery_ujs
//= require jquery-ui
//= require jquery-migrate.min.js
//= require jquery.validate
//= require inputmask
//= require jquery.inputmask
//= require applications/jquery.creditCardValidator.js
//= require popper.min.js
//= require bootstrap.min.js
//= require_tree ./plugins
//= require_tree ./customers
//= require ezRtable


$(document).ready(function(){
    $('.customer_show_tabs').on('click', '.tabs_changer', function(){
        var type = $(this).data('type');
        $('.customer_show_tabs li.active').each(function(i, element){
            $(element).removeClass('active')
        });

        $('#' + type + '_li').addClass('active');
    });

    $('#new_order').on('click', '#merchant_statement_uploader', function(){
        $('#order_documents').click();
    });
});