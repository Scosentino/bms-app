$(document).ready(function(){
    jQuery.validator.addMethod("phone_number", function(value, element) {
        return this.optional(element) || /^\(\d{3}\)\s{1}\d{3}(?:-\d{4})?$/.test(value);
    }, "Please provide a valid phone number.");

    $("#new_user_wizard").validate({
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
            'user_wizard[first_name]': {
                required: true
            },
            'user_wizard[last_name]': {
                required: true
            },
            'user_wizard[job_title]': {
                required: true
            },
            'user_wizard[phone_number]': {
                required: true,
                phone_number: true
            },
            'user_wizard[ssn]': {
                required: true,
                digits: true,
                maxlength: 4
            }
        },
        messages: {
            'user_wizard[first_name]': "Please provide First Name",
            'user_wizard[last_name]': "Please provide Last Name",
            'user_wizard[job_title]': "Please provide Job Title",
            'user_wizard[phone_number]': "Please provide Phone Number",
            'user_wizard[ssn]': {
                required: "Please provide SSN",
                digits: 'Please use only digits for SSN',
                maxlength: 'Max length 4 numbers for SSN'
            }
        }
    });

    var selector = document.getElementById("user_wizard_phone_number");
    var im = new Inputmask("(999) 999-9999");
    im.mask(selector);

    var selector2 = document.getElementById("user_wizard_ssn");
    var im2 = new Inputmask("9999");
    im2.mask(selector2);
});