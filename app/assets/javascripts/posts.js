$(document).ready(function() {
	
	$.embedly.defaults.key = #{ENV['embedly_key']};
	$('.media a').embedly({query: {maxwidth: 600}, 'method':'after'});
});



   
  
