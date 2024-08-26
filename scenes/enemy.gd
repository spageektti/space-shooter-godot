extends RigidBody2D

@export var bullet : PackedScene
@export var moving_x : bool
@export var moving_y : bool

@export var speed_x : float = 100.0
@export var speed_y : float = 100.0

var direction = 0 # 0 left 1 right

func _process(delta):
	var velocity = Vector2(0, 0)
	velocity.x = speed_x * delta if moving_x else 0
	velocity.y = speed_y * delta if moving_y else 0
	
	set_axis_velocity(velocity)
