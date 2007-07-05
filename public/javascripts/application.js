var Nicely = {};
Nicely = {
	show_ride_form: function() {
		Effect.toggle($('ride_form'), 'blind');
		$('toggle_link').innerHTML = '<a href="#" onclick="Nicely.hide_ride_form(); return false;">Cancel</a>';
	},
	
	hide_ride_form: function() {
		Effect.toggle($('ride_form'), 'blind');
		$('toggle_link').innerHTML = '<a href="#" onclick="Nicely.show_ride_form(); return false;">Add a ride</a>';	
	}
}
