extends CharacterBody2D

const SPEED = 250.0

@export var bullet : PackedScene

@onready var world_border_left = %WorldBorderLeft
@onready var world_border_right = %WorldBorderRight

var health = 4
var bullets = 4

func _physics_process(delta):

	if Input.is_action_just_pressed("shoot"):
		if(bullets > 0):
			spawn_bullet()
			bullets -= 1
			await get_tree().create_timer(4).timeout
			bullets += 1

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)
	
	move_and_slide()

func _on_world_border_left_body_entered(body):
	if(body.name == "CharacterBody2D"):
		body.position.x = world_border_right.position.x - 20

func _on_world_border_right_body_entered(body):
	if(body.name == "CharacterBody2D"):
		body.position.x = world_border_left.position.x + 20

func spawn_bullet():
	var bullet_node = bullet.instantiate()
	bullet_node.position = position
	get_parent().add_child(bullet_node)

func damage():
	health -= 1
	update_look()
	if(health == 0):
		get_tree().reload_current_scene()

func update_look():
	pass
