extends CanvasLayer

signal iniciar_juego

func game_over():
	$Button.show()
	$LblTitulo.show()
	


func _on_Button_pressed():
	$Button.hide()
	$LblTitulo.hide()
	emit_signal("iniciar_juego")
	
	pass # Replace with function body.
