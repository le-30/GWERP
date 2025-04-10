<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QR 코드 로그인</title>
</head>
<body>

<h2>QR 코드 로그인</h2>

<p>남은 시간: <span id="timer">10:00</span></p> <!-- 이게 중요!! -->

<script type="text/javascript">
  window.onload = function () {
    var timeLeft = 10 * 60; // 10분 (초 단위)
    var timerEl = document.getElementById("timer");

    var countdown = setInterval(function () {
      var minutes = ("0" + Math.floor(timeLeft / 60)).slice(-2);
      var seconds = ("0" + (timeLeft % 60)).slice(-2);
      if (timerEl) {
        timerEl.innerHTML = minutes + ":" + seconds;
      }

      if (timeLeft <= 0) {
        clearInterval(countdown);
        alert("QR 코드 유효시간이 만료되었습니다. 다시 시도해주세요.");
        location.href = "/auth/qr/login.erp";
      }

      timeLeft--;
    }, 1000);
  };
</script>

</body>
</html>  
  