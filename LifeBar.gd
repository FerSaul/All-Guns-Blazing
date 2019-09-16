extends Control

onready var life_bar = $LifeBar

func _on_health_updated(life):
	life_bar.value = life
	
func _on_max_health_updated(max_health):
	life_bar.max_value = max_health