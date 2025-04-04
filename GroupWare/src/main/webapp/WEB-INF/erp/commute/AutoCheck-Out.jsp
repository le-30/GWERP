<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    window.onload = function () {
        var now = new Date();
        var todayStr = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate();

        var warnTime = new Date(todayStr + "T23:50:00");
        var logoutTime = new Date(todayStr + "T23:55:00");

        var nowTime = now.getTime();
        var warnDelay = warnTime.getTime() - nowTime;
        var logoutDelay = logoutTime.getTime() - nowTime;

        if (warnDelay > 0) {
            setTimeout(function () {
                alert("5분 후 자동 로그아웃 됩니다.");
            }, warnDelay);
        }

        if (logoutDelay > 0) {
            setTimeout(function () {
                alert("자동 로그아웃 처리되었습니다.");
                location.href = "/check_out/commute.erp";
            }, logoutDelay);
        }
    }
</script>
