class_name Player extends CharacterBody2D

const BULLET = preload("res://Scenes/bullet.tscn")

@export var speed: float = 100.0
@export var dir: int = 0

@onready var anim: AnimationPlayer = $anim
@onready var marker_top = $marker_top
@onready var marker_left: Marker2D = $marker_left_side
@onready var marker_right: Marker2D = $marker_right_side

@export var default_cd: float = .15
var fire_cooldown: float
var delay: float
var shots_fired: bool = false
var is_bursting: bool = false

enum Weapon { BASIC, DOUBLE, TRIPLE, BURST }
var weapon_type: Weapon = Weapon.BASIC

func _ready() -> void:
	#set all stats back to default
	Gamemanager.reset_stats()
	delay = default_cd

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
	select_weapon()
	
	if Input.is_action_pressed("shoot"):
		if shots_fired == false:
			current_weapon()
	
	shot_delay(delta)
	

func shot_delay(delta:float):
	if shots_fired == true:
		fire_cooldown -= delta
		if fire_cooldown <= 0.0:
			shots_fired = false
			fire_cooldown = delay

func basic_shot():
	spawn_shot(marker_top)
	shots_fired = true

func double_lasers():
	spawn_shot(marker_left)
	spawn_shot(marker_right)
	shots_fired = true
	

func spawn_shot(marker: Marker2D):
	var blt = BULLET.instantiate()
	blt.global_position = marker.global_position
	get_tree().current_scene.add_child(blt)

func triple_lasers():
	spawn_shot(marker_top)
	spawn_shot(marker_left)
	spawn_shot(marker_right)
	shots_fired = true

func burst_lasers():
	if is_bursting:
		return
	
	is_bursting = true
	
	var number_of_shots: int = 5
	for i in number_of_shots:
		spawn_shot(marker_top)
		await get_tree().create_timer(.1).timeout
	
	is_bursting = false
	shots_fired = true

func select_weapon():
	if Input.is_action_just_pressed("option_1"):
		weapon_type = Weapon.BASIC
		delay = .15
	if Input.is_action_just_pressed("option_2"):
		weapon_type = Weapon.DOUBLE
		delay = .25
	if Input.is_action_just_pressed("option_3"):
		weapon_type = Weapon.TRIPLE
		delay = .35
	if Input.is_action_just_pressed("option_4"):
		weapon_type = Weapon.BURST
		delay = 1

func current_weapon():
	match weapon_type:
		Weapon.BASIC:
			basic_shot()
		Weapon.DOUBLE:
			double_lasers()
		Weapon.TRIPLE:
			triple_lasers()
		Weapon.BURST:
			burst_lasers()
