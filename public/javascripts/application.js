jQuery(document).ready(function($) {
  $('a[rel*=facebox]').facebox() // For Facebox
  $('a.print').click(function(){
		window.print();
			return false;
	});	
})

