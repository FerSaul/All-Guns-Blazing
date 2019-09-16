extends KinematicBody2D

var dir = 0
var speed = 500
var damage = 10

func _process(delta):
	var move = move_and_collide(Vector2(dir*speed*delta,0))
	if dir < 0:
		$Sprite.flip_h = true
		
	if move != null:
		#if move.collider.is_in_group("jugador"):
		#	move.collider.queue_free()
		
		self.queue_free()
	
	if move:
		if move.collider.has_method("_damage"):
			move.collider._damage(damage)
	
	if global_position.x > 1280 || global_position.x < 0:
		self.queue_free()