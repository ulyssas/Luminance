extends Camera3D

var speed: float = 10.0

func _process(delta):
    var direction = Vector3()
    if Input.is_key_pressed(KEY_W):
        direction.z += 1
    if Input.is_key_pressed(KEY_S):
        direction.z -= 1
    if Input.is_key_pressed(KEY_A):
        direction.x += 1
    if Input.is_key_pressed(KEY_D):
        direction.x -= 1
    if direction.length() > 0:
        direction = direction.normalized() * speed

    #position += direction * delta
