extends MeshInstance3D

var speed: float = 20.0
var move_x: float = 0
var move_z: float = 0

func _process(delta):
    if Input.is_action_pressed("ui_up"):
        move_z = 1
    elif Input.is_action_pressed("ui_down"):
        move_z = -1
    else:
        move_z = 0
    
    if Input.is_action_pressed("ui_left"):
        move_x = 1
    elif Input.is_action_pressed("ui_right"):
        move_x = -1
    else:
        move_x = 0
    
    position.x += move_x * speed * delta
    position.z += move_z * speed * delta
