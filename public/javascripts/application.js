var Nicely = {};
Nicely = {
	highlight_row: function(id) {
		$('rides').getElements('td.ride_'+id).highlight('#8A79AA')
	}
};

window.addEvent('domready', function() {
	var myAccordion = new Accordion($('rides'), 'h3.ride_header', 'div.ride_body', {
		opacity: false, duration: 200, show: -1, alwaysHide: true
	});
	
	var status = {
		'true': '<strong><a href="#" id="toggle_link">Cancel</a></strong>',
		'false': '<strong>Giving a ride?</strong> Fill out the <a href="#" id="toggle_link">add a ride</a> form.'
	};
	
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