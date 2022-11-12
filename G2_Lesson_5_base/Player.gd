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
	
	# make label
	health_label = Label.new()
	health_label.text = "HP: " + str(player_health)
	get_parent().call_deferred("add_child", health_label)
	
	ammo_label = Label.new()
	ammo_label.text = "Ammo: " + str(ammo)
	get_parent().call_deferred("add_child", ammo_label)
	
func _process(delta):
	health_label.set_global_position(position + Vector2(-40, -45))
	ammo_label.set_global_position(position + Vector2(-400, 250))
	
	velocity = Vector2.ZERO
	if Input.is_action_pressed("DOWN"):
		velocity.y += speed
	if Input.is_action_pressed("UP"):
		velocity.y -= speed
	if Input.is_action_pressed("RIGHT"):
		velocity.x += speed
	if Input.is_action_pressed("LEFT"):
		velocity.x -= speed
		
	if Input.is_action_just_pressed("SHOOT"):
		if ammo > 0:
			var b = bullet.instance()
			b.dir = rotation
			b.rotation = rotation
			b.global_position = firepoint.global_position
			get_parent().add_child(b)
			ammo -= 1
			ammo_label.text = "Ammo: " + str(ammo)
			
	velocity = move_and_slide(velocity.normalized() * speed)
	look_at(get_global_mouse_position())
	
	new_playerPos = global_position - old_playerPos
	old_playerPos = global_position
