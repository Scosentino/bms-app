$(document).ready(function(){
    jQuery.validator.addMethod("zipcode", function(value, element) {
        return this.optional(element) || /^\d{5}(?:-\d{4})?$/.test(value);
    }, "Please provide a valid zipcode.");

    jQuery.validator.addMethod("federal_tax", function(value, element) {
        return this.optional(element) || /^\d{2}(?:-\d{6})?$/.test(value);
    }, "Please provide a valid federal tax id.");

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
            'user_wizard[business][legal_name]': {
                required: true
            },
            'user_wizard[business][address_line_1]': {
                required: true
            },
            'user_wizard[business][city]': {
                required: true
            },
            'user_wizard[business][state]': {
                required: true
            },
            'user_wizard[business][zipcode]': {
                required: true,
                zipcode: true
            },
            'user_wizard[business][federal_tax_id]': {
                required: true,
                federal_tax: true
            },
            'user_wizard[business][name_of_credit_card_processor]': {
                required: true
            },
            'user_wizard[business][years_processor]': {
                required: true,
                digits: true,
                maxlength: 3
            },
            'user_wizard[business][merchant_id_number]': {
                required: true,
                digits: true
            }
        },
        messages: {
            'user_wizard[business][legal_name]': {
                required: "Please provide a Legal Name"
            },
            'user_wizard[business][address_line_1]': "Please provide Address",
            'user_wizard[business][city]': "Please provide a City",
            'user_wizard[business][state]': "Please provide a State",
            'user_wizard[business][federal_tax_id]': "Please provide a Federal Tax ID",
            'user_wizard[business][name_of_credit_card_processor]': "Please provide a Name Of Credit Card Processor",
            'user_wizard[business][years_processor]': {
                required: "Please provide Years Processor",
                digits: 'Please use only digits for Years Processor',
                maxlength: 'Maxlength 3 digits 1-999'
            },
            'user_wizard[business][merchant_id_number]': {
                required: "Please provide a Merchant ID Number",
                digits: 'Please use only digits for Merchant ID Number'
            }
        }
    });

    var selector = document.getElementById("user_wizard_business_federal_tax_id");
    var im = new Inputmask("99-999999");
    im.mask(selector);
});