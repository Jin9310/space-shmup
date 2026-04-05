class_name GameUI extends Control

@onready var player_hp_lbl: Label = $CanvasLayer/Control/Player_hp_lbl
@onready var score_lbl: Label = $CanvasLayer/Control/Score_lbl
@onready var you_died_lbl: Label = $CanvasLayer/Control/You_died_lbl

func _ready():
	player_hp_lbl.text = "hp " + str(Gamemanager.player_hp)
	Gamemanager.hp_changed.connect(_on_hp_changed)
	Gamemanager.score_changed.connect(_on_score_changed)

func _process(delta):
	if Gamemanager.dead:
		you_died_lbl.visible = true
		you_died_lbl.text = "You died. Press [R] to restart"
	else:
		you_died_lbl.visible = false

func _on_hp_changed(new_hp: int):
	player_hp_lbl.text = "hp " + str(new_hp)

func _on_score_changed(new_score: int):
	score_lbl.text = "score: " + str(new_score)
