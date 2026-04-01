extends Area2D

var direction:= Vector2.UP
var speed: float = 250.0

func _physics_process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()
