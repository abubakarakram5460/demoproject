const bugStatus = ['new', 'started', 'resolved'];
const featureStatus = ['new', 'started', 'completed']

let htmlstring='';
$(document).on('turbolinks:load', function () {
  $('#bugtype').on('change', function (e) {
       
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
});