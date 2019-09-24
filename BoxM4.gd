extends KinematicBody2D

var type = 1

func _ready():
	hide()

func _process(delta):
	#gravedad cajas
	var move = move_and_collide(Vector2(0,0))
	
	if move:
		if move.collider.has_method("_weapon"):
			move.collider._weapon(type)
			move.collider.boost()
			_remover()
			#self.queue_free()
	
	pass
	
func _remover():
	$CollisionShape2D.disabled=true
	hide()
	#self.queue_free()

func inicio(pos):
	position=pos
	$CollisionShape2D.disabled=false
	show()