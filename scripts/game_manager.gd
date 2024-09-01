extends Node3D

@export var player_blue: ShipController
@export var player_red: ShipController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_blue.died.connect(_blue_dead)
	player_red.died.connect(_red_dead)

	
func _blue_dead() -> void:
	print_rich("[color=blue]BLUE[/color] is dead")
	
	
func _red_dead() -> void:
	print_rich("[color=red]RED[/color] is dead")
	
	
