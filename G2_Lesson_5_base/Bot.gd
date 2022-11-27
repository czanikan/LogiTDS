extends KinematicBody2D

var speed = 50

var bot_health = 100
var health_label

var radius = 350
var shoot_radius = 275
onready var firepoint = $FirePoint

var bullet: PackedScene
onready var player = get_tree().get_root().get_node("MainScene/Player")

func _ready():
	bullet = load("res://Scenes/Bullet.tscn")
	
	health_label = Label.new()
	health_label.name = "EnemyLabel"
	health_label.text = "HP: " + str(bot_health)
	get_parent().call_deferred("add_child", health_label)
	
func _process(delta):
	health_label.set_global_position(position + Vector2(-40, -45))
	
	if player.position.distance_to(position) < radius:
		var distance = global_position.distance_to(player.global_position)
		look_at(player.global_position + player.new_playerPos * (distance/BulletSingleton.bullet_speed))
		var dir = global_rotation
		var velocity = Vector2(1, 0).rotated(dir)
		velocity = move_and_slide(velocity.normalized() * speed)

func _on_Timer_timeout():
	if player.player_health > 0:
		if player.position.distance_to(position) < shoot_radius:
			var b = bullet.instance()
			b.rotation = rotation
			b.dir = rotation
			b.global_position = firepoint.global_position
			get_parent().add_child(b)
