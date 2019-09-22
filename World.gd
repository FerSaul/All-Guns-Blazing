extends Node

var box = load("res://Caja.tscn")

func _process(delta):
	pass


func nuevo_juego():
	$Character/player.life=100
	$Character/player2.life=100
	$Character/player.inicio($PosicionInicio.position)
	$Character/player2.inicio($PosicionInicio2.position)
	generarCajas()


func generarCajas():
	var newBox1 = box.instance()
	get_parent().add_child(newBox1)
	newBox1.global_position = $Boxes/Caja1.global_position
	newBox1.type = (randi()%2) + 1
	var newBox2 = box.instance()
	get_parent().add_child(newBox2)
	newBox2.global_position = $Boxes/Caja2.global_position
	newBox2.type = (randi()%2) + 1
	var newBox3 = box.instance()
	get_parent().add_child(newBox3)
	newBox3.global_position = $Boxes/Caja3.global_position
	newBox3.type = (randi()%2) + 1
	var newBox4 = box.instance()
	get_parent().add_child(newBox4)
	newBox4.global_position = $Boxes/Caja4.global_position
	newBox4.type = (randi()%2) + 1
	var newBox5 = box.instance()
	get_parent().add_child(newBox5)
	newBox5.global_position = $Boxes/Caja5.global_position
	newBox5.type = (randi()%2) + 1
	

func game_over():	
	$Interfaz.game_over()