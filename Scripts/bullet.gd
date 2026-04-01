extends Area2D

var direction:= Vector2.UP
@export var speed: float = 250.0

func _physics_process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	queue_free()
