extends Area2D

func _process(delta):
	position.y -= delta * 100

func _on_body_entered(body):
	if(body.name != "CharacterBody2D"): # the bullet was sent by player
		body.damage()
		print("destroy bullet")
		queue_free()

func _on_area_entered(area):
	print("destroy bullet")
	queue_free()
