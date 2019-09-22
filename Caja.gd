extends KinematicBody2D

var type = 1

func _process(delta):
	#gravedad cajas
	var move = move_and_collide(Vector2(0,0))
	
	if move:
		if move.collider.has_method("_weapon"):
			move.collider._weapon(type)
			self.free()
	
	pass
