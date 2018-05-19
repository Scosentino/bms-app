$(document).ready(function(){
    var drop = $("#user_wizard_orders_documents");
    drop.on('dragenter', function (e) {
        $(".drop").css({
            "border": "4px dashed #09f",
            "background": "rgba(0, 153, 255, .05)"
        });
        $(".cont").css({
            "color": "#09f"
        });
    }).on('dragleave dragend mouseout drop', function (e) {
        $(".drop").css({
            "border": "3px dashed #DADFE3",
            "background": "transparent"
        });
        $(".cont").css({
            "color": "#8E99A5"
        });
    });



    function handleFileSelect(evt) {
        var files = evt.target.files; // FileList object

        // Loop through the FileList and render image files as thumbnails.
        for (var i = 0, f; f = files[i]; i++) {
            $('#list').empty();
            // Only process image files.
            if (!f.type.match('image.*')) {
                continue;
            }

            var reader = new FileReader();

            // Closure to capture the file information.
            reader.onload = (function(theFile) {
                return function(e) {
                    // Render thumbnail.
                    var span = document.createElement('span');
                    span.innerHTML = [theFile.name].join('');
                    document.getElementById('list').insertBefore(span, null);
                };
            })(f);

            // Read in the image file as a data URL.
            reader.readAsDataURL(f);
        }
    }

    $('#user_wizard_orders_documents').change(handleFileSelect);


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