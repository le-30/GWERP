<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Dashboard</title>
  <style>
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Pretendard', sans-serif;
    }
    body {
      background: #ffffff;
      height: 100vh;
      padding: 3cm 0;
      display: flex;
      flex-direction: row;
      border-radius: 20px;
    }

    .left-column {
      width: 200px;
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-right: 1cm;
    }

    .profile-box {
      background: #f7f9fc;
      border: 1px solid #ddd;
      padding: 20px 10px;
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: flex-start;
      height: 4cm;
      margin-bottom: 20px;
      border-radius: 20px 20px 0 0;
    }
    .profile-box .name {
      font-weight: bold;
      margin-bottom: 5px;
    }
    .profile-box .position {
      font-size: 14px;
      color: #666;
      margin-bottom: 5px;
    }
    .profile-box a {
      font-size: 13px;
      color: #1E90FF;
      text-decoration: none;
    }

    .todo-box-wrapper {
      background: #f0f0f0;
      border: 1px solid #ddd;
      padding: 20px 10px;
      width: 100%;
      flex-grow: 1;
      border-radius: 0 0 20px 20px;
    }
    .todo-box {
      background: #ffffff;
      border-radius: 8px;
      padding: 10px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
      overflow-y: auto;
    }
    .todo-box h4 {
      margin-bottom: 10px;
    }
    .todo-box ul {
      list-style: none;
      padding-left: 0;
    }
    .todo-box li {
      font-size: 14px;
      padding: 4px 0;
      border-bottom: 1px solid #eee;
    }

    .main {
      flex: 1;
      display: flex;
      flex-direction: row;
      gap: 30px;
    }
    .content {
      flex: 3;
      padding: 30px;
      background: #ffffff;
      color: white;
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-template-areas:
        "erp msg msg"
        "erp meeting approval"
        "commute calendar approval";
      gap: 0;
      border-radius: 20px;
    }
    .block {
      border-radius: 0;
      padding: 20px;
      text-align: center;
      font-weight: bold;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      position: relative;
      color: white;
    }
    .block:hover {
      filter: brightness(1.1);
      transform: scale(1.03);
    }
    .erp     { grid-area: erp;     background-color: #1E90FF; border-top-left-radius: 20px; }
    .msg     { grid-area: msg;     background-color: #20B2AA; border-top-right-radius: 20px; }
    .meeting { grid-area: meeting; background-color: #9370DB; }
    .approval{ grid-area: approval;background-color: #FF4500; border-bottom-right-radius: 20px; }
    .commute { grid-area: commute; background-color: #3CB371; border-bottom-left-radius: 20px; }
    .calendar{ grid-area: calendar; background-color: #FF69B4; }

    .icon {
      width: 40px;
      height: 40px;
      margin-bottom: 10px;
    }
    .badge {
      position: absolute;
      top: 10px;
      right: 15px;
      background: #fff;
      color: #333;
      border-radius: 10px;
      padding: 2px 8px;
      font-size: 12px;
      font-weight: bold;
    }
    .rightbar {
      flex: 1;
      max-width: 25%;
      background: #f0f0f0;
      padding: 20px;
      border-left: 1px solid #ddd;
      display: flex;
      flex-direction: column;
      border-radius: 20px;
    }
    .rightbar .header {
      font-weight: bold;
      font-size: 18px;
      margin-bottom: 10px;
    }
    .rightbar .msg {
      background: #ffffff;
      padding: 10px;
      margin-bottom: 10px;
      border-radius: 8px;
      box-shadow: 0 2px 3px rgba(0,0,0,0.05);
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(function() {
      $('.block').on('click', function () {
        const page = $(this).data('page');
        if (page) {
          location.href = `main.jsp?page=${page}`;
        }
      });
    });
  </script>
</head>
<body>
  <div class="left-column">
    <div class="profile-box">
      <div class="name">홍길동</div>
      <div class="position">인사팀 / 과장</div>
      <a href="profile.jsp">내 정보</a>
    </div>

    <div class="todo-box-wrapper">
      <div class="todo-box">
        <h4>📌 TODO</h4>
        <ul>
          <li>주간 보고서 작성</li>
          <li>팀 회의 준비</li>
          <li>결재 요청 확인</li>
        </ul>
      </div>
    </div>
  </div>

  <div class="main">
    <div class="content">
      <div class="block erp" data-page="emp">
        <div class="badge">03</div>
        <img class="icon" src="/images/erp.png" alt="ERP">
        <div>ERP</div>
      </div>
      <div class="block msg" data-page="received">
        <div class="badge">03</div>
        <img class="icon" src="/images/msg.png" alt="쪽지">
        <div>쪽지</div>
      </div>
      <div class="block meeting" data-page="meeting">
        <div class="badge">10</div>
        <img class="icon" src="/images/meeting.png" alt="미팅룸">
        <div>미팅룸</div>
      </div>
      <div class="block approval" data-page="appr">
        <div class="badge">12</div>
        <img class="icon" src="/images/approval.png" alt="결재">
        <div>결재 + 업무보고</div>
      </div>
      <div class="block commute" data-page="commute">
        <div class="badge">01</div>
        <img class="icon" src="/images/commute.png" alt="출퇴근">
        <div>출퇴근</div>
      </div>
      <div class="block calendar" data-page="calendar">
        <div class="badge">02</div>
        <img class="icon" src="/images/calendar.png" alt="일정">
        <div>일정</div>
      </div>
    </div>

    <div class="rightbar">
      <div class="header">실시간 알림</div>
      <div class="msg">[메일] 결재 요청이 도착했습니다</div>
      <div class="msg">[메신저] 팀장님이 메시지를 보냈습니다</div>
      <div class="msg">[공지] 서버 점검 안내</div>
    </div>
  </div>
</body>
</html>