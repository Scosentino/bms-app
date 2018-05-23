$(document).ready(function(){
    $("#new_wizard_form_banner").validate({
        highlight: function(element, errorClass, validClass) {
            $(element).addClass(errorClass).removeClass(validClass);
            $(element.form).find("label[for=" + element.id + "]")
                .addClass(errorClass)
        },
        unhighlight: function(element, errorClass, validClass) {
            $(element).removeClass(errorClass).addClass(validClass);
            var text = $("label[for=" + element.id + "]").data('old_text');
            $(element.form).find("label[for=" + element.id + "]")
                .removeClass(errorClass)
                .attr('style', 'display: inline-block;')
                .text(text);
        },
        rules: {
            'user_wizard[email]': {
                required: true,
                email: true,
                remote: "/check_email"
            },
            'user_wizard[password]': {
                required: true,
                minlength: 8
            },
            'user_wizard[password_confirmation]': {
                required: true,
                minlength: 8,
                equalTo: "#user_wizard_password"
            },
            'user_wizard[orders][documents][]': {
                required: true
            }

        },
        messages: {
            'user_wizard[password]': {
                required: "Please provide a password",
                minlength: "Your password must be at least 8 characters long"
            },
            'user_wizard[password_confirmation]': {
                required: "Please provide a password",
                minlength: "Your password must be at least 8 characters long",
                equalTo: "Please enter the same password as above"
            },
            'user_wizard[email]': {
                required: "Please enter a valid email address",
                remote: 'User with this email already present.'
            },
            'user_wizard[orders][documents][]': {
                required: 'You need to upload at least one document',
            }
        }

    });
});