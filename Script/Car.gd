extends VehicleBody

############################################################
# behaviour values

export var MAX_ENGINE_FORCE = 200.0
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0

############################################################
# Input

export var joy_steering = ["left","right"]
export var steering_mult = -1.0
export var joy_throttle = ["forward","backward"]
export var throttle_mult = 1.0
export var joy_brake = "brake"
export var brake_mult = 1.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	#var steer_val = steering_mult * Input.get_joy_axis(0, joy_steering)
	var steer_val = steering_mult * (Input.get_action_strength(joy_steering[1]) - Input.get_action_strength(joy_steering[0]))
	#var throttle_val = throttle_mult * Input.get_joy_axis(0, joy_throttle)
	var throttle_val = throttle_mult * (Input.get_action_strength(joy_throttle[0]) - Input.get_action_strength(joy_throttle[1]))
	#var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)
	var brake_val = brake_mult * Input.get_action_strength(joy_brake)
	
	# overrules for keyboard
	if Input.is_action_pressed("ui_up"):
		throttle_val = 1.0
	if Input.is_action_pressed("ui_down"):
		brake_val = 1.0
	if Input.is_action_pressed("ui_left"):
		steer_val = 1.0
	elif Input.is_action_pressed("ui_right"):
		steer_val = -1.0
	
	engine_force = throttle_val * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	steer_target = steer_val * MAX_STEER_ANGLE
	if (steer_target < steer_angle):
		steer_angle -= steer_speed * delta
		if (steer_target > steer_angle):
			steer_angle = steer_target
	elif (steer_target > steer_angle):
		steer_angle += steer_speed * delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
	
	steering = steer_angle
