$(document).ready(function(){
    jQuery.validator.addMethod("card_valid", function (value, element) {
        var card_valid = $("#card_valid").val();
        var luhn_valid = $('#luhn_valid').val();
        return this.optional(element) || card_valid == 'true' && luhn_valid == 'true';
    }, 'Please provide a valid credit card number');

    jQuery.validator.addMethod("zipcode", function(value, element) {
        return this.optional(element) || /^\d{5}(?:-\d{4})?$/.test(value);
    }, "Please provide a valid zipcode.");

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
            'user_wizard[payment_method][card_number]': {
                required: true,
                card_valid: true
            },
            'user_wizard[payment_method][security_code]': {
                required: true,
                digits: true
            },
            'user_wizard[payment_method][zipcode]': {
                required: true,
                zipcode: true
            },
            'user_wizard[payment_method][bank_account_number]': {
                required: true,
                digits: true
            },
            'user_wizard[payment_method][bank_account_routing_number]': {
                required: true,
                digits: true
            },
            'user_wizard[payment_method][bank_name]': {
                required: true
            }
        },
        messages: {
            'user_wizard[payment_method][card_number]': "Please provide Card Number",
            'user_wizard[payment_method][security_code]': {
                required: "Please provide Security Code",
                digits: 'Please use only digits for Security Code'
            },
            'user_wizard[payment_method][zipcode]': "Please provide Zipcode",
            'user_wizard[payment_method][bank_account_number]': {
                required: "Please provide Bank Account number",
                digits: 'Please use only digits for Bank Account number'
            },
            'user_wizard[payment_method][bank_account_routing_number]': {
                required: "Please provide Bank Account routing number",
                digits: 'Please use only digits for Bank Account routing number'
            },
            'user_wizard[payment_method][bank_name]' : 'Bank Name should present'
        }
    });


    $('.payment_method_tabs').on('click', '.payment_method_changer', function(){
        var type = $(this).data('type');
        $('.payment_method_tabs li.active').each(function(i, element){
           $(element).removeClass('active')
        });

        $('#' + type + '_li').addClass('active');
        if(type == 'debit' || type == 'credit'){
            $('#user_wizard_payment_method_payment_type').val(type + '_card');
            $('#user_wizard_payment_method_card_number').show();
            $('label[for=user_wizard_payment_method_card_number]').show();
            $('#user_wizard_payment_method_security_code').show();
            $('label[for=user_wizard_payment_method_security_code]').show();
            $('#user_wizard_payment_method_zipcode').show();
            $('label[for=user_wizard_payment_method_zipcode]').show();
            $('#user_wizard_payment_method_year_ended').show();
            $('label[for=user_wizard_payment_method_year_ended]').show();
            $('#user_wizard_payment_method_month_ended').show();
            $('label[for=user_wizard_payment_method_month_ended]').show();
        }else if(type == 'bank'){
            $('#user_wizard_payment_method_payment_type').val('bank_account');
            $('#user_wizard_payment_method_card_number').hide();
            $('label[for=user_wizard_payment_method_card_number]').hide();
            $('#user_wizard_payment_method_security_code').hide();
            $('label[for=user_wizard_payment_method_security_code]').hide();
            $('#user_wizard_payment_method_zipcode').hide();
            $('label[for=user_wizard_payment_method_zipcode]').hide();
            $('#user_wizard_payment_method_year_ended').hide();
            $('label[for=user_wizard_payment_method_year_ended]').hide();
            $('#user_wizard_payment_method_month_ended').hide();
            $('label[for=user_wizard_payment_method_month_ended]').hide();
        }
    });

    if($('#user_wizard_payment_method_card_number').size() > 0){
        $('#user_wizard_payment_method_card_number').validateCreditCard(function(result) {
            $('#card_valid').val(result.valid);
            $('#luhn_valid').val(result.luhn_valid);

            checkIfCardValid(result);
        });
    }

    function checkIfCardValid(result){
        if(result.valid && result.luhn_valid){
            $('#user_wizard_payment_method_card_number').addClass('valid');
        }else{
            $('#user_wizard_payment_method_card_number').removeClass('valid');
        }
    }
});