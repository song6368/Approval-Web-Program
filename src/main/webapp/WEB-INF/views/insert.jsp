<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style>
	.form-group{
		margin-bottom:2%;
	}
</style>

<script>
	$( document ).ready(function() {
	    if('${msg}'!=''){
	    	alert('${msg}');
	    }
	    
	    if('${user}'!=''){
	    	$('#sec1').empty();
	    	$('#sec1').append('<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${user.user_id} 님</a><div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown"><a class="dropdown-item" href="openModifyInfo">회원정보수정</a><a class="dropdown-item" href="logout">로그아웃</a></div></li>');
	    }
	    
	    $("*").keyup(function() {
	        $("input[name=eval_score1_4]").val( parseInt($("input[name=eval_score1_1]").val())+parseInt($("input[name=eval_score1_2]").val())+parseInt($("input[name=eval_score1_3]").val()));
	        $("input[name=eval_score2_4]").val( parseInt($("input[name=eval_score2_1]").val())+parseInt($("input[name=eval_score2_2]").val())+parseInt($("input[name=eval_score2_3]").val()));
	        $("input[name=eval_score3_4]").val( parseInt($("input[name=eval_score3_1]").val())+parseInt($("input[name=eval_score3_2]").val())+parseInt($("input[name=eval_score3_3]").val()));
	    });
	    
	    $.ajax({
			type:"GET",
			url:"selectAllUser",
			success:function(res){
				if(res.length != 0){
					$('#sel1').append('<select class="form-select" id="s1" name="interview_id1" aria-label="Default select example"></select>');
                	$('#sel2').append('<select class="form-select" id="s2" name="interview_id2" aria-label="Default select example"></select>');
                	$('#sel3').append('<select class="form-select" id="s3" name="interview_id3" aria-label="Default select example"></select>');
                	
                	for(var i = 0; i < res.length; i++){
                			$('#s1').append('<option value='+res[i].user_id+'>'+res[i].user_id+'</option>');
                			$('#s2').append('<option value='+res[i].user_id+'>'+res[i].user_id+'</option>');
                			$('#s3').append('<option value='+res[i].user_id+'>'+res[i].user_id+'</option>');
                	}
                }
			},
			error:function(){
				alert("통신 실패");
			}
		});
	});
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
                    <form class="form" action="upload" method="post" enctype="multipart/form-data">
					  <small class="form-text text-muted">※정보 등록, 수정 시 모든 기록이 남습니다.※</small>
					  <div class="form-group">
					    <label for="exampleInputEmail1">지원자 성명</label>
					    <input type="text" class="form-control" name="name" placeholder="Enter Name" required>
					  </div>
					  <div class="form-group">
					    <label for="exampleInputPassword1">전화번호</label>
					    <input type="text" class="form-control" name="pn" placeholder="Phone Number" required>
					  </div>
					  <div class="form-group">
					    <label for="exampleInputPassword1">이메일</label>
					    <input type="email" class="form-control" name="email" aria-describedby="emailHelp" placeholder="E-mail" required>
					  </div>
					  <div class="form-group">
					    <label for="exampleInputPassword1">부서</label>
					    <input type="text" class="form-control" name="dept" placeholder="Dept" required>
					  </div>
					  <div class="form-group">
						  <div class="row">
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수1_1</label>
						      <input type="number" class="form-control" name="eval_score1_1" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수1_2</label>
						      <input type="number" class="form-control" name="eval_score1_2" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수1_3</label>
						      <input type="number" class="form-control" name="eval_score1_3" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 총점1</label>
						      <input type="number" class="form-control" name="eval_score1_4" placeholder="Score" style="pointer-events: none;">
						    </div>
						    <div class="col" id="sel1">
						    	<label for="exampleInputPassword1">면접관1</label>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수 채점 사진1</label>
							  <div class="form-group">
								 <input type="file" class="form-control-file" name="eval_image" required>
							  </div>
						    </div>
						  </div>
					  </div>
					 <div class="form-group">
						  <div class="row">
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수2_1</label>
						      <input type="number" class="form-control" name="eval_score2_1" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수2_2</label>
						      <input type="number" class="form-control" name="eval_score2_2" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수2_3</label>
						      <input type="number" class="form-control" name="eval_score2_3" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 총점2</label>
						      <input type="number" class="form-control" name="eval_score2_4" placeholder="Score" style="pointer-events: none;">
						    </div>
						    <div class="col" id="sel2">
						    	<label for="exampleInputPassword1">면접관2</label>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수 채점 사진2</label>
							  <div class="form-group">
								 <input type="file" class="form-control-file" name="eval_image" required>
							  </div>
						    </div>
						  </div>
					  </div>
					  <div class="form-group">
						  <div class="row">
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수3_1</label>
						      <input type="number" class="form-control" name="eval_score3_1" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수3_2</label>
						      <input type="number" class="form-control" name="eval_score3_2" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수3_3</label>
						      <input type="number" class="form-control" name="eval_score3_3" placeholder="Score" required>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 총점3</label>
						      <input type="number" class="form-control" name="eval_score3_4" placeholder="Score" style="pointer-events: none;">
						    </div>
						    <div class="col" id="sel3">
						    	<label for="exampleInputPassword1">면접관3</label>
						    </div>
						    <div class="col">
						      <label for="exampleInputPassword1">면접 점수 채점 사진3</label>
							  <div class="form-group">
								 <input type="file" class="form-control-file" name="eval_image" required>
							  </div>
						    </div>
						  </div>
					  </div>
					  <button type="submit" class="btn btn-primary">Submit</button>
					  <a href="/" class="btn btn-danger">Cancel</a>
					</form>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>