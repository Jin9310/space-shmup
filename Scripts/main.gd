class_name Main extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("reset") and Gamemanager.dead:
		get_tree().reload_current_scene()
