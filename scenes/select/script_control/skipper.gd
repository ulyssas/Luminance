extends Control

@onready var name_label = $name

@export var creator_name: String = "":
    set(value):
        creator_name = value
        update_text()

func _ready():
    await get_tree().process_frame  # サイズ計算のために1フレーム待つ
    update_text()

func update_text():
    name_label.text = creator_name
    reset_position()

func reset_position():
    var font: Font = name_label.get_theme_font("font")
    var font_size: int = name_label.get_theme_font_size("font_size")
    var string_size: Vector2 = font.get_string_size(name_label.text, HORIZONTAL_ALIGNMENT_RIGHT, -1, font_size)
    name_label.size.x = string_size.x
    name_label.position.x = self.size.x-name_label.size.x

    # サイズをチェックしてスクロール開始
    if name_label.size.x > self.size.x:
        var ellipsis := "…"
        var new_text := creator_name
        while new_text.length() > 0:
            new_text = new_text.substr(0, new_text.length() - 1)
            var test_text := new_text + ellipsis
            var test_size := font.get_string_size(test_text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
            if test_size.x <= self.size.x:
                name_label.text = test_text
                break
        if new_text.length() == 0:
            name_label.text = ellipsis
