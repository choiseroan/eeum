<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true" %>
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

<!-- Full Calendar  -->
<link href='${contextPath}/resources/fullcalendar/core/main.css' rel='stylesheet' />
<link href='${contextPath}/resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
<script src='${contextPath}/resources/fullcalendar/core/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/interaction/main.js'></script>
<script src='${contextPath}/resources/fullcalendar/daygrid/main.js'></script>
<style type="text/css">
 a:link { text-decoration: none;}
 a:visited { text-decoration: none;}
 a:hover { text-decoration: none;}
.todo_check{
	display: none;
}
.todo_tr:hover{
background: rgba(225,225,225,0.8);
cursor: pointer;
}
#hideTr{
display: none;
}
.chulgun{
	transition: .8s;
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
				<h1 class="h3 mb-0 text-gray-800">Home</h1>
			</div>
			<div class="row">
				<div class="col-lg-8">
					<div class="card shadow mb-4">
						<div class="card-body" >
	           			 	<div id="calendar" class="fc fc-ltr fc-bootstrap">
	           			 	<script type="text/javascript">
	           				 document.addEventListener('DOMContentLoaded', function() {
							    var calendarEl = document.getElementById('calendar');
		           		 		var today = new Date();
			
							    var calendar = new FullCalendar.Calendar(calendarEl, {
							        plugins: [ 'interaction', 'dayGrid' ],
							        defaultDate: today,
							        editable: false,
							        eventLimit: true,
							        views: {
							            dayGrid: {
							               eventLimit: 3
							            }
							        },
							      });
							    //?????? ??????
							    <c:forEach var ='i' items='${rlist}'>
					           		calendar.addEvent({'title': '${i.title}',
					           							'id':'N',
					           							'start':'${i.start}',
					           							'url':'rListView.do',
					           							'color':'rgb(20,20,50)',
					           							'textColor':'white'
					           							});
			           			</c:forEach>
			           			
			           			//???????????????
			           			<c:forEach var ='i' items='${elist}'>
					           		calendar.addEvent({'title': '${i.title}??? ???????????????',
					           							'id':'N',
					           							'start':'${i.start}',
					           							'url':'organization.do',
					           							'color':'#FFBB00',
					           							'textColor':'white'
					           							});
			           			</c:forEach>
			           			//??????
			           			<c:forEach var ='i' items='${vlist}'>
				           		calendar.addEvent({'title': '${i.title}??? ??????',
				           							'id':'N',
				           							'start':'${i.start}',
				           							'end':'${i.finish}',
				           							'color':'#5F00FF',
				           							'textColor':'white'
				           							});
		           				</c:forEach>
		           				//????????????
		           				<c:forEach var ='i' items='${r_pList}'>
				           		calendar.addEvent({ 'id':'m;${i.cNo};${i.empNo}',
				           							'title': '${i.cTitle}',
				           							'start':'${i.cDate}',
				           							'end':'${i.cFDate}',
				           							'url':'calPage.do',
				           							'color':'#0054FF',
				           							'textColor':'white'
				           							});
		           				</c:forEach>
		           				//????????????
		           				<c:forEach var ='i' items='${r_sList}'>
				           		calendar.addEvent({ 'id':'s;${i.cNo};${i.empNo}',
													'title': '${i.cTitle}',
				           							'start':'${i.cDate}',
				           							'end':'${i.cFDate}',
				           							'color':'#CC3D3D',
				           							'url':'calPage.do',
				           							'textColor':'white'
				           							});
				           		//????????????
				           		</c:forEach>
		           				<c:forEach var ='i' items='${r_aList}'>
				           		calendar.addEvent({'id':'a;${i.cNo};${i.empNo}',
		   											'title': '${i.cTitle}',
				           							'start':'${i.cDate}',
				           							'end':'${i.cFDate}',
				           							'color':'#A566FF',
				           							'url':'calPage.do',
				           							'textColor':'#fff'
				           							});
		           				</c:forEach>
							      calendar.render();
							    });
	           			 	</script>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="card shadow mb-4">
						<div class="card-body" >
						<h4 style="margin-bottom: 1rem;">?????????</h4>
						<div style="padding: 1.5rem; font-size: 1.3rem;">
							<p id="pClock">
							</p>
							<p class="chulgun">
								<c:if test="${!empty map.ATTEND}">
								?????? : ${map.ATTEND}
								</c:if>
								<c:if test="${empty map.ATTEND}">
								?????? : ?????? ?????? ????????? ???????????? ????????????!
								</c:if>
							</p>
							<p class="zipgalle">
								<c:if test="${!empty map.ATTEND && empty map.GOHOME}">
								?????? : ?????? ?????? ????????? ???????????? ????????????!
								</c:if>
								<c:if test="${!empty map.GOHOME}">
								?????? : ${map.GOHOME}
								</c:if>
							</p>
							<p id="resultArea">
							</p>
						</div>
						<c:if test="${empty map.ATTEND}">
							<a id="commute" class="btn btn-primary btn-user btn-block" style="color: white;">
			                 	????????????!
			                </a>
		                </c:if>
		                <c:if test="${!empty map.ATTEND &&  empty map.GOHOME}">
							<a class="btn btn-success btn-user btn-block goHome" style="color: white;">
			                 	????????????
			                </a>
		                </c:if>
		              	  <a class="btn btn-success btn-user btn-block goHome" style="color: white; display: none;">
			                 	????????????
			                </a>
						</div>
						<script type="text/javascript">
						    function showClock()
						    {
						        var currentDate=new Date();
						        var pClock=document.getElementById("pClock");
						        var apm=currentDate.getHours();
						        if(apm<12)
						        {
						            apm="?????? ";
						        }
						        else
						        {
						            apm="?????? ";
						        }
						        
						        var msg = "????????????  : "+apm +(currentDate.getHours())+" ??? ";
						        msg += currentDate.getMinutes() + " ???  ";
						        msg += currentDate.getSeconds() + " ???  ";
						        
						        pClock.innerText=msg;
						        
						        setTimeout(showClock,1000);
						    }
						    
						    $(document).ready(function(){
						    	showClock();
						    });
						</script>
				</div>
				<div class="card shadow mb-4">
						<div class="card-body" >
							<h4 id="board" style="margin-bottom: 1rem; cursor: pointer;">?????? ??????</h4>
							<div class="table-responsive">
								<table class="table table-bordered">
									<thead>
										<tr style="text-align: center;"> 											
											<th>??????</th>
											<th>??????</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var ="i"  items="${bList}">
										<c:url var="bdetail" value="bdetail.do">
					                  		<c:param name="bNo" value="${i.bNo}"/>
					                  		<c:param name="page" value="1"/>
					                  	</c:url>
										<tr>
											<td>
												<c:set var="bContent" value="${i.bContent}"/>
												<c:if test="${fn:contains(bContent,'<img')}">
													<i class="fa fa-picture-o" aria-hidden="true"></i>
												</c:if>
												<c:if test="${fn:contains(bContent,'<iframe')}">
													<i class="fa fa-video-camera" aria-hidden="true"></i>
												</c:if>
												<a href="${bdetail}" style="color: rgb(70,70,70);">${i.bTitle}</a>
											</td>
											<td>
												${fn:split(i.bDate,'-')[1]}/${fn:split(i.bDate,'-')[2]} 
											</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
				</div>
				<div class="card shadow mb-4">
						<div class="card-body" >
							<h4 style="margin-bottom: 1rem;cursor: pointer;" id="go_todo">??????</h4>
							<div class="table-responsive">
								<table class="table table-bordered">
									<c:forEach var="i" items="${tList}">
									<tr class="todo_tr">
										<td>
										<input type="hidden" class="todo_id" value="${i.tNo}">
										${i.tTitle} - ${i.tContent}
										<i class="fa fa-check todo_check" aria-hidden="true" style="float: right; margin-right: 1rem;"></i>
										</td>
									</tr>
									</c:forEach>
									<tr id="hideTr"><td class="empty_todo" style="text-align: center; cursor: pointer;">?????? ????????? ??? ?????? ????????????!</td></tr>
									<c:if test="${empty tList}">
										<tr><td class="empty_todo" style="text-align: center; cursor: pointer;">?????? ????????? ??? ?????? ????????????!</td></tr>
									</c:if>
								</table>
								<script type="text/javascript">
									$(".todo_tr").mouseenter(function(){
										$(this).find(".todo_check").show();
									});
									$(".todo_tr").mouseleave(function(){
										$(this).find(".todo_check").hide();
									});
									$(".empty_todo").mouseenter(function(){
										$(this).text("???????????? ?????????????");
									});
									$(".empty_todo").mouseleave(function(){
										$(this).text("?????? ????????? ??? ?????? ????????????!");
									});
									$(document).on('click','.empty_todo',function(){
										location.href="todoView.do";
									});
									$(document).on('click','#go_todo',function(){
										location.href="todoView.do";
									});
									$(document).on('click','.todo_tr',function(){
										var tNo = $(this).find(".todo_id").val();
										$(this).hide(1000).removeClass("todo_tr");
										var count = $('.todo_tr').length;
										if(count==0){
											setTimeout(function(){
												$("#hideTr").fadeIn(1000);
											}, 1000);
										}
										var tStatus = 'D';
										$.ajax({
											url:"updateTodo.do",
											data : {tNo:tNo,tStatus:tStatus},
											type: "post",
											success: function(data){
												console.log(data);
											}
										});
									});
									$(document).on('click','#board',function(){
										location.href="notice.do";
									});
									$(document).on('click','#commute',function(){
										$.ajax({
											url:"chulgun.do",
											type:"post",
											success:function(data){
												if(data=="fail"){
													alert("?????? ????????? ??????????????????.\n??????????????? ??????????????????!");
												}else{
													$("#commute").hide();
													$(".goHome").fadeIn(1000);
													$(".chulgun").text("?????? : "+data);
													$(".zipgalle").text("?????? : ?????? ?????? ????????? ???????????? ????????????!");
														clock.start();
												}
											}
										});
									});
									$(document).on('click','.goHome',function(){
										var result ="";
										var check = false;
										if(watSub<32400){
											check = confirm("?????? ?????? ????????? ??????????????????.\n????????? ?????????????????????????");
											$("#resultArea").css('color','red');
											result = "????????????";
										}else{
											check = confirm("????????? ?????????????????????????");
											result = "????????????";
											$("#resultArea").css('color','green');
										}
										if (check){
											$.ajax({
												url:"goHome.do",
												dataType:"json",
												success:function(data){
													if(data.result=="fail"){
														alert("??????????????? ??????????????????.\n??????????????? ??????????????????!");
													}else{
														$(".goHome").fadeOut(1000);
														$(".zipgalle").text("?????? : "+data.map.GOHOME);
														setTimeout(function(){
														$("#resultArea").text(result);
														}, 980);
														clock.stop();
													}
												}
											});
										}
									});
									
									$(document).ready(function(){
										console.log("${map.GOHOME}");
										setTimeout(function(){
											if(watSub<32400 && "${map.GOHOME}"!=""){
												$("#resultArea").css('color','red');
												$("#resultArea").text("????????????");
											}else if(watSub>=32400 && "${map.GOHOME}"!=""){
												$("#resultArea").css('color','green');
												$("#resultArea").text("????????????");
											}
										}, 100);
									})
									
								</script>
							</div>
						</div>
				</div>
			</div>


		</div>

	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false"></jsp:include>

</body>

</html>
