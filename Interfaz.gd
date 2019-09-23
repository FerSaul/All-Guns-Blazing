extends CanvasLayer

signal iniciar_juego

func game_over():
	$Button.show()
	$LblTitulo.show()
	
	


func _on_Button_pressed():
	$Button.hide()
	$LblTitulo.hide()
	$Bar.visible=true
	$Bar/ProgressBar.value=100
	$Bar2.visible=true
	$Bar2/ProgressBar.value=100
	emit_signal("iniciar_juego")
	
	
	pass # Replace with function body.
