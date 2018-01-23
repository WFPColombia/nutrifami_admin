/**
 * 
 */

// Ready
$(function(){
    
    
    // simple jMenu plugin called
    $("#jMenu").jMenu();
    // more complex jMenu plugin called
    /*$("#jMenu").jMenu({
      ulWidth : 'auto',
      effects : {
        effectSpeedOpen : 300,
        effectTypeClose : 'slide'
      },
      animatedText : false
    });*/
    // Fin jMenu
    
    
    
    /* Cerrar Overlay */
    $('#overlay_close').click( function () {
		$( "#overlay" ).hide();
    	$( "#overlay_content" ).html('');
    });
    /* Fin Cerrar Overlay */
    
    
 });
 // Fin Ready
 
 
 function openOverlayAjax(url){
 	$( "#overlay_content" ).load( url, function(){
    	$( "#overlay" ).show();
    } );
 }
 
 function closeOverlay(){
	$( "#overlay" ).hide();
    $( "#overlay_content" ).html('');
 }
 
 function openOverlayLoad(){
     $( "#overlay_loader" ).show();
 }
  function closeOverlayLoad(){
     $( "#overlay_loader" ).hide();
 }
 
 
 
 function loadFileAsURL(file)
{
    var urlBase64 = '';
    var reader  = new FileReader();

    reader.addEventListener("load", function () {
      urlBase64 = reader.result;
    }, false);

    if (file) {
      reader.readAsDataURL(file);
    }
    
    console.log(urlBase64);
}