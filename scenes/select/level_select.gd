extends HBoxContainer

@export var easy_value: String = "":
    set(value):
        easy_value = value
        $easy.item_value = value

@export var medium_value: String = "":
    set(value):
        medium_value = value
        $medium.item_value = value

@export var hard_value: String = "":
    set(value):
        hard_value = value
        $hard.item_value = value

@export var kuso_value: String = "":
    set(value):
        kuso_value = value
        $kuso.item_value = value
