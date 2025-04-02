extends Label

func _process(delta):
    text = str(int(Engine.get_frames_per_second()))
