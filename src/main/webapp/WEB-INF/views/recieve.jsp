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
	    
	    selectInfo2();
	    
	});
	
	function enterkey() {
        if (window.event.keyCode == 13) {
             search();
        }
	}
	
	function search(){
		
		var search = $('#search').val();
		
		if(search==''){
			selectInfo2();
		}
		
		param = {
			search : search	
		}
		
		$.ajax({
			type:"POST",
			data: param,
			url:"selectInfo4",
			success:function(res){
				
				$('tbody').empty();
				
				if(res.length != 0){
                	for(var i = 0; i < res.length; i++){
                		
                		if(res[i].check == 1){
                			var c = "완료";
                		} else {
                			var c = "검토";
                		}
                		
                		$('tbody').append('<tr onclick="recieve2(\''+res[i].target_no+'\')"><th scope="row">'+(i+1)+'</th><td>'+res[i].name+'</td><td>'+c+'</td><td>'+res[i].interview_id1+'</td><td>'+res[i].interview_id2+'</td><td>'+res[i].interview_id3+'</td></tr>');
                	}
                }
			},
			error:function(){
				alert("통신 실패");
			}
		});
	}
	
	function selectInfo2(){
		$.ajax({
			type:"POST",
			url:"selectInfo2",
			success:function(res){
				
				$('tbody').empty();
				
				if(res.length != 0){
                	for(var i = 0; i < res.length; i++){
                		
                		if(res[i].check == 1){
                			var c = "완료";
                		} else {
                			var c = "검토";
                		}
                		
                		$('tbody').append('<tr onclick="recieve2(\''+res[i].target_no+'\')"><th scope="row">'+(i+1)+'</th><td>'+res[i].name+'</td><td>'+c+'</td><td>'+res[i].interview_id1+'</td><td>'+res[i].interview_id2+'</td><td>'+res[i].interview_id3+'</td></tr>');
                	}
                }
			},
			error:function(){
				alert("통신 실패");
			}
		});
	}
	
	function pageGoPost(d) {
		var insdoc = "";
		for (var i = 0; i < d.vals.length; i++) {
			insdoc += "<input type='hidden' name='"+ d.vals[i][0] +"' value='"+ d.vals[i][1] +"'>";
		}
		var goform = $("<form>", {
			method : "post",
			action : d.url,
			target : d.target,
			html : insdoc
		}).appendTo("body");
		goform.submit();
	}

	function recieve2(target_no) {
		pageGoPost({ 
			url: "recieve2", //이동할 페이지 
			target: "_self", 
			vals: [ //전달할 인수들 
				["target_no", target_no] 
			] });

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
                	<div class="input-group mb-3" style="width:30%; float:right; margin:1%;">
					  <input type="text" id="search" onkeyup="enterkey()" class="form-control" placeholder="Applicant's name..." aria-label="Search" aria-describedby="basic-addon2">
					  <div class="input-group-append">
					    <button class="btn btn-outline-secondary" type="button" onclick="search()">Search</button>
					  </div>
					</div>
                	<div class="container-fluid">
	                    <table class="table table-hover">
						  <thead>
						    <tr>
						      <th scope="col">번호</th>
						      <th scope="col">지원자 이름</th>
						      <th scope="col">상태</th>
						      <th scope="col">면접관1</th>
						      <th scope="col">면접관2</th>
						      <th scope="col">면접관3</th>
						    </tr>
						  </thead>
						  <tbody>
						  </tbody>
						</table>
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
