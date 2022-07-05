<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
	.form-group{
		margin-bottom:2%;
	}
	
	input {
		pointer-events: none;
	}
	
	.col label{
		margin-top: 5%;
	}
	
	select {
		pointer-events: none;
	}
	
	#i1:hover{
		transform: scale(2);
  		-webkit-transform: scale(2);
  		-moz-transform: scale(2);
  		-ms-transform: scale(2);
  		-o-transform: scale(2);
	}
	
	#i2:hover{
		transform: scale(2);
  		-webkit-transform: scale(2);
  		-moz-transform: scale(2);
  		-ms-transform: scale(2);
  		-o-transform: scale(2);
	}
	
	#i3:hover{
		transform: scale(2);
  		-webkit-transform: scale(2);
  		-moz-transform: scale(2);
  		-ms-transform: scale(2);
  		-o-transform: scale(2);
	}
	
	#r1, #r2, #r3 {
		margin-bottom:5%;
	}
	
	#btns {
		text-align:right;
	}
</style>

<script>
	var interview_id1;
	var interview_id2;
	var interview_id3;
	var eval_no;
	
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
			async:false,
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
	    
	    loadAll();
	    
	});
	
	function loadAll(){
		
		var target_no = '${target_no}';
	    
	    param = {
	    	target_no : target_no
	    }
	    
	    $.ajax({
			type:"POST",
			data: param,
			async: false,
			url:"selectTargetInfo",
			success:function(res){
				$('#n').val(res.name);
				$('input[name=pn]').val(res.pn);
				$('input[name=email]').val(res.email);
				$('input[name=dept]').val(res.dept);
				$('input[name=eval_score1_1]').val(res.eval_score1_1);
				$('input[name=eval_score1_2]').val(res.eval_score1_2);
				$('input[name=eval_score1_3]').val(res.eval_score1_3);
				$('input[name=eval_score1_4]').val(res.eval_score1_4);
				$('input[name=eval_score2_1]').val(res.eval_score2_1);
				$('input[name=eval_score2_2]').val(res.eval_score2_2);
				$('input[name=eval_score2_3]').val(res.eval_score2_3);
				$('input[name=eval_score2_4]').val(res.eval_score2_4);
				$('input[name=eval_score3_1]').val(res.eval_score3_1);
				$('input[name=eval_score3_2]').val(res.eval_score3_2);
				$('input[name=eval_score3_3]').val(res.eval_score3_3);
				$('input[name=eval_score3_4]').val(res.eval_score3_4);
				
				$("#s1").val(res.interview_id1).attr("selected", "selected");
				$("#s2").val(res.interview_id2).attr("selected", "selected");
				$("#s3").val(res.interview_id3).attr("selected", "selected");
				
				interview_id1 = res.interview_id1;
				interview_id2 = res.interview_id2;
				interview_id3 = res.interview_id3;
				eval_no = res.eval_no;
				
				if(res.check1 == 1){
					$('#accept1').css("pointer-events", "none");
					$('#accept1').html("Completed");
					$('#col1').css('opacity', '0.3');
					$('#col1').css('pointer-events', 'none');
				}
				
				if(res.check2 == 1){
					$('#accept2').css("pointer-events", "none");
					$('#accept2').html("Completed");
					$('#col2').css('opacity', '0.3');
					$('#col2').css('pointer-events', 'none');
				} 
				
				if(res.check3 == 1){
					$('#accept3').css("pointer-events", "none");
					$('#accept3').html("Completed");
					$('#col3').css('opacity', '0.3');
					$('#col3').css('pointer-events', 'none');
				}
				
				if(res.read1.indexOf(res.name) == -1){
					$('#r1').append("문자인식 상 지원자의 이름이 다릅니다.<br>");	
				}
				
				if(res.read1.indexOf(res.interview_id1) == -1){
					$('#r1').append("문자인식 상 면접관의 이름이 다릅니다.<br>");	
				}
				
				if(res.read2.indexOf(res.name) == -1){
					$('#r2').append("문자인식 상 지원자의 이름이 다릅니다.<br>");	
				}
				
				if(res.read2.indexOf(res.interview_id2) == -1){
					$('#r2').append("문자인식 상 면접관의 이름이 다릅니다.<br>");	
				}
				
				if(res.read3.indexOf(res.name) == -1){
					$('#r3').append("문자인식 상 지원자의 이름이 다릅니다.<br>");	
				}
				
				if(res.read3.indexOf(res.interview_id3) == -1){
					$('#r3').append("문자인식 상 면접관의 이름이 다릅니다.<br>");	
				}
				
				if(parseInt(res.read1.substring(res.read1.length-3, res.read1.length)) < 100){
					$('#r1').append("문자인식 상 점수가 제대로 인식되지 않습니다.<br>");	
				}
				
				if(parseInt(res.read2.substring(res.read2.length-3, res.read2.length)) < 100){
					$('#r2').append("문자인식 상 점수가 제대로 인식되지 않습니다.<br>");	
				}
				
				if(parseInt(res.read3.substring(res.read3.length-3, res.read3.length)) < 100){
					$('#r3').append("문자인식 상 누락된 점수가 있습니다.<br>");	
				}
				
				for(var i = 1; i <= 3; i++){
					var addr1 = eval('res.eval_image'+i).replace('C:\\u\\pic', '/filepath');
					var addr2 = addr1.replace('\\','/');
					$('#i'+i).attr('src', addr2);
				}
			},
			error:function(){
				alert("통신 실패");
			}
		})
	}
	
	function accept(i){
		var result = confirm('한 번 수락하면, 수정하지 못합니다. 계속하시겠습니까?');

		if(result){
			if(i != 1 && i != 2 && i != 3){
				alert('HTML값이 변경되었습니다!');
				location.href="/";
			}
			
			param = {
				eval_no : eval_no,
				which : i
			}
			
			$.ajax({
				type:"POST",
				data: param,
				async: false,
				url:"accept",
				success:function(res){
					if(res == 1){
						alert('등록 성공');
						location.reload();
					} else {
						alert('등록 실패');
					}
				},
				error:function(){
					alert("통신 실패");
				}
			});
		}
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
                <div class="container-fluid">
				  <input type="number" name = "target_no" value='${target_no}' style="display:none">
				  <div class="form-group">
				    <label for="exampleInputEmail1">지원자 성명</label>
				    <input type="text" class="form-control" name="name" id="n" placeholder="Enter Name" required>
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
					  <div class="row" id ="row2">
					    <div class="col" id="col1">
					      <div id = "btns">
					      	<button class="btn btn-primary" id="accept1" onclick="accept(1)">Accept</button>
					      </div>
					      <div id="sel1">
					    	<label for="exampleInputPassword1">면접관1</label>
					      </div>
					      <label for="exampleInputPassword1">면접 점수1_1</label>
					      <input type="number" class="form-control" name="eval_score1_1" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 점수1_2</label>
					      <input type="number" class="form-control" name="eval_score1_2" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 점수1_3</label>
					      <input type="number" class="form-control" name="eval_score1_3" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 총점1</label>
					      <input type="number" class="form-control" name="eval_score1_4" placeholder="Score" style="pointer-events: none;">
					      <label for="exampleInputPassword1">면접 점수 채점 사진1</label>
						  <div  class="form-group">
							<img id="i1" src="" style="width:50%;">
						  </div>
						  <div id="r1" style="font-size:20px; color:red;"></div>
					    </div>
					    <div class="col" id="col2">
					      <div id = "btns">
					      	<button class="btn btn-primary" id="accept2" onclick="accept(2)">Accept</button>
					      </div>
					      <div id="sel2">
					    	<label for="exampleInputPassword1">면접관2</label>
					      </div>
					      <label for="exampleInputPassword1">면접 점수2_1</label>
					      <input type="number" class="form-control" name="eval_score2_1" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 점수2_2</label>
					      <input type="number" class="form-control" name="eval_score2_2" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 점수2_3</label>
					      <input type="number" class="form-control" name="eval_score2_3" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 총점2</label>
					      <input type="number" class="form-control" name="eval_score2_4" placeholder="Score" style="pointer-events: none;">
					      <label for="exampleInputPassword1">면접 점수 채점 사진2</label>
						  <div class="form-group">
							<img id="i2" src="" style="width:50%;">
						  </div>
						  <div id="r2" style="font-size:20px; color:red;"></div>
					    </div>
					    <div class="col" id="col3">
					      <div id = "btns">
					      	<button class="btn btn-primary" id="accept3" onclick="accept(3)">Accept</button>
					      </div>
					      <div id="sel3">
					    	<label for="exampleInputPassword1">면접관3</label>
					      </div>
					      <label for="exampleInputPassword1">면접 점수3_1</label>
					      <input type="number" class="form-control" name="eval_score3_1" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 점수3_2</label>
					      <input type="number" class="form-control" name="eval_score3_2" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 점수3_3</label>
					      <input type="number" class="form-control" name="eval_score3_3" placeholder="Score" required>
					      <label for="exampleInputPassword1">면접 총점3</label>
					      <input type="number" class="form-control" name="eval_score3_4" placeholder="Score" style="pointer-events: none;">
					      <label for="exampleInputPassword1">면접 점수 채점 사진3</label>
						  <div class="form-group">
							<img id="i3" src="" style="width:50%;">
						  </div>
						  <div id="r3" style="font-size:20px; color:red;"></div>
					    </div>
					  </div>
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
      <div class="modal-body">
      	로딩중입니다...
      </div>
    </div>
  </div>
</div>
