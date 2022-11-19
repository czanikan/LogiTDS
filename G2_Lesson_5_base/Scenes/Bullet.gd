extends Area2D

var dir = 0
var bullet_speed = 10
var bullet_damage = 20

func _process(delta):
	var move_dir = Vector2(1, 0).rotated(dir)
	global_position += bullet_speed * move_dir


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.name == "Player":
		body.player_health -= bullet_damage
		body.health_label.text = "HP: " + str(body.player_health) 
		if body.player_health <= 0:
			body.set_process(false)
