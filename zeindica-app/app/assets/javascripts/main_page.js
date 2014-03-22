function infinite_scroll(){
		
		var page = 2;
     		loading = false;
			


	function nearBottomOfPage() {
    return $(window).scrollTop() > $(document).height() - $(window).height() - 380;
  }
	
  $(window).scroll(function(){

    if (loading) {
      return;
    }
		
    if(nearBottomOfPage()) {
	    loading=true;
      $.ajax({
        url: '/?page=' + page,
        type: 'get',
        dataType: 'script',
        success: function() {
					page++;
					$(window).sausage('draw');
          loading=false;
        }
      });
    }
  });

 $(window).sausage();

	if($(".imagem_nuvem").length <= 5){
		$("body").css("overflow", "hidden");
	}



}

//Plugin para contruir a janela modal com informações sobre o produto.
(function( $ ){

	//tempo em segundos que o contador espera  
	var start_counter = 20;


	$.ajax_modal = function(info_path) {
  	$.getJSON( info_path, function(data) {
		
			create_dialog(data);	
			overlay($(".ui-widget-overlay"), "show");
		});
  };


	/*
	 função que lida com o overlay(tela atrás do modal)
	 mostra e esconde o div do overlay
	*/
	function overlay(element, method){
		if(method == "show"){
				element.delay(180).fadeIn(600);
		}else if(method == "hide"){
					//gambiarra para que o overlay desapareço de forma mais bonita
					$(".ui-widget-overlay").hide()
											   			   .clone()
																 .appendTo('body')
																 .show()
																 .fadeOut(500, function(){
																		$(this).remove();
																 });
		}else{
			alert("O método " + method + " não existe.");
		}
	}
	

	/*
		Cria e configura o modal dialog
	*/
	function create_dialog(info){
			var info_dialog = $("<div class='info' title='Sorteio dia "+info.sorteio+"'></div>");			
					
			if(info.logado)
					counter = start_count_to_show_link_participar();
			
			info_dialog.dialog({
				modal: true,
				draggable: false,
				resizable: false,
				height: "auto",
				width:  $(window).width()*0.65 + "px",
    		show: "blind",
    		hide: "blind",
				position: ['top',$(window).height()*0.055],
				beforeClose: function(event, ui) {				
					if($('h3.participar .depositar').length > 0){
						if (!confirm("Deseja sair sem depositar seu cupom?")) { 
 							return false;
						}
					}
					overlay($(".ui-widget-overlay"), "hide");
					$(this).slideUp();
					return true;
				},
				close: function(event, ui) {
					$(this).dialog("destroy")
					$(this).remove();
					clearInterval(counter);
					$.getJSON('/cupons', function(data) {
						if(!data)
							humanMsg.displayMsg('O seu cupon não foi depositado.', false);
					});

					return false;
				}
  		});	
			
			info_dialog.append(create_div_esq(info.imagem_info, info.descricao, info.logado)); 

			imagem_topo = {"imagem":info.imagem_topo, "link":info.link_to_imagem_topo};
			imagem_meio = {"imagem":info.imagem_meio, "link":info.link_to_imagem_meio};
			imagem_inferior = {"imagem":info.imagem_inferior, "link":info.link_to_imagem_inferior};
			info_dialog.append(create_div_dir(imagem_topo, imagem_meio, imagem_inferior));

		return info_dialog;
	}

	/*
		Cria o div da esquerda
		Div com informações sobre o prêmio 
	*/
	function create_div_esq(imagem_info, descricao, logado){
		var	img_info = $("<img src='"+imagem_info+"'/>");
				descricao_div = $("<div>"+descricao+"</div>");
				div_esq = $("<div class='esq'></div>");
				div_esq.append(participar_info(logado));
				div_esq.append(img_info);
				div_esq.append(descricao_div);

		div_esq.hide().delay(300).slideDown(1000);
		return div_esq;
	}


	/*
		Verifica se o usuário esta logado para pedir para logar
	*/
	function participar_info(logado){
		var	participar =  $("<h3 class='participar'></h3>");
		if(logado){
			participar.append("Gerando o seu cupom em <span>"+start_counter+"</span>");
		}else{
			participar.append("Conecte-se com o ");
			participar.append(get_facebook_link());
			participar.append(" para concorrer");
		}
		return participar;

	}

	/*
		Checar se a váriavel facebook_link existe para não dar erro
		recarrega a página se o facebook_link não existe
		Se o usuário mandar limpar o browser pode acontecer esse erro.
	*/
	function get_facebook_link(){	
		if(typeof facebook_link === 'undefined')	
				window.location.reload();
				
		return facebook_link;
	}

	function get_cupons_path(){
		if(typeof cupons_path === 'undefined')	
				window.location.reload();
				
		return cupons_path;
	}

	/*
		Contador para mostrar o link após um certo tempo
	*/
	function 	start_count_to_show_link_participar(){
		var cnt = start_counter;
				counter = setInterval(function() {		
         		if (cnt > 0) {
            	$('.participar span').html(cnt);
              cnt--;
             }else {
							 clearInterval(counter);
							 //para gerar o cupon no controller
							 $.ajax({
    						type: "POST",
    						url: get_cupons_path(),
    						dataType: 'script'
  						});             
						}
          }, 1000);
			return counter;
	}

	/*
		Cria o div da direita
		Div com propagandas da empresa que ofereceu o prêmio 
	*/
	function create_div_dir(imagem_topo, imagem_meio, imagem_inferior){ 
		
		img_topo = return_dir_ad(imagem_topo);
		img_meio = return_dir_ad(imagem_meio);	
		img_inferior = return_dir_ad(imagem_inferior);

		div_dir = $("<div class='dir'></div>");
		div_dir.append(img_topo);
		div_dir.append(img_meio);
		div_dir.append(img_inferior);

		div_dir.hide().delay(300).slideDown(1000);
		return div_dir;	
	}


	function return_dir_ad(imagem_info){
		if(imagem_info.link.length > 4){
			return $("<a href='"+imagem_info.link+"' target='_blank'><img src='"+imagem_info.imagem+"'/></a>");
		}else{
			return $("<img src='"+imagem_info.imagem+"'/>");
		}
	
	}


})( jQuery );
