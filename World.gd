extends Node

func _process(delta):
	pass


func nuevo_juego():
	$Character/player.life=100
	$Character/player2.life=100
	$Character/player.inicio($PosicionInicio.position)
	$Character/player2.inicio($PosicionInicio2.position)




func game_over():	
	$Interfaz.game_over()