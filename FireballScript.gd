extends KinematicBody2D

var dir_x = 0
var dir_y = 0
var speed = 500
var damage = 10

func _process(delta):
	var move = move_and_collide(Vector2(dir_x*speed*delta,dir_y*speed*delta))

	if dir_x < 0:
		$Sprite.flip_h = true
		$Sprite/Particles2D

	if move != null:
		self.queue_free()
	
	if move:
		if move.collider.has_method("_damage"):
			move.collider._damage(damage)
		if move.collider.has_method("_burn"):
			move.collider._burn()
	
	if global_position.x > 1280 || global_position.x < 0:
		self.queue_free()