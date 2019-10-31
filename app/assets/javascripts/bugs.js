const bugStatus = ['new', 'started', 'resolved'];
const featureStatus = ['new', 'started', 'completed']

let htmlstring='';
$(document).on('turbolinks:load', function () {
  $('#bugtype').on('change', function (e) {
       console.log("scdscds")
    if (this.value == 'feature') {
        htmlstring='';
      featureStatus.map((value) => {
       htmlstring=htmlstring+`<option value=${value}>${value}</option>`;
      })
   
      $('#bugstatus').html(htmlstring)
    }
    else {
          htmlstring='';
      bugStatus.map((value) => {
        htmlstring=htmlstring+`<option value=${value}>${value}</option>`;
      })
      $('#bugstatus ').html(htmlstring)
    }
  });

  $(".modal-btn").on('click',function(){
    var img_src= $(this).data('img');
    console.log(img_src);
   
  $('#modal-img').attr('src', img_src); 
  $("#exampleModalCenter").modal();

  })

  



  

});

