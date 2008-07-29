var Nicely = {};
Nicely = {
	show_ride_form: function() {
		Effect.toggle($('ride_form'), 'blind');
		$('toggle_link').innerHTML = '<a href="#" onclick="Nicely.hide_ride_form(); return false;">Cancel</a>';
	},
	
	hide_ride_form: function() {
		Effect.toggle($('ride_form'), 'blind');
		$('toggle_link').innerHTML = '<strong>Giving a ride?</strong> Fill out the <a href="#" onclick="Nicely.show_ride_form(); return false;">add a ride</a> form.';	
	},

	flash_updated_row: function(id) {
		Effect.multiple(['origin_'+id, 'seats_'+id, 'notes_'+id], Effect.Highlight, {speed: 0, startcolor: '#8A79AA', duration: 1});
	}
}

window.onload = function () {
	accordion = new fx.Accordion(document.getElementsByClassName('ride_header'), 
								 document.getElementsByClassName('ride_body'), 
								{ opacity: false,
								  duration: 250,
								  start: false } );
}