extends KinematicBody2D

var dir_x = 0
var dir_y = 0
var speed = 1000
var damage = 5

func _process(delta):
	var move = move_and_collide(Vector2(dir_x*speed*delta,dir_y*speed*delta))

	if dir_x < 0:
		$Sprite.flip_h = true		

	if move != null:
		self.queue_free()
	
	if move:
		if move.collider.has_method("_damage"):
			move.collider._damage(damage)
		if move.collider.has_method("_electroShock"):
			move.collider._electroShock()
	
	if global_position.x > 1280 || global_position.x < 0:
		self.queue_free()