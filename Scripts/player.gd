class_name Player extends CharacterBody2D

const BULLET = preload("res://Scenes/bullet.tscn")

@export var speed: float = 100.0
@export var dir: int = 0

@onready var anim: AnimationPlayer = $anim
@onready var marker_top = $marker_top

@export var default_cd: float = .15
var fire_cooldown: float
var shots_fired: bool = false

func _ready() -> void:
	#set all stats back to default
	Gamemanager.reset_stats()

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
	
	if Input.is_action_pressed("shoot"):
		if shots_fired == false:
			var blt = BULLET.instantiate()
			blt.global_position = marker_top.global_position
			get_tree().current_scene.add_child(blt)
			shots_fired = true
	
	#apply delay between shots
	shot_delay(default_cd ,delta)

func shot_delay(delay:float, delta:float):
	if shots_fired == true:
		fire_cooldown -= delta
		if fire_cooldown <= 0.0:
			shots_fired = false
			fire_cooldown = delay
