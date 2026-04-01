extends Area2D

@export var speed: float = 50.0
var dir = Vector2.UP

func _process(delta: float) -> void:
	position -= speed * dir * delta
