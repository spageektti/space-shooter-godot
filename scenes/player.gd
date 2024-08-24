extends CharacterBody2D

const SPEED = 250.0

@onready var world_border_left = %WorldBorderLeft
@onready var world_border_right = %WorldBorderRight

func _physics_process(delta):

	if Input.is_action_just_pressed("shoot"):
		pass

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)
	
	print(world_border_right.position.x)
	print(world_border_left.position.x)
	
	move_and_slide()

func _on_world_border_left_body_entered(body):
	if(body.name == "CharacterBody2D"):
		body.position.x = world_border_right.position.x - 20

func _on_world_border_right_body_entered(body):
	if(body.name == "CharacterBody2D"):
		body.position.x = world_border_left.position.x + 20
