$(document).ready(function(){
    jQuery.validator.addMethod("zipcode", function(value, element) {
        return this.optional(element) || /^\d{5}(?:-\d{4})?$/.test(value);
    }, "Please provide a valid zipcode.");

    jQuery.validator.addMethod("federal_tax", function(value, element) {
        return this.optional(element) || /^\d{2}(?:-\d{5})?$/.test(value);
    }, "Please provide a valid federal tax id.");

    $("#edit_user_business").validate({
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
            'business[legal_name]': {
                required: true
            },
            'business[address_line_1]': {
                required: true
            },
            'business[city]': {
                required: true
            },
            'business[state]': {
                required: true
            },
            'business[zipcode]': {
                required: true,
                zipcode: true
            },
            'business[federal_tax_id]': {
                required: true,
                federal_tax: true
            },
            'business[name_of_credit_card_processor]': {
                required: true
            },
            'business[years_processor]': {
                required: true,
                digits: true,
                maxlength: 3
            },
            'business[merchant_id_number]': {
                required: true,
                digits: true
            }
        },
        messages: {
            'business[legal_name]': {
                required: "Please provide a Legal Name"
            },
            'business[address_line_1]': "Please provide Address",
            'business[city]': "Please provide a City",
            'business[state]': "Please provide a State",
            'business[federal_tax_id]': "Please provide a Federal Tax ID",
            'business[name_of_credit_card_processor]': "Please provide a Name Of Credit Card Processor",
            'business[years_processor]': {
                required: "Please provide Years Processor",
                digits: 'Please use only digits for Years Processor',
                maxlength: 'Maxlength 3 digits 1-999'
            },
            'business[merchant_id_number]': {
                required: "Please provide a Merchant ID Number",
                digits: 'Please use only digits for Merchant ID Number'
            }
        }
    });

    var selector = document.getElementById("business_federal_tax_id");
    var im = new Inputmask("99-99999");
    im.mask(selector);
});