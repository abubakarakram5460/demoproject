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

//= require jquery3
//= require jquery_ujs
//= require popper 
//= require tether
//= require bootstrap
//= require turbolinks
//= require_tree .


$(document).on('click',".open-AddImgDialog", function() {               
    html2canvas($("#picture"), {
        onrendered: function (canvas) {

            //theCanvas = canvas;
            //document.body.appendChild(canvas);
            //Canvas2Image.saveAsPNG(canvas); 

            var c = document.getElementById("myCanvas");
            var ctx = c.getContext("2d");
            var img = document.getElementById("test");

            var x = 0;
            var y = 0;
            var width = 200;
            var height = 200;

            ctx.drawImage(img, x, y, width, height);

        }
    });

});

$(document).on('click',"#open-AddImgDialog", function() {  
    $('#imagemodal').modal('show');   
});


$(function() {
    $('.alert-alert').delay(500).fadeIn('normal', function() {
        $(this).delay(4500).fadeOut();
        });
    });

    $(function() {
        $('.alert-notice').delay(500).fadeIn('normal', function() {
            $(this).delay(2500).fadeOut();
            });
        });

