<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
	$( document ).ready(function() {
	    if('${msg}'!=''){
	    	alert('${msg}');
	    }
	    
	    if('${user}'!=''){
	    	$('#sec1').empty();
	    	$('#sec1').append('<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${user.user_id} 님</a><div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown"><a class="dropdown-item" href="openModifyInfo">회원정보수정</a><a class="dropdown-item" href="logout">로그아웃</a></div></li>');
	    }
	})
	
	function enterkey() {
        if (window.event.keyCode == 13) {
        	checkUser();
        }
	}
	
	function checkUser(){
		
		param = {
			name : $('#name').val(),
			email : $('#email').val()
		}
		
		$.ajax({
			type:"POST",
			data: param,
			url:"checkUser",
			success:function(res){
				
				$('#alert').empty();
				
				if(res==''){
					$('#alert').append('<div class="alert alert-danger" role="alert">해당 지원자를 찾을 수 없습니다!</div>');
					return;
				}
				
				for(var i = 1; i <=3; i++){
					var sum = 0;
					for(var j = 1; j<=3; j++){
						sum += parseInt(eval('res.eval_score'+i+'_'+j)); 
					}
					if(eval('res.eval_score'+i+'_4') != sum){
						$('#alert').append('<div class="alert alert-danger" role="alert">면접관 '+eval('res.interview_id'+i)+'의 점수 총합에 문제가있습니다.</div>');
					}
					if(eval('res.eval_image'+i) == ''){
						$('#alert').append('<div class="alert alert-danger" role="alert">면접관 '+eval('res.interview_id'+i)+'의 채점지 사진이 존재하지 않습니다.</div>');
					}
				}
				
				if(res.pn==''){
					$('#alert').append('<div class="alert alert-danger" role="alert">지원자의 연락처가 누락되었습니다.</div>');
				}
				
				if(res.register != 'root'){
					$('#alert').append('<div class="alert alert-danger" role="alert">등록자가 관리자 계정이 아닙니다.</div>');
				}
				
				if($('#alert').html() == ''){
					$('#alert').append('<div class="alert alert-primary" role="alert">지원자 DB에 문제가 없습니다.</div>');
				}
				
			},
			error:function(){
				alert("통신 실패");
			}
		});
	}
</script>

<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<html lang="kr">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>인력지원 정보관리 시스템</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light" style="font-size : 17px; font-weight:bold"><a href="/" id = "topic" style="text-decoration:none; color:black;">인력지원 정보관리 시스템</a></div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="insert">인력지원 정보 접수</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="modify">인력지원 정보 수정</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="recieve">인력지원 접수 내역</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="current">인력지원 등록 현황</a>
                    <a class="list-group-item list-group-item-action list-group-item-light p-3" href="solicitation">지원자 DB 정상여부 조회</a>
                </div>
            </div>
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                    <div class="container-fluid">
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ms-auto mt-2 mt-lg-0" id="sec1">
                               <a class="dropdown-item" href="openLogin">로그인</a>
                               <a class="dropdown-item" href="openSignUp">회원가입</a>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Page content-->
                <div style="width:30%; margin:0 auto; margin-top:7%; text-align:center">
	                <label style="margin-bottom:10%; font-size:150%; margin-bottom:4%">지원자 DB 정상여부 조회</label>
					 <div class="form-group" style="margin-bottom:4%">
					    <input type="text" class="form-control" id="name" onkeyup="enterkey()" placeholder="Enter Name..." required>
					  </div>
					  <div class="form-group" style="margin-bottom:4%">
					    <input type="email" class="form-control" id="email" onkeyup="enterkey()" placeholder="Enter Email..." required>
					  </div>
					  <button class="btn btn-primary" onclick="checkUser()" style="margin-bottom:4%; float:right">Check</button>
					  <div id="alert" style="margin-top:25%;"></div>
				</div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>

<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">키 코드 발급</h4>
      </div>
      <div class="modal-body">
		<small id="emailHelp" class="form-text text-muted">※키 코드는 다시 조회하거나 발급 받을 수 없습니다 (저장필수)※</small>
        <p>${gr}</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
