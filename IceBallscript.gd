extends KinematicBody2D

var dir_x = 0
var dir_y = 0
var speed = 500
var damage = 10

func _process(delta):
	var move = move_and_collide(Vector2(dir_x*speed*delta,dir_y*speed*delta))
	$Sprite/Particles2D.process_material.gravity = Vector3(-180, 80, 0)
	if dir_x == 0 and dir_y == 1:
		$Sprite/Particles2D.process_material.gravity = Vector3(0, 80, 0)
	
	if dir_x < 0:
		$Sprite.flip_h = true		
		$Sprite/Particles2D.process_material.gravity = Vector3(180, 80, 0)
	if move != null:
		self.queue_free()
	
	if move:
		if move.collider.has_method("_damage"):
			move.collider._damage(damage)
	
	if global_position.x > 1280 || global_position.x < 0:
		self.queue_free()