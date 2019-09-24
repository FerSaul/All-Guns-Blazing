extends KinematicBody2D
var set1 = ["ui_right","ui_left","disparar","ui_up","agacharse1"]
var set2 = ["derecha","izquierda","disparar2","saltar","agacharse2"]

const UP = Vector2(0,-1)
const GRAVITY = 20
var SPEED = 200

#Cambio salto de 600 a 400
var JUMP_HIGH = -500
#añadir variable saltos
var saltos = 2
var activo = 0
signal game_over
#onready var timer = get_node("Timer")
signal statush

var motion = Vector2()
var dir_bala_x = 1
var dir_bala_y = 0
var life = 100
var balls = ["res://FireBall.tscn","res://IceBall.tscn","res://ElectroBall.tscn","res://NormalBall.tscn"]
var bullet = load(balls[3])
var estado = 0

func _ready():
	hide()
	activo = 1
	
	
func inicio(pos):
	position = pos
	show()
	activo = 1

func _process(delta):
	if activo == 1:
		motion.y += GRAVITY
		_agacharse()
		_moverse(estado)
		_disparo_agachado(estado)
		_death()
		#actualiza las posiciones
		motion = move_and_slide(motion, UP)	
	#print(motion)

	
func _disparar(dir_x,dir_y):
	var newBullet = bullet.instance()
	get_parent().add_child(newBullet)
	newBullet.global_position = $pos_bala.global_position
	newBullet.dir_x = dir_x
	newBullet.dir_y = dir_y
	
	
func _moverse(estado):

	#movimiento izquierda y derecha
	if Input.is_action_pressed("ui_right") and estado == 0:
		motion.x = SPEED
		dir_bala_x = 1
		$pos_bala.global_position.x = self.global_position.x + 32
		$pos_bala.global_position.y = self.global_position.y
		$Sprite.flip_h = false
		$Sprite.play("run")
	elif Input.is_action_pressed("ui_left") and estado == 0:
		motion.x = -SPEED
		dir_bala_x = -1
		$pos_bala.global_position.x = self.global_position.x - 32
		$pos_bala.global_position.y = self.global_position.y
		$Sprite.flip_h = true
		$Sprite.play("run")
	else:
		motion.x = 0
		$Sprite.play("stand")
	
	#accion de disparar
	if Input.is_action_just_pressed("disparar"):
		_disparar(dir_bala_x,dir_bala_y)
	# saltos
	if is_on_floor():
		saltos = 2
		if Input.is_action_just_pressed("ui_up") and estado == 0:
			motion.y = JUMP_HIGH
			saltos = 1
	else:
		$Sprite.play("air")
		if Input.is_action_just_pressed("ui_up") and saltos > 0 and estado == 0:
			motion.y = JUMP_HIGH +100
			saltos = 0
	
	
func _agacharse():
	if is_on_floor():
		if Input.is_action_just_pressed("agacharse1") and estado == 0:
			estado = 1
			$CollisionShape2D.scale.y = 0.5
			$pos_bala.global_position.y = $pos_bala.global_position.y + 5
		elif Input.is_action_just_pressed("agacharse1") and estado == 1:
			estado = 0
			$CollisionShape2D.scale.y = 1
			$pos_bala.global_position.y = $pos_bala.global_position.y - 5
			dir_bala_y = 0
	
func _disparo_agachado(estado):
	if estado == 1:
		if Input.is_action_just_pressed("ui_right"):
			dir_bala_x = 1
			dir_bala_y = 0
			$pos_bala.global_position.x = self.global_position.x + 32
			$pos_bala.global_position.y = self.global_position.y
		if Input.is_action_just_pressed("ui_left"):
			dir_bala_x = -1
			dir_bala_y = 0
			$pos_bala.global_position.x = self.global_position.x - 32
			$pos_bala.global_position.y = self.global_position.y
		if Input.is_action_just_pressed("ui_up"):
			dir_bala_x = 0
			dir_bala_y = -1
			$pos_bala.global_position.x = self.global_position.x
			$pos_bala.global_position.y = self.global_position.y - 32
		if Input.is_action_just_pressed("ui_up") and  Input.is_action_just_pressed("ui_right"):
			dir_bala_x = 1
			dir_bala_y = -1
			$pos_bala.global_position.x = self.global_position.x + 32
			$pos_bala.global_position.y = self.global_position.y - 32
		if Input.is_action_just_pressed("ui_up") and Input.is_action_just_pressed("ui_left"):
			dir_bala_x = -1
			dir_bala_y = -1
			$pos_bala.global_position.x = self.global_position.x - 32
			$pos_bala.global_position.y = self.global_position.y - 32
		
	
func _damage(dm):
	life -=dm
	#print(dm)
	
func _death():
	if life <= 0 :
		activo = 0
		hide()
		emit_signal("game_over")

		#self.queue_free()
func _frost():
	self.SPEED = 50
	$Sprite.self_modulate=Color(0,0,1)
	$Timer.start()
	
func _burn():
	#$Sprite.modulate("f22043")
	life -= 30
	#$Timer.start()
	
func _electroShock():
	JUMP_HIGH = 0
	$Timer.start()
	$Sprite.self_modulate=Color(0,1,0)

	
func _defrost():
	self.SPEED = 200
	$Sprite.self_modulate=Color(1,1,1)

	
#func _deburn():
#	life -= 30
func boost():
	$Boost.start()
	

	
func _deelectroShock():
	self.JUMP_HIGH = -500
	$Sprite.self_modulate=Color(1,1,1)


	
func _weapon(n):
	bullet = load(balls[n])
     

func _deBoost():
	bullet = load(balls[3])
	pass # Replace with function body.
