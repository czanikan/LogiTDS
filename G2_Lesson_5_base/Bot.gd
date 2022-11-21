extends KinematicBody2D

var speed = 50

var bot_health = 100
var health_label

var radius = 350
var shoot_radius = 275
onready var firepoint = $FirePoint

var bullet: PackedScene
onready var player = get_tree().get_root().get_node("MainScene/Player")
