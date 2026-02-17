$(function() {
  
	var actionContainer = $(".actionmenu");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
  
	  if (item.showmenu) {
		ResetMenu();
		$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
		actionContainer.fadeIn();
	  }
  
	  if (item.hidemenu) {
		$('body').css('background-color', 'transparent')
		actionContainer.fadeOut();
	  }
	});


  });
  
  function showmenu() {
		$('.arma-item').css('transform', 'scale(1)');
		$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
		$(".actionmenu").fadeIn();
	  } 
	  
  function erroquant() {	  
	    Swal.fire(
        'Atenção',
        'Coloque a quantidade',
        'warning'
      )
	 } 
	  
  function erroquantvez() {	  
	    Swal.fire(
        'Atenção',
        'Só é possivel comprar 10 de cada vez',
        'warning'
      )
	 } 
	 
  function hidemenu() {
		$('body').css('background-color', 'transparent')
		$(".actionmenu").fadeOut();
	  }	  
	  
  function ResetMenu() {
	$("div").each(function(i, obj) {
	  var element = $(this);
  
	  if (element.attr("data-parent")) {
		element.hide();
	  } else {
		element.show();
	  }
	});
  }
  

	$(".menuoption").each(function(i, obj) {
	  if ($(this).attr("data-action")) {
		$(this).click(function() {
		  var data = $(this).data("action");
		  sendData("ButtonClick", data);
		});
	  }
  
	  if ($(this).attr("data-sub")) {
		var menu = $(this).data("sub");
		var element = $("#" + menu);
  
		$(this).click(function() {
		  element.show();
		  $("#mainmenu").hide();
		});
  
		$(".subtop button, .back").click(function() {
		  element.hide();
		  $("#mainmenu").show();
		});
	  }
	});

 
  
  $('.category_arma').click(function() {
	let pegArma = $(this).attr('category');
	$('.arma-item').css('transform', 'scale(0)');
  
	function hideArma() {
		$('.arma-item').hide();
	}
	setTimeout(hideArma, 100);
  
	function showArma() {
		$('.arma-item[category="' + pegArma + '"]').show();
		$('.arma-item[category="' + pegArma + '"]').css('transform', 'scale(1)');
	}
	setTimeout(showArma, 100);
  });
  
  $('.category_arma[category="all"]').click(function() {
	function showAll() {
		$('.arma-item').show();
		$('.arma-item').css('transform', 'scale(1)');
	}
	setTimeout(showAll, 100);
  });
  
