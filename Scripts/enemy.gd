extends Area2D

@export var speed: float = 25.0
var hp: int = 3
var dir = Vector2.DOWN

func _process(delta: float) -> void:
	position += speed * dir * delta

func death():
	#might add some explosion animation
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	#collisions with shots
	print("hit")
	hp -= 1
	if hp <= 0:
		death()
	
	if area is OffScreen:
		death()

func _on_body_entered(body: Node2D) -> void:
	#collisions with player
	print("hit 2")
	Gamemanager.player_hp -= 1
	hp -= 1
	if hp <= 0:
		death()
