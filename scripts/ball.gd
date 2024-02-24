extends RigidBody2D

var velocity = Vector2(0, 0)
var speed = 300
@export var speed_increase = 50
var direction_x
var direction_y 
var paddle_hit = false

signal offscreen
signal player_paddle_bounce
signal AI_paddle_bounce

# Called when the node enters the scene tree for the first time.
func _ready():
	direction_x = [-1, 1][randi() % [-1, 1].size()]  # random index from array
	direction_y = randf_range(-0.8, 0.8) 
	velocity.x = direction_x * speed
	velocity.y = direction_y * speed
	move_and_collide(velocity)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	if paddle_hit:
		if velocity.x > 0: # going right
			velocity += Vector2(speed_increase,speed_increase)  # go right faster (more positive)
		elif velocity.x < 0:  # going left
			velocity -= Vector2(speed_increase,speed_increase)  # go left faster (more negative)
		paddle_hit = false


func _on_area_2d_area_entered(area):
	if area.get_parent().is_in_group("Paddle"):
		paddle_hit = true
		$Sound_Beep.play()
		if area.get_parent().is_in_group("Player"):  # only emit to compute AI when Player Paddle is bounced
			player_paddle_bounce.emit()
		elif area.get_parent().is_in_group("AI"):  # only emit to compute AI when Player Paddle is bounced
			AI_paddle_bounce.emit()
		
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("Wall"):
		$Sound_ShortBeep.play()
