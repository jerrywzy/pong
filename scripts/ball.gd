extends RigidBody2D

var velocity = Vector2(0, 0)
@export var speed = 800
var direction_x
var direction_y 

signal offscreen

# Called when the node enters the scene tree for the first time.
func _ready():
	direction_x = randf_range(-1, 1) 
	direction_y = randf_range(-1, 1) 
	velocity.x = direction_x * speed
	velocity.y = direction_y * speed
	
	move_and_collide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	print("emit")
	offscreen.emit()
	queue_free()
