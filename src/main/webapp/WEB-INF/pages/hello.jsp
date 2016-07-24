<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<script src="http://cdn.sockjs.org/sockjs-0.3.min.js"></script>
	<!-- 新 Bootstrap 核心 CSS 文件 -->
	<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<!-- 可选的Bootstrap主题文件（一般不用引入） -->
	<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
	<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
	<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
	<!--<script type="text/javascript" src="js/jquery-1.7.2.js"></script>-->
	<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
	<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<title>webSocket测试</title>
	<script type="text/javascript">
		$(function(){
			var websocket;
			if ('WebSocket' in window) {
				websocket = new WebSocket("ws://127.0.0.1:8080/echo");
			} else if ('MozWebSocket' in window) {
				websocket = new MozWebSocket("ws://echo");
			} else {
				websocket = new SockJS("http://127.0.0.1:8080/sockjs/echo");
			}
			websocket.onopen = function (evnt) {
				$("#tou").html("链接服务器成功!")
			};
			websocket.onmessage = function (evnt) {
				$("#msg").html($("#msg").html() + "<br/>" + evnt.data);
			};
			websocket.onerror = function (evnt) {
			};
			websocket.onclose = function (evnt) {
				$("#tou").html("与服务器断开了链接!")
			}
			$('#send').bind('click', function() {
				send();
			});
			function send(){
				if (websocket != null) {
					var message = document.getElementById('message').value;
					websocket.send(message);
				} else {
					alert('未与服务器链接.');
				}
			}

			function disconnect() {
				if (ws != null) {
					ws.close();
					ws = null;
				}
			}
		});
	</script>

</head>
<body>

<div class="page-header" id="tou">
	webSocket chatroom
</div>
<div class="well" id="msg">
</div>
<div class="col-lg">
	<div class="input-group">
		<input type="text" class="form-control" placeholder="发送信息..." id="message">
      <span class="input-group-btn">
        <button class="btn btn-default" type="button" id="send" >发送</button>
      </span>
	</div><!-- /input-group -->
</div><!-- /.col-lg-6 -->
</div><!-- /.row -->
</body>

</html>