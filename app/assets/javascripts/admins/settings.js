$(document).ready(function(){
    $("#edit_user_info").validate({
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
            'user[email]': {
                required: true,
                email: true,
                remote: "/check_email"
            },
            'user[first_name]': {
                required: true,
                minlength: 2
            },
            'user[last_name]': {
                required: true,
                minlength: 2
            }

        },
        messages: {
            'user[email]': {
                required: "Please enter a valid email address",
                remote: 'User with this email already present.'
            },
            'user[first_name]': {
                required: 'Please enter a First Name',
                minlength: 'Please provide at list 2 characters'
            },
            'user[last_name]': {
                required: 'Please enter a Last Name',
                minlength: 'Please provide at list 2 characters'
            }
        }

    });

    $("#edit_user_password").validate({
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
            'user[password]': {
                required: true,
                minlength: 8
            },
            'user[old_password]': {
                required: true,
                minlength: 8
            }

        },
        messages: {
            'user[password]': {
                required: "Please enter a password",
                minlength: 'Please provide at list 8 characters'
            },
            'user[old_password]': {
                required: 'Please enter an Old Password',
                minlength: 'Please provide at list 8 characters'
            }
        }

    });
});