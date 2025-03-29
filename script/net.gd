extends Node

var WORLD = null;

func update_world(callback: Callable) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	# 使用 Callable 连接信号
	http_request.request_completed.connect(_on_request_completed.bind(callback))
	# 发起 GET 请求
	http_request.request("http://192.168.1.43:8001/world")

func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray, callback : Callable) -> void:
	# 将返回的字节数组转换成 UTF-8 编码的字符串
	var json_str: String = body.get_string_from_utf8()
	var WORLD = JSON.parse_string(body.get_string_from_utf8())
	callback.call(WORLD)
