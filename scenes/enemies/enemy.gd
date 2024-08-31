extends RigidBody2D

@onready var sound_player = $AudioStreamPlayer2D
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

@export var enemy_list : Array[Node]

@export var bullet_spawn_sound : AudioStream

var bullets = 1
var direction = -1 # -1 left 1 right
var can_win = false

func _ready():
	randomize()
	
	for enemy in enemy_list:
		if(enemy != null):
			enemy.hide()
			enemy.freeze = true

func _process(delta):
	position.x += direction * speed_x * delta if moving_x else 0
	position.y += speed_y * delta if moving_y else 0
	if(bullets > 0 and not freeze):
		spawn_bullet()

func spawn_bullet():
	var bullet_node = bullet.instantiate()
	bullet_node.position = position
	bullet_node.direction = 1
	bullet_node.rotation = deg_to_rad(180)
	bullet_node.damage = damage_amount
	get_parent().add_child(bullet_node)
	
	if bullet_spawn_sound:
		sound_player.stream = bullet_spawn_sound
		sound_player.play()

	bullets -= 1
	await get_tree().create_timer(randf_range(timeout_min, timeout_max)).timeout
	bullets += 1

func damage():
	if(not freeze):
		health -= 1
		print("Enemy damaged")
		if(health == 0):
			print("Enemy destroyed")
			if(not enemy_list.is_empty() and enemy_list[0] != null):
				print("next enemy")
				var enemy_node = enemy_list[0]
				enemy_node.show()
				enemy_node.freeze = false
			can_win = true
			hide()
			freeze = true

func _on_enemy_area_entered(area):
	if(area.name.begins_with("WorldBorder")):
		direction *= -1
