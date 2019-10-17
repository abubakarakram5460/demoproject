  const bugStatus=['new','started','resolved'];
  const featureStatus=['new','started','completed']
  
  
  $(document).on('turbolinks:load', function() {    
    $('#bugtype').on('change', function(e) {
        console.log("asdxscd")
        if(this.value=='feature'){
            if($('#bugstatus option').length==0){
            featureStatus.map((value)=>{
       $('#bugstatus').append(`<option value=${value}>${value}</option>`)
 })
}
else {
    featureStatus.map((value)=>{
        $('#bugstatus option').remove()
        
  })
   


}
            }
        else{
            if($('#bugstatus option').length==0){
            bugStatus.map((value)=>{
                $('#bugstatus').append(`<option value=${value}>${value}</option>`)
             })

            }
            else $('#bugstatus option').remove()
        }
      });
});