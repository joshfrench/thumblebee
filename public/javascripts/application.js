window.addEvent('domready', function() {

	var myAccordion = new Accordion($('rides'), 'h3.ride_header', 'div.ride_body', {
		opacity: false, duration: 200, show: -1, alwaysHide: true
	});
	
	var formSlider = new Fx.Slide('ride_form', { duration: 600 });
	
	var pSlider = new Fx.Slide('add_ride');
  
  if($('toggle_link')) {
		$('toggle_link').addEvent('click', function(e){
			e.stop();
			pSlider.hide();
			formSlider.toggle();
		});
		
		$('cancel_ride').addEvent('click', function(e) {
		  e.stop();
		  formSlider.toggle();
		  pSlider.show();
	  });	
  };
	
});

rowHighlighter = function(id,color) {
	$('rides').getElements('td.ride_'+id).highlight(color);
}