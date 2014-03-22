function selecionar_cupom(id){
	$.getJSON(selecionar_url + id,function(usuario) {
			humanMsg.displayMsg("Usuario " + usuario.nome + " selecionado!");	
	});

}
