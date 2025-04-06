extends HBoxContainer

@export var easy_value: String = "":
    set(value):
        easy_value = value
        $easy.level_value = easy_value

@export var medium_value: String = "":
    set(value):
        medium_value = value
        $medium.level_value = medium_value

@export var hard_value: String = "":
    set(value):
        hard_value = value
        $hard.level_value = hard_value

@export var kuso_value: String = "":
    set(value):
        kuso_value = value
        $kuso.level_value = kuso_value
