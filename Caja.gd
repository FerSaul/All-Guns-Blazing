extends KinematicBody2D

var type = 1

func _process(delta):
	var move = move_and_collide(Vector2(0,20))
	
	#if move.collider.has_method("_weapon"):
	#	move.collider._weapon(type)
	
	pass
