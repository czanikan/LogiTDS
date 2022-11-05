extends KinematicBody2D

var bullet: PackedScene

var speed = 200
var velocity = Vector2()

var old_playerPos
var new_playerPos = Vector2(1, 1)

var player_health = 200
var health_label

var ammo = 50
var ammo_label
onready var firepoint = $FirePoint

func _ready():
	set_process(true)
	bullet = load("res://Scenes/Bullet.tscn")
	old_playerPos = global_position
