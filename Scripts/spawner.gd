extends Node2D

const ENEMY = preload("res://Scenes/enemy.tscn")
#marker is just to helper for spawning position
@onready var marker_2d: Marker2D = $Marker2D
@onready var timer: Timer = $Timer

@export var min_x: float = 100.0
@export var max_x: float = 220.0

func _on_timer_timeout() -> void:
	var ene = ENEMY.instantiate()
	#I want to make spawning just within specific area > will add the restrictions to player movement as well
	var random_x = randf_range(min_x, max_x)
	#print(random_x)
	marker_2d.position.x = random_x
	ene.global_position = marker_2d.global_position
	get_tree().current_scene.add_child(ene)
