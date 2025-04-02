extends Control

@onready var name_label = $name

var wait_time = 2.0  # スクロール開始前の待機時間（秒）
var scroll_speed_per_pixel = 0.02  # 1ピクセルあたりのスクロール時間
var tween: Tween  # Tween の管理用

@export var music_name: String = "":
    set(value):
        music_name = value
        update_text()

func _ready():
    await get_tree().process_frame  # サイズ計算のために1フレーム待つ
    
    if name_label.size.x > self.size.x:
        start_scroll()

func update_text():
    name_label.text = music_name
    name_label.position.x = 0
    
    var font: Font = name_label.get_theme_font("font")
    var font_size: int = name_label.get_theme_font_size("font_size")
    var string_size = font.get_string_size(name_label.text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size)
    name_label.size.x = string_size.x

    # もし Tween が存在していたら削除
    if tween:
        tween.kill()

    # サイズをチェックしてスクロール開始
    if name_label.size.x > self.size.x:
        start_scroll()

func start_scroll():
    var start_pos = 0  # 初期位置（そのまま）
    var end_pos = -name_label.size.x
    var scroll_distance = abs(end_pos - start_pos)
    # スクロール時間計算
    var scroll_time = scroll_distance * scroll_speed_per_pixel

    if tween:
        tween.kill()
    await get_tree().create_timer(wait_time).timeout

    tween = get_tree().create_tween()  # tweenを新しく作成
    tween.tween_property(name_label, "position:x", end_pos, scroll_time).set_trans(Tween.TRANS_LINEAR)
    tween.tween_callback(reset_position)

func reset_position():
    name_label.position.x = 0  # 初期位置に戻す
    start_scroll()  # 再びスクロール開始
