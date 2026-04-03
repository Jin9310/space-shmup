class_name BasicEnemy extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var change_direction: Timer = $Change_direction

@export var speed: float = 25.0
var hp: int = 3

#MOVEMENT
var dir_down = Vector2.DOWN
var dir_up = Vector2.UP
var dir_left = Vector2.LEFT
var dir_right = Vector2.RIGHT
var enemy_go_to: int = 0
#0 = go down
#1 = go up
#2 = go left
#3 = go right
#I want to make sure that the enemy will not go out from the screen 
#so it can change the UP direction only once
var times_went_up: int = 0

#I want to separate collision with player and enemy shooting at player
#those will deal different amounts of damage
var collision_with_player_dmg: int = 2

func _ready() -> void:
	#just for testing purposes as I dont have a sprite of an enemy now
	sprite_2d.modulate = Color.RED

func _process(delta: float) -> void:
	#move only when alive
	if hp > 0:
		enemy_moveset(delta)

func death():
	#changing the scale is now a placeholder for future death animation
	sprite_2d.scale = Vector2(.2, .2)
	Gamemanager.get_score(10)
	await get_tree().create_timer(2).timeout
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	# collisions with shots
	if area is not RightInvisibleWall and area is not LeftInvisibleWall and area is not BasicEnemy:
		hp -= 1
		if hp <= 0:
			#disable colliders when dead
			collision_shape_2d.set_deferred("disabled", true)
			death()
	
	# kill when went down offscreen
	if area is OffScreen:
		death()
	
	# collision with "Right and left wall"
	# just making the boundaries
	if area is RightInvisibleWall:
		#print("right wall collision")
		enemy_go_to = 2
		# visual helper to see if it works 
		sprite_2d.modulate = Color.GREEN
	
	if area is LeftInvisibleWall:
		#print("left wall collision")
		enemy_go_to = 3
		# visual helper to see if it works 
		sprite_2d.modulate = Color.YELLOW

func _on_body_entered(body: Node2D) -> void:
	# collisions with player
	# created the damage to player into singleton function
	Gamemanager.player_got_hit(collision_with_player_dmg)
	hp -= 1
	if hp <= 0:
		death()

func enemy_moveset(delta: float):
	#want to simulate some basic random moving pattern 
	match enemy_go_to:
		0:
			position += speed * dir_down * delta
		1:
			if times_went_up < 1:
				position += speed * dir_up * delta
			else:
				position += speed * dir_down * delta
		2:
			position += speed * dir_left * delta
		3:
			position += speed * dir_right * delta
	

func _on_change_direction_timeout() -> void:
	var random_number = randi_range(0,3)
	enemy_go_to = random_number
	
	if random_number == 1:
		times_went_up += 1
