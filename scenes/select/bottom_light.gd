extends Control

func _process(_delta):
    $sidelight1.visible = Input.is_action_pressed("air_left")

    $light1.visible =  Input.is_action_pressed("lane_1")

    $light2.visible =  Input.is_action_pressed("lane_2")

    $light3.visible =  Input.is_action_pressed("lane_3")

    $light4.visible =  Input.is_action_pressed("lane_4")
        
    $sidelight2.visible =  Input.is_action_pressed("air_right")
