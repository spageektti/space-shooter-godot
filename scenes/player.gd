extends CharacterBody2D

const SPEED = 250.0

@export var bullet : PackedScene
@export var next_level : PackedScene

@onready var animation = $AnimatedSprite2D
@onready var world_border_left = %WorldBorderLeft
@onready var world_border_right = %WorldBorderRight
@onready var enemies = %enemies

var health = 4
var bullets = 4
var can_win
var frames = 0

@onready var nodes = enemies.get_children()

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

func _process(delta):
	frames += 1
	if(frames % 240 == 0): # 60fps * 4, so at most 4 seconds delay after win
		nodes = enemies.get_children()
		can_win = true
		for node in nodes:
			if(node.name.begins_with("enemy")):
				if(not node.can_win):
					can_win = false
					break
		if(can_win):
			print("Won!")
			queue_free()		

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
	if(health == 4):
		animation.play("default")
	elif(health == 3):
		animation.play("slightly-damaged")
	elif(health == 2):
		animation.play("damaged")
	elif(health == 1):
		animation.play("very-damaged")
