<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType= "text/html; charset=UTF-8" pageEncoding= "UTF-8" %>
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
a{ cursor: pointer;}
a:link { color: gray; text-decoration: none;}
a:visited { color: gray; text-decoration: none;}
a:hover { color: gray; text-decoration: none;}

.buttons{
	display: inline-block;
	width: 80%;
	margin-left: auto;
	margin-right: auto;
}

#a,#g,#c,#s{
	display: inline-block;
	margin-left: 1em;
	margin-right: 1em;
}

.empList{
	display : inline-block;
	width: 20rem;
	height: 18rem;
	margin: 3rem;
	border: 1px solid lightgray;
	margin-left: auto;
	margin-right: auto;
	list-style-type : none;
	padding: 0;
	overflow:auto;
}
li{
	margin: 0;
	padding : 0;
	width: 100%;
}

.bgclss{
	background-color:rgb(240,240,240);
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
		<script type="text/javascript">
			var hEmp ="";
			var gEmp ="";
			var cEmp ="";
			var sEmp ="";
			var tEmp = "";
		</script>
		<!-- ????????? ?????? -->
		<div class="container-fluid">
			<!-- ????????? ?????? -->
			<div class="d-sm-flex align-items-center justify-content-between mb-4">
				<h1 class="h3 mb-0 text-gray-800">??????</h1>
			</div>
			<div class="row">
				<div class="col-lg-4">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">??????</h6>
						</div>
						<div class="card-body">
							<table class="table table-bordered" id="dataTable">
                  <colgroup>
                  	<col width="40%">
                  	<col>
                  </colgroup>
                  <thead>
                    <tr>
                      <th>??????</th>
                      <th>???</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>??????</th>
                      <th>???</th>
                    </tr>
                  </tfoot>
                  <tbody>
					<c:forEach var="dl" items="${deptlist }">
					<c:set var="dDeptNo" value="${dl.deptNo}"/>	
					<% int i = 0; %>			
						<tr>
							<td><b>${dl.deptName}</b></td>
							
							<c:forEach var="tl" items="${teamlist}">
								<c:set var="tDeptNo" value="${tl.deptNo}"/>
								<c:if test="${fn:startsWith(tDeptNo,dDeptNo)}">
									<c:choose>
										<c:when test="<%=i==0 %>">
											<td>
												<a class="getEmp">
													<input class="tDeptNo" type="hidden" value="${tDeptNo}">
													${tl.deptName}( ${tDeptNo} )
												</a>
											</td>
										</c:when>
										<c:otherwise>
											</tr>
											<tr>
											<td></td>
											<td >
												<a class="getEmp">
												<input class="tDeptNo" type="hidden" value="${tDeptNo}">
												${tl.deptName}( ${tDeptNo} )
												</a>
											</td>
										</c:otherwise>
									</c:choose>
									<% i++; %>
								</c:if>
							</c:forEach>
						</tr>
					</c:forEach>
                  </tbody>
                </table>
                <script type="text/javascript">
					$(document).on('click','.getEmp',function(){
						var deptNo = $(this).find(".tDeptNo").val();
						$(this).closest("tbody").children("tr").removeClass("bgclss");
						$(this).closest("tr").addClass('bgclss');
						$.ajax({
							url:"getEmployee.do",
							data:{deptNo:deptNo},
							dataType:"json",
							success:function(data){
								$tableBody = $('#empList tbody');
								$tableBody.html('');
								
								if(data==""){
									var $tr = $('<tr>');
									var $td = $('<td colspan="3">').text("?????? ????????? ?????????!");
									
									$tr.append($td);
									$tableBody.append($tr);
								}
								
								for(var i in data){
									if(!tEmp.includes(data[i].empNo) && (data[i].empNo!="${loginEmp.empNo}")){
										var $tr = $('<tr class="selectTr" style="cursor:pointer">');
										var $deptName = $('<td>').text("(" + data[i].deptNo+") "+decodeURIComponent(data[i].deptName.replace(/\+/g, " ")) );
										var $empPosition = $('<td>').text("lv." + data[i].empPosition);
										var $empName =$('<td>').text("("+data[i].empNo+") "+decodeURIComponent(data[i].empName.replace(/\+/g, " ")));
										
										var $input1 =$('<input class="empNo" type="hidden">').val("("+data[i].empNo+") "+decodeURIComponent(data[i].empName.replace(/\+/g, " ")));
										var $input2 =$('<input class="deptName" type="hidden">').val("(" + data[i].deptNo+") "+decodeURIComponent(data[i].deptName.replace(/\+/g, " ")) );
										var $input3 =$('<input class="empPosition" type="hidden">').val("lv." + data[i].empPosition);
										
										
										$empName.append($input1);
										$empName.append($input2);
										$empName.append($input3);
										$tr.append($deptName);
										$tr.append($empPosition);
										$tr.append($empName);
										
										$tableBody.append($tr);
									
									}
								}
							},
							error : function(){console.log("error")}
						});
					});
					
					$(document).on('click','.selectTr',function(){
						$(this).closest("tbody").children("tr").removeClass("bgclss");
						$(this).addClass('bgclss');
					})
                </script>
						</div>
					</div>
				</div>
				<div class="col-lg-8">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">????????? ??????</h6>
						</div>
						<div class="card-body">
							<table class="table table-bordered" id="empList" style="text-align: center;">
								<thead>
									<tr>
										<th>??????</th>
										<th>??????</th>
										<th>??????</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td colspan="3" id="shut">????????? ????????? ??????????????????!</td>
									</tr>
								</tbody>
							</table>
							<div class="row" style="text-align: center;">
								<div class="buttons">
									<a style="cursor: pointer;"  class="btn btn-secondary btn-icon-split" id="h">
					                    <span class="icon text-white-50">
					                      <i class="fa fa-arrow-down"></i>
					                    </span>
					                    <span class="text" style="color: white;">??????</span>
					                  </a>
					                  <a style="cursor: pointer;" class="btn btn-secondary btn-icon-split" id="g">
					                    <span class="icon text-white-50">
					                      <i class="fa fa-arrow-down"></i>
					                    </span>
					                    <span class="text" style="color: white;">??????</span>
					                  </a>
					                  <a style="cursor: pointer;" class="btn btn-secondary btn-icon-split" id="c">
					                    <span class="icon text-white-50">
					                      <i class="fa fa-arrow-down"></i>
					                    </span>
					                    <span class="text" style="color: white;">??????</span>
					                  </a>
					                  <a style="cursor: pointer;" class="btn btn-secondary btn-icon-split" id="s">
					                    <span class="icon text-white-50">
					                      <i class="fa fa-arrow-down"></i>
					                    </span>
					                    <span class="text" style="color: white;">??????</span>
					                  </a>
				                  </div>
				                  <script type="text/javascript">
				                  //??????-list??? ??????
						              	$(document).on('click','#h',function(){
						              		addList('realH','#hlist');
										});
				                  
				                //list ????????? ????????? ??????
				                	$(document).on('click','.realH',function(){
				                		addbgClass(this);
									});
				                  
								//list ??????????????? ??????
									$(document).on('dblclick','.realH',function(){
										removeLi(this,hEmp);
									});
								
								
								//??????
									$(document).on('click','#g',function(){
										addList('realG','#glist');
									});
							 	//list ????????? ????????? ??????
			                	$(document).on('click','.realG',function(){
			                		addbgClass(this);
								});
							 
			                	//list ??????????????? ??????
								$(document).on('dblclick','.realG',function(){
									removeLi(this,gEmp);
									
								});
									 
			                	
			                	
								//??????
									$(document).on('click','#c',function(){
										addList('realC','#clist');
									});
								 //list ????????? ????????? ??????
				                	$(document).on('click','.realC',function(){
				                		addbgClass(this);
									});
								 
				                	//list ??????????????? ??????
									$(document).on('dblclick','.realC',function(){
										removeLi(this,cEmp);
										
									});
				                	
				                	
									//??????
									$(document).on('click','#s',function(){
										addList('realS','#slist');
									});
								 	//list ????????? ????????? ??????
				                	$(document).on('click','.realS',function(){
				                		addbgClass(this);
									});
				                	//list ??????????????? ??????
									$(document).on('dblclick','.realS',function(){
										removeLi(this,sEmp);
									});
										
				                	
				                	
				                	//?????? list ??? append ?????? function
				                	function addList(realClass,listId){
				                		var empNo = $("#empList").find('.bgclss').find('.empNo').val();
				                		if(empNo!= undefined){
						              		var deptName = $("#empList").find('.bgclss').find('.deptName').val();
						              		var empPosition =$("#empList").find('.bgclss').find('.empPosition').val();
						              		
						              		$("#empList").find('.bgclss').hide();
						              		$("#empList").find('.bgclss').removeClass('bgclss');
						              		
						              		
						              		$li =$('<li>').attr('class',realClass).text(empNo);
						              		$input1 = $('<input type="hidden" class="empNo">').val(empNo);
						              		$input2 = $('<input type="hidden" class="deptName">').val(deptName);
						              		$input3 = $('<input type="hidden" class="empPosition">').val(empPosition);
						              		
						              		$ul = $(listId);
											
						              		$li.append($input1);
						              		$li.append($input2);
						              		$li.append($input3);
						              		$ul.append($li);
						              		
						              		if(listId == '#slist'){
						              			sEmp += empNo +', ';
						              		}else if(listId == '#hlist'){
						              			hEmp += empNo +', ';
						              		}else if(listId == '#clist'){
						              			cEmp += empNo +', ';
						              		}else if(listId == '#glist'){
						              			gEmp += empNo +', ';
						              		}
						              		
						              		tEmp += empNo +', ';
				                		}
				                	}
				                	
				                	//????????? ????????????function
				                	function addbgClass(a){
				                		$(a).closest('ul').children("li").removeClass("bgclss");
										$(a).addClass('bgclss');
				                	}
				                	
				                	//??????????????? ???????????? function
				                	function removeLi(a,empV){
				                		var empNo= $(a).find('.empNo').val();//??????(??????)
										var deptName = $(a).find('.deptName').val();//??????
										var empPosition = $(a).find('.empPosition').val();//??????
										
										$(a).hide();
										//?????? list ??? split?????? ?????? ?????? ?????? ?????? ??????
										
										var array = empV.split(', ');
										empV="";
										for (i = 0; i < array.length; i++){
											if(empNo != array[i] && array[i]!=""){
												empV+=array[i]+", ";
											}
										}
										
										var class_name = $(a).attr('class');
										if(class_name.includes('realH')){
											hEmp = empV;
											console.log(hEmp);
										}else if(class_name.includes('realG')){
											gEmp = empV;
											console.log(gEmp);
										}else if(class_name.includes('realC')){
											cEmp = empV;
											console.log(cEmp);
										}else if(class_name.includes('realS')){
											sEmp = empV;
											console.log(sEmp);
										}
										
										
										array = tEmp.split(', ');
										tEmp="";
										
										for (i = 0; i < array.length; i++){
											if(empNo!=array[i] && array[i]!=" "){
												tEmp+=array[i]+", ";
											}
										}
										
										//?????? ???????????? ?????? ????????? ??????..- ?????? ?????? ????????? ????????? ????????????!
										var selectDept = $("#dataTable").find('.bgclss').find('.tDeptNo').val();
										 if(deptName.indexOf(selectDept)>=0){
											$tableBody = $('#empList tbody');
											var $tr = $('<tr class="selectTr" style="cursor:pointer">');
											var $deptName = $('<td>').text(deptName);
											var $empPosition = $('<td>').text(empPosition);
											var $empName =$('<td>').text(empNo);
											
											var $input1 =$('<input class="empNo" type="hidden">').val(empNo);
											var $input2 =$('<input class="deptName" type="hidden">').val(deptName);
											var $input3 =$('<input class="empPosition" type="hidden">').val(empPosition);
											
											$empName.append($input1);
											$empName.append($input2);
											$empName.append($input3);
											$tr.append($deptName);
											$tr.append($empPosition);
											$tr.append($empName);
											
											$tableBody.append($tr);
											
										}
				                	}
				                	
				                  </script>
							</div>
							<hr style="margin-top: 2rem; margin-bottom: 2rme;">
							<div class="row">
								<ul class="empList" id="hlist" style="text-align: center;">
									<li style="margin-top:5px;margin-bottom:5px;"><h5>?????????</h5></li>
								</ul>
								<ul class="empList" id="glist" style="text-align: center;">
									<li style="margin-top:5px;margin-bottom:5px"><h5>?????????</h5></li>
								</ul>
							</div>
							<div class="row">
								<ul class="empList" id="clist" style="text-align: center;">
									<li style="margin-top:5px;margin-bottom:5px"><h5>?????????</h5></li>
								</ul>
								<ul class="empList" id="slist" style="text-align: center;">
									<li style="margin-top:5px;margin-bottom:5px"><h5>?????????</h5></li>
								</ul>
							</div>
							<div class="row">
								<div style="display: inline-block; margin : 5rem; margin-left: auto; margin-right: auto;">
									<a onclick="nextFun();" class="btn btn-light btn-icon-split">
					                    <span class="icon text-gray-600">
					                      <i class="fas fa-arrow-right"></i>
					                    </span>
					                    <span class="text">????????????</span>
					                  </a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div>
				<form id="hiddenform" action="nextPage.do" method="post"></form>
			</div>
		</div>
		<script type="text/javascript">
			function nextFun(){
				if(gEmp!=''){
					var tag = "${tag}";
				$hiddenform =$('#hiddenform');
				$hiddenform.html('');
				var $input1 =$('<input name="hEmp" type="hidden">').val(hEmp);
				var $input2 =$('<input name="gEmp" type="hidden">').val(gEmp);
				var $input3 =$('<input name="cEmp" type="hidden">').val(cEmp);
				var $input4 =$('<input name="sEmp" type="hidden">').val(sEmp);
				var $input5 =$('<input name="tag" type="hidden">').val(tag);
				
				$hiddenform.append($input1);
				$hiddenform.append($input2);
				$hiddenform.append($input3);
				$hiddenform.append($input4);
				$hiddenform.append($input5);
				
				$('#hiddenform').submit();
				
				}else{
					alert("???????????? ????????? ???????????? ?????????!");
				}
			}
		</script>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>
</body>

</html>
