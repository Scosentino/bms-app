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
//= require popper.min.js
//= require bootstrap.min.js
//= require_tree ./plugins
//= require_tree ./admins
//= require_tree ./applications


$(document).ready(function(){
    $('#new_user_wizard').on('click', '#merchant_statement_uploader', function(){
        $('#user_wizard_documents').click();
    });
});