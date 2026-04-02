class_name GameUI extends Control

@onready var player_hp = $Player_hp

func _process(delta):
	player_hp.text = str(Gamemanager.player_hp)
