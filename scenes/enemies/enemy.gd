extends RigidBody2D

@onready var player = %CharacterBody2D

@export var bullet : PackedScene
@export var health : int = 4

@export var moving_x : bool
@export var moving_y : bool
@export var speed_x : float = 100.0
@export var speed_y : float = 100.0

@export var timeout_min : float = 0.5
@export var timeout_max : float = 2

@export var damage_amount : int = 1

var bullets = 1
var direction = -1 # -1 left 1 right

func _ready():
	randomize()

func _process(delta):
	position.x += direction * speed_x * delta if moving_x else 0
	position.y += speed_y * delta if moving_y else 0
	if(bullets > 0):
			var bullet_node = bullet.instantiate()
			bullet_node.position = position
			bullet_node.direction = 1
			bullet_node.rotation = deg_to_rad(180)
			bullet_node.damage = damage_amount
			get_parent().add_child(bullet_node)
			bullets -= 1
			await get_tree().create_timer(randf_range(timeout_min, timeout_max)).timeout
			bullets += 1

func damage():
	health -= 1
	print("Enemy damaged")
	if(health == 0):
		print("Enemy destroyed")
		queue_free()

func _on_world_border_left_area_entered(area):
	print(area.name)
	direction = 1


func _on_world_border_right_area_entered(area):
	print(area.name)
	direction = -1
