extends CharacterBody2D

@export var speed: float = 100.0
@onready var anim: AnimationPlayer = $anim
@export var dir: int = 0

func get_input():
	var input_direction = Input.get_vector("left", "right", "forward", "backward")
	velocity = input_direction * speed
	
	if input_direction.x < 0:
		#print("going left")
		dir = -1
	elif input_direction.x > 0:
		#print("going right")
		dir = 1
	elif input_direction.x == 0:
		#print("straight animation")
		dir = 0
	
	match dir:
		0:
			anim.play("default")
		-1:
			anim.play("move_right")
		1:
			anim.play("move_left")
	#print(input_direction)

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
