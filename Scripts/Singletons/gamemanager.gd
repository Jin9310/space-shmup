extends Node

signal hp_changed(new_hp)
signal score_changed(new_score)

var player_hp: int
var base_player_hp: int = 5
var dead: bool = false
var score: int = 0

func reset_stats():
	player_hp = base_player_hp
	dead = false
	score = 0

func player_got_hit(amount: int):
	player_hp -= amount
	hp_changed.emit(player_hp)
	if player_hp <= 0:
		dead = true

func get_score(points: int, multiplier: int):
	score += points * multiplier
	score_changed.emit(score)
