extends KinematicBody2D


const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 200

#Cambio salto de 600 a 400
const JUMP_HIGH = -500
#añadir variable saltos
var saltos = 2

var motion = Vector2()
var life = 100
var dir_bala = 1
var bullet = load("res://FireBall.tscn")

func _process(delta):
	motion.y += GRAVITY
	_death()
	
	if Input.is_action_pressed("derecha"):
		motion.x = SPEED
		dir_bala = 1
		$pos_bala.global_position.x = self.global_position.x + 32
		$Sprite.flip_h = false
		$Sprite.play("run")
	elif Input.is_action_pressed("izquierda"):
		motion.x = -SPEED
		dir_bala = -1
		$pos_bala.global_position.x = self.global_position.x - 32
		$Sprite.flip_h = true
		$Sprite.play("run")
	else:
		motion.x = 0
		$Sprite.play("stand")
	
	if Input.is_action_just_pressed("disparar2"):
		_disparar(dir_bala)
		
	if is_on_floor():
		saltos = 2
		if Input.is_action_just_pressed("saltar"):
			motion.y = JUMP_HIGH
			saltos = 1
	else:
		$Sprite.play("air")
		if Input.is_action_just_pressed("saltar") and saltos > 0:
			motion.y = JUMP_HIGH +100
			saltos = 0

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