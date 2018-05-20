$(document).ready(function(){
    jQuery.validator.addMethod("card_valid", function (value, element) {
        var card_valid = $("#card_valid").val();
        var luhn_valid = $('#luhn_valid').val();
        return this.optional(element) || card_valid == 'true' && luhn_valid == 'true';
    }, 'Please provide a valid credit card number');

    jQuery.validator.addMethod("zipcode", function(value, element) {
        return this.optional(element) || /^\d{5}(?:-\d{4})?$/.test(value);
    }, "Please provide a valid zipcode.");

    $("#edit_user_payment_method").validate({
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
            'payment_method[card_number]': {
                required: true,
                card_valid: true
            },
            'payment_method[security_code]': {
                required: true,
                digits: true
            },
            'payment_method[zipcode]': {
                required: true,
                zipcode: true
            },
            'payment_method[bank_account_number]': {
                required: true,
                digits: true
            },
            'payment_method[bank_account_routing_number]': {
                required: true,
                digits: true
            },
            'payment_method[bank_name]': {
                required: true
            }
        },
        messages: {
            'payment_method[card_number]': "Please provide Card Number",
            'payment_method[security_code]': {
                required: "Please provide Security Code",
                digits: 'Please use only digits for Security Code'
            },
            'payment_method[zipcode]': "Please provide Zipcode",
            'payment_method[bank_account_number]': {
                required: "Please provide Bank Account number",
                digits: 'Please use only digits for Bank Account number'
            },
            'payment_method[bank_account_routing_number]': {
                required: "Please provide Bank Account routing number",
                digits: 'Please use only digits for Bank Account routing number'
            },
            'payment_method[bank_name]' : 'Bank Name should present'
        }
    });


    $('.payment_method_tabs').on('click', '.payment_method_changer', function(){
        var type = $(this).data('type');
        $('.payment_method_tabs li.active').each(function(i, element){
            $(element).removeClass('active')
        });

        $('#' + type + '_li').addClass('active');
        if(type == 'debit' || type == 'credit'){
            $('#payment_method_payment_type').val(type + '_card');
            $('#payment_method_card_number').show();
            $('label[for=payment_method_card_number]').show();
            $('#payment_method_security_code').show();
            $('label[for=payment_method_security_code]').show();
            $('#payment_method_zipcode').show();
            $('label[for=payment_method_zipcode]').show();
            $('#payment_method_year_ended').show();
            $('label[for=payment_method_year_ended]').show();
            $('#payment_method_month_ended').show();
            $('label[for=payment_method_month_ended]').show();
        }else if(type == 'bank'){
            $('#payment_method_payment_type').val('bank_account');
            $('#payment_method_card_number').hide();
            $('label[for=payment_method_card_number]').hide();
            $('#payment_method_security_code').hide();
            $('label[for=payment_method_security_code]').hide();
            $('#payment_method_zipcode').hide();
            $('label[for=payment_method_zipcode]').hide();
            $('#payment_method_year_ended').hide();
            $('label[for=payment_method_year_ended]').hide();
            $('#payment_method_month_ended').hide();
            $('label[for=payment_method_month_ended]').hide();
        }
    });

    if($('#payment_method_card_number').size() > 0){
        $('#payment_method_card_number').validateCreditCard(function(result) {
            $('#card_valid').val(result.valid);
            $('#luhn_valid').val(result.luhn_valid);

            checkIfCardValid(result);
        });
    }

    function checkIfCardValid(result){
        if(result.valid && result.luhn_valid){
            $('#payment_method_card_number').addClass('valid');
        }else{
            $('#payment_method_card_number').removeClass('valid');
        }
    }
});