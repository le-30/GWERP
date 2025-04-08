<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QR 코드 로그인</title>
</head>
<body>


	<input type="hidden" name="uuid" value="${uuid}">
	<p>핸드폰으로 아래 QR을 스캔해주세요.</p>
	<p style="color: red;">${error}</p>

	<img
		src="https://api.qrserver.com/v1/create-qr-code/?data=http://localhost:8080/login/scan/qr/login.erp?uuid=${uuid}&size=200x200" />
	<p>
		남은 시간: <span id="timer">10:00</span>
	</p>

	<script type="text/javascript">
		function startQrTimer() {
			var timeLeft = 10 * 60;
			var timerEl = document.getElementById("timer");

			if (!timerEl)
				return;

			var countdown = setInterval(function() {
				var minutes = ("0" + Math.floor(timeLeft / 60)).slice(-2);
				var seconds = ("0" + (timeLeft % 60)).slice(-2);
				timerEl.innerHTML = minutes + ":" + seconds;

				if (timeLeft <= 0) {
					clearInterval(countdown);
					alert("QR 코드 유효시간이 만료되었습니다. 다시 시도해주세요.");
					location.href = "/auth/qr/login.erp";
				}

				timeLeft--;
			}, 1000);
		}

		/*  window.onload = function () {
		   var timeLeft = 10 * 60; // 10분
		   var timerEl = document.getElementById("timer");

		   var countdown = setInterval(function () {
		     var minutes = ("0" + Math.floor(timeLeft / 60)).slice(-2);
		     var seconds = ("0" + (timeLeft % 60)).slice(-2);
		     timerEl.innerHTML = minutes + ":" + seconds;

		     if (timeLeft <= 0) {
		       clearInterval(countdown);
		       alert("QR 코드 유효시간이 만료되었습니다. 다시 시도해주세요.");
		       location.href = "/auth/qr/login.erp";
		     }

		     timeLeft--;
		   }, 1000);
		 }; */
	</script>

</body>
</html>
