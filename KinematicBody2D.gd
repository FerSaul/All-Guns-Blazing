extends KinematicBody2D


const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200
const JUMP_HIGH = -600
var motion = Vector2()
var dir_bala = 1
var life = 100
var bullet = load("res://FireBall.tscn")


func _process(delta):
	motion.y += GRAVITY
	_death()
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		dir_bala = 1
		$pos_bala.global_position.x = self.global_position.x + 32
		$Sprite.flip_h = false
		$Sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		dir_bala = -1
		$pos_bala.global_position.x = self.global_position.x - 32
		$Sprite.flip_h = true
		$Sprite.play("run")
	else:
		motion.x = 0
		$Sprite.play("stand")
	
		
	if Input.is_action_just_pressed("disparar"):
		_disparar(dir_bala)
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HIGH
	else:
		$Sprite.play("air")
	motion = move_and_slide(motion, UP)	
	#print(motion)
	pass
	
func _disparar(dir):
	var newBullet = bullet.instance()
	get_parent().add_child(newBullet)
	newBullet.global_position = $pos_bala.global_position
	newBullet.dir = dir
	
func _damage(dm):
	life -=dm
	#print(dm)
	
func _death():
	if life <= 0 :
		self.queue_free()