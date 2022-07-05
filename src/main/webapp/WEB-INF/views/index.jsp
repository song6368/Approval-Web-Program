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
	    
	    if('${gr}'!=''){
	    	$('#myModal').modal();
	    }
	})
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
                <div class="container-fluid">
                    <h1 class="mt-4">인력지원 정보 관리 시스템</h1>
                    <br>
                    <br>
                    <p>인력지원 정보 관리 시스템입니다.</p>
                    <p>회원가입 : 한 ip에는 하나의 계정만 가입할 수 있습니다. 가입 후에는 키코드가 발급됩니다.</p>
                    <p>로그인 : 처음에 등록된 키코드와 ip검사 후 로그인할 수 있습니다.</p>
                    <p>인력지원 정보 접수 : 관리자 계정만 접수가 가능합니다. 접수된 건은 면접관들이 접수내역에서 확인할 수 있습니다.</p>
                    <p>인력지원 정보 수정 : 관리자 계정만 수정이 가능합니다. 수정된 건은 면접관들이 접수내역에서 확인할 수 있습니다.</p>
                    <p>인력지원 접수 내역 : 관리자가 인력지원 접수를 한 내역입니다. 관리자를 제외한 면접관들만 볼 수 있으며, 모든 면접관들이 수락버튼을 누를시 등록됩니다.</p>
                    <p>인력지원 등록 현황 : 로그인 없이 지원자들 현황이 표시됩니다.</p>
                    <p>지원자 DB 정상여부 조회 : 지표를 보여주며, 해당 지원자에 대한 데이터 정상 여부를 검토합니다.</p>
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
