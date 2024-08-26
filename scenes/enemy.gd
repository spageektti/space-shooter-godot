extends RigidBody2D

@onready var player = %CharacterBody2D

@export var bullet : PackedScene
@export var health : int = 4

@export var moving_x : bool
@export var moving_y : bool
@export var speed_x : float = 100.0
@export var speed_y : float = 100.0

var direction = -1 # -1 left 1 right

func _process(delta):
	position.x += direction * speed_x * delta if moving_x else 0
	position.y += speed_y * delta if moving_y else 0
	

func damage():
	health -= 1
	print("Enemy damaged")
	if(health == 0):
		print("Enemy destroyed")
		queue_free()

func _on_world_border_right_body_entered(body):
	direction = -1

func _on_world_border_left_body_entered(body):
	direction = 1
