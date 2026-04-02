extends Node

var player_hp: int
var base_player_hp: int = 5
var dead: bool = false

func reset_stats():
	player_hp = base_player_hp
	dead = false

func player_got_hit(amount: int):
	player_hp -= amount
	if player_hp <= 0:
		dead = true
