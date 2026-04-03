class_name GameUI extends Control

@onready var player_hp = $Player_hp_lbl
@onready var score_lbl = $Score_lbl
@onready var you_died_lbl = $You_died_lbl

func _ready():
	player_hp.text = "hp " + str(Gamemanager.player_hp)
	Gamemanager.hp_changed.connect(_on_hp_changed)

func _process(delta):
	score_lbl.text = "score: " + str(Gamemanager.score)
	if Gamemanager.dead:
		you_died_lbl.visible = true
		you_died_lbl.text = "You died. Press [R] to restart"
	else:
		you_died_lbl.visible = false

func _on_hp_changed(new_hp: int):
	player_hp.text = "hp " + str(new_hp)
