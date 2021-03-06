<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>GroupWare</title>
<!-- Custom fonts for this template-->
<link href="${contextPath}/resources/bootstrap/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script	src="${contextPath}/resources/bootstrap/vendor/jquery/jquery.min.js"></script>
<script	src="${contextPath}/resources/bootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="${contextPath}/resources/bootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${contextPath}/resources/bootstrap/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="${contextPath}/resources/bootstrap/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="${contextPath}/resources/bootstrap/js/demo/chart-area-demo.js"></script>
<script src="${contextPath}/resources/bootstrap/js/demo/chart-pie-demo.js"></script>

<!-- Custom styles for this template-->
<link href="${contextPath}/resources/bootstrap/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/fbd170e696.js"></script>
	<style type="text/css">
	#buttons button{
		margin: 5em;
		display: inline-block;
		margin-left: auto;
		margin-right: auto;
	}
	#buttons{
		display: inline-block;
		margin-left: auto;
		margin-right: auto;
		text-align: center;
	}
	</style>
</head>

<body id="page-top">

	<!-- ???????????? -->
	<div id="wrapper">
		<!-- ???????????? -->
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" flush="false"></jsp:include>
		<!-- ????????? -->
		<jsp:include page="/WEB-INF/views/common/topbar.jsp" flush="false"></jsp:include>

		<!-- ????????? ?????? -->
		<div class="container-fluid">
			<!-- ????????? ?????? -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-0 text-gray-800">????????????</h1>
			</div>
			 <div class="card shadow" style="margin-bottom: 5rem;">
				  <div class="card-body">
					 <h3 style="margin-bottom: 25px;">${ap.apTitle}( ${ap.apNo} )</h3>
					   <div class="form-group">
						   <strong>????????? : </strong><input type="text" class="form-control" value="${ap.empNo}" readonly>
					   </div>
					   <div class="row">
						   <div class="form-group col-lg-6">
						   		<c:set var="str1" value="${ap.approvalEmp}"/>
								<c:set var="str2" value="${fn:replace(str1, ',N', '-??????')}" />
								<c:set var="str3" value="${fn:replace(str2, ',R', '-??????')}" />
								<c:set var="str4" value="${fn:replace(str3, ',Y', '-??????')}" />
								<c:set var="str5" value="${fn:replace(str4, ';', ', ')}" />
						    	<strong>????????? : </strong><input type="text" class="form-control" value="${str5}" readonly>
						   </div>
						   <div class="form-group col-lg-6">
						   		<c:set var="str01" value="${ap.hEmp}"/>
								<c:set var="str02" value="${fn:replace(str01, ',N', '-??????')}" />
								<c:set var="str03" value="${fn:replace(str02, ',R', '-??????')}" />
								<c:set var="str04" value="${fn:replace(str03, ',Y', '-??????')}" />
								<c:set var="str05" value="${fn:replace(str04, ';', ', ')}" />
						    	<strong>????????? : </strong><input type="text" class="form-control" value="${str05}" readonly>
						   </div>
						   <div class="form-group col-lg-6">
						    	<strong>????????? : </strong><input type="text" class="form-control" value="${ap.runEmp}" readonly>
						    </div>
						    <div class="form-group col-lg-6">
						    	<strong>????????? : </strong><input type="text" class="form-control" value="${ap.refEmp}" readonly>
					    </div>
					    </div>
				   		<c:if test="${empty ap.a_v_first}">
					   	<div class="form-group">
					   		<strong>????????? : </strong> <input type="date" class="form-control" value="${ap.dDate}" readonly>
					   </div>
				   		</c:if>
				   		<c:if test="${!empty ap.a_v_first }">
							<div class="row">
					   			<div class="form-group col-lg-6">
					   				<strong>??????????????? : </strong> <input type="date" value="${ap.a_v_first }" class="form-control" name="a_v_first" readonly>
					   			</div>
					   			<div class="form-group col-lg-6">
					   				<strong>???????????????: </strong> <input type="date" value="${ap.a_v_last }" class="form-control" name="a_v_last" readonly>
					   			</div>
					   		</div>
				   		</c:if>
					    <div class="form-group" style="border: 1px solid lightgray; border-radius:.5rem; padding: 2rem;min-height: 20rem;">
					    	${ap.apContent}
						 </div>
						 	<c:if test="${!empty ap.originalFile }">
						 	???????????? : 
						 	</c:if>
						 	<a href="${ contextPath }/resources/buploadFiles/${ ap.renameFile }" download="${ ap.originalFile }">${ ap.originalFile }</a>
							<!-- a?????? ????????? ???????????? ?????? ?????? ?????? ??? ?????? ?????? download, ?????? download="fileName" ????????? ?????? fileName??? ???????????? ??? ??????. -->
						  
					  <div class="row">
						  <div id="buttons">
						  	  <c:set var="tag" value="${tag}"/>
						  	  <!--?????? ??? ????????????  -->
						  	 <c:set var="empNo" value="${loginEmp.empNo}"/>
							  <c:if test="${tag eq 'g'}">
							  	 <c:set var="hEmp" value="${ap.hEmp}" />
							  	 <c:set var="approvalEmp" value="${ap.approvalEmp}"/>
							  	 <c:if test="${fn:contains(approvalEmp, empNo)}">
								 	 <button type="button" id="agreeFun" class="btn btn-success">??????</button>
								 	 <button type="button" id="disareeFun" class="btn btn-danger">??????</button>
							  	 </c:if>
							  	 <c:if test="${fn:contains(hEmp,empNo)}">
								 	 <button type="button" id="yesFun" class="btn btn-success">??????</button>
								 	 <button type="button" id="nopeFun" class="btn btn-danger">??????</button>
							  	 </c:if>
							 </c:if>
							  <c:set var="gEmp" value="${ap.empNo}"/>
							  <c:if test="${fn:contains(gEmp,empNo)}">
								 	<button id="deleteBtn" class="btn btn-danger">????????????</button>
							 </c:if>
							  <button type="button" onclick="javascript:location.href='approvalView.do';" class="btn btn-secondary">????????????</button>
						  </div>
					  </div>	
					</div>
				</div>
				<script type="text/javascript">
					$(document).on('click','#agreeFun',function(){
						if(confirm("'${ap.apTitle}'??? ????????? ?????? ???????????????????")){
							var cate = "g";
							var agree = "Y";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#disareeFun',function(){
						if(confirm("'${ap.apTitle}'??? ????????? ?????? ???????????????????")){
							var cate = "g";
							var agree = "R";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#yesFun',function(){
						if(confirm("'${ap.apTitle}'??? ????????? ?????? ???????????????????")){
							var cate = "h";
							var agree = "Y";
							updateApFun(cate,agree);
						}
					});
					
					$(document).on('click','#nopeFun',function(){
						if(confirm("'${ap.apTitle}'??? ????????? ?????? ???????????????????")){
							var cate = "h";
							var agree = "R";
							updateApFun(cate,agree);
						}
					});
					$(document).on('click','#deleteBtn',function(){
						if(confirm("'${ap.apTitle}'??? ????????? ?????? ???????????????????\n ?????? ??? ???????????? ??????????????????.")){
							var apNo = "${ap.apNo}";
							$.ajax({
								url:"deleteAp.do",
								data:{apNo:apNo},
								type:"post",
								success:function(data){
									if(data=="success"){
										alert("???????????? ????????? ?????????????????????.\n?????? ???????????? ???????????????.");
										location.href="approvalView.do";
									}else{
										alert("????????? ?????????????????????.\n??????????????? ??????????????????");
									}
								}
							});
						}
					});
					
					
					function updateApFun(cate,agree){
						var loginEmp = "${empNo}";
						var apNo = "${ap.apNo}";
						var status="";
						var plusStatus="";
						if(cate=='h'){
							status= "${ap.hEmp}";
							plusStatus= "${ap.approvalEmp}";
						}else if(cate=='g'){
							status= "${ap.approvalEmp}";
							plusStatus= "${ap.hEmp}";
						}
						$.ajax({
							url:"updateAp.do",
							data:{apNo:apNo,cate:cate,agree:agree,loginEmp:loginEmp,status:status,plusStatus:plusStatus},
							type:"POST",
							success:function(data){
								if(data=="success"){
									alert("???????????? ????????? ?????????????????????.\n?????? ???????????? ???????????????.");
									location.href="approvalView.do";
								}else{
									alert("????????? ?????????????????????.\n??????????????? ??????????????????");
								}
							}
						});
					}
				</script>

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
