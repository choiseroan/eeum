package com.spring.finalproject;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.spring.finalproject.Approval.model.service.ApprovalService;
import com.spring.finalproject.Approval.model.vo.Approval;
import com.spring.finalproject.Board.model.service.BoardService;
import com.spring.finalproject.Board.model.vo.Board;
import com.spring.finalproject.Board.model.vo.UCalendar;
import com.spring.finalproject.Employee.model.service.EmployeeService;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.Reservation.model.service.ReservationService;
import com.spring.finalproject.Reservation.model.vo.Reservation;
import com.spring.finalproject.Todo.model.service.TodoService;
import com.spring.finalproject.Todo.model.vo.Todo;

@Controller
public class HomeController {
	
	@Autowired
	BoardService bService;
	
	@Autowired
	ReservationService rService;
	
	@Autowired
	private EmployeeService eService;
	
	@Autowired
	ApprovalService aService;
	
	@Autowired
	private TodoService tService;
	
//	@RequestMapping(value = "home.do", method = RequestMethod.GET)
//	public String home(Locale locale, Model model) {
//		return "home";
//	}
	
	@RequestMapping(value = "home.do", method = RequestMethod.GET)
	public ModelAndView calView(ModelAndView mv,HttpSession session) {
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		//?????? ????????? ?????? ?????????
		ArrayList<Reservation> rList =  rService.selectAllRes("%"+loginEmp.getEmpNo()+"%");
		
		//?????? ????????????!
		ArrayList<Employee> eList = eService.selectDeptEmp(loginEmp.getDeptNo());
		
		//???????????? ??????(???????????? ?????????)
		ArrayList<String> emp = new ArrayList<>();
		for(Employee e : eList) {
			emp.add(e.getEmpNo());
		}
		//?????? ???????????? ??????list
		ArrayList<Approval>aList = aService.selectDeptVacation(emp);
		//???????????? ????????? ?????? - ?????? ??????, ?????? ??????, ????????????
		ArrayList<UCalendar> cList = bService.selectAllCaledar("%"+loginEmp.getEmpNo()+"%");
		
		
		//????????? list
		// 1. ???????????? ????????? - title, startDay
		ArrayList<HashMap<String,String>> r_rlist = new ArrayList<>();
		// 2. ??????????????? ????????? - title-> ?????? , start
		ArrayList<HashMap<String,String>> r_eList = new ArrayList<>();
		// 3. ?????? ?????????-  title-> ?????? , start, finish
		ArrayList<HashMap<String,String>> r_vList = new ArrayList<>();
		// 4. ?????? ??????
		ArrayList<UCalendar> r_pList = new ArrayList<>();
		// 5. ?????? ??????
		ArrayList<UCalendar> r_sList = new ArrayList<>();
		// 6. ?????? ??????
		ArrayList<UCalendar> r_aList = new ArrayList<>();
		
		
		//1. ?????? ?????? list
		for(Reservation r : rList) {
			String str = r.getrDate();
			String[] temp = str.split(";");
			
			HashMap<String,String> map = new HashMap<>();
			map.put("start", temp[0]);
			map.put("title", r.getmTitle());
			
			r_rlist.add(map);
		}
		
		//????????? ????????? ?????? ??? ??????!
		GregorianCalendar today = new GregorianCalendar();
		int year = today.get(Calendar.YEAR);
		for(Employee e : eList) {
			String joinDate = e.getJoinDate()+"";
			String[] temp = joinDate.split("-");
			joinDate= year+"-"+temp[1]+"-"+temp[2];
			/* e.setJoinDate(joinDate.setYear(Year)); */
			HashMap<String,String> map = new HashMap<>();
			map.put("start", joinDate);
			map.put("title", e.getEmpName());
			
			r_eList.add(map);
		}
		
		//?????? 
		for(Approval ap : aList) {
			HashMap<String,String> map = new HashMap<>();
			//?????? ????????????
			String empNo = ap.getEmpNo();
			String empName = "";
			for(Employee e : eList) {
				if(e.getEmpNo().equals(empNo)) {
					empName = e.getEmpName();
				}
			}
			map.put("title", empName);
			map.put("start", ap.getA_v_first()+"");
			map.put("finish", ap.getA_v_last()+"");
			
			r_vList.add(map);
		}
		
		//????????? ?????????
		for(UCalendar c : cList) {
			Employee e = new Employee();
			e.setEmpNo(c.getEmpNo());
			Employee Emp = eService.selectEmp(e);
			c.setEmpNo("( "+Emp.getEmpNo()+" ) "+Emp.getEmpName()+" - "+Emp.getDeptName()); 
			
			if(c.getcStatus().equals("A")) {
				//????????????
				r_aList.add(c);
			}else if(c.getEmpNo() != null) {
				//????????????
				if(c.getEmpNo().contains(loginEmp.getEmpNo())) {
					r_pList.add(c);
				}
			}
			if(c.getsEmp()!=null){
				//?????? ???????????? ??????
				if(c.getsEmp().contains(loginEmp.getEmpNo())) {
					r_sList.add(c);
				}
			}
		}
		
		mv.addObject("r_pList",r_pList);
		mv.addObject("r_sList",r_sList);
		mv.addObject("r_aList",r_aList);
		mv.addObject("rlist",r_rlist);
		mv.addObject("elist",r_eList);
		mv.addObject("vlist",r_vList);
		/**********************************????????? ?????? ???! - ???????????? ?????? ??????!**************************************/
		ArrayList<Board> bList = bService.selectNewBoard();//5?????? ?????????!
		mv.addObject("bList",bList);
		/******************************************to-do??????**********************************************/
		ArrayList<Todo> tList = tService.selectAllUndo(loginEmp.getEmpNo());
		mv.addObject("tList",tList);
		/*****************************************????????? ??????***************************************************/
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		String[] temp = strDate.split(" ");
		String startOfDate = temp[0]+" "+"00:00:00";
		
		HashMap<String,String> keys = new HashMap<>();
		keys.put("empNo", loginEmp.getEmpNo());
		keys.put("date", strDate);
		keys.put("start", startOfDate);
		
		HashMap<String,String> map = eService.selectCommute(keys);
		mv.addObject("map",map);

		mv.setViewName("home");
		return mv;
	}
	
	
	//????????????
	@RequestMapping(value = "chulgun.do")
	@ResponseBody
	public String chulgun(HttpSession session) {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		String EmpNo = loginEmp.getEmpNo();

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		
		HashMap<String,String> map = new HashMap<>();
		map.put("empNo", EmpNo);
		map.put("Date", strDate);
		
		
		int result = eService.chulgun(map);
		if(result>0) {
			return strDate;
		}else {
			return "fail";
		}
	}
	
	//????????????!
	@RequestMapping("goHome.do")
	public void goHome(HttpSession session,HttpServletResponse response) throws IOException {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		String[] temp = strDate.split(" ");
		String startOfDate = temp[0]+" "+"00:00:00";
		
		HashMap<String,String> keys = new HashMap<>();
		keys.put("empNo", loginEmp.getEmpNo());
		keys.put("date", strDate);
		keys.put("start", startOfDate);
		int result = eService.updateCommute(keys);
		
		//??? ?????? ??????!
		HashMap<String,String> map = eService.selectCommute(keys);
		
		//?????? ????????? map
		HashMap<String,Object> rMap = new HashMap<>();
		
		
		if(result>0) {
			rMap.put("result","success");
			rMap.put("time", strDate);
			rMap.put("map", map);
		}else {
			rMap.put("result","fail");
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd kk:mm:ss").create();
		gson.toJson(rMap,response.getWriter());
	}
	
	//????????? ??????... -> ????????? ????????? ????????? ?????? ????????????.(api??????)
	@RequestMapping("getMychulgun.do")
	public void getMychulgun(HttpSession session,HttpServletResponse response) throws IOException {
		Employee loginEmp = (Employee) session.getAttribute("loginEmp");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
		String strDate = dateFormat.format(Calendar.getInstance().getTime());
		String[] temp = strDate.split(" ");
		String startOfDate = temp[0]+" "+"00:00:00";
		
		HashMap<String,String> keys = new HashMap<>();
		keys.put("empNo", loginEmp.getEmpNo());
		keys.put("date", strDate);
		keys.put("start", startOfDate);
		HashMap<String,String> map = eService.selectCommute(keys);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		gson.toJson(map,response.getWriter());
	}
	
	//?????? ??????!
	@RequestMapping("selectAlert.do")
	public void selectAlert(HttpServletResponse response, @RequestParam("empNo") String empNo) throws IOException {
		ArrayList<HashMap<String,Object>> list =eService.selectAlert(empNo);
		for(HashMap<String,Object> map : list) {
			map.put("ACONTENTS", URLEncoder.encode((String) map.get("ACONTENTS"),"utf-8"));
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
	    gson.toJson(list,response.getWriter());
	}
	
	//?????? ????????????
	@RequestMapping("nAllDelete.do")
	@ResponseBody
	public String NotmailAllDelete(@RequestParam("empNo")String empNo,@RequestParam("check")String check) {
		HashMap<String,String> map = new HashMap<>();
		map.put("empNo", empNo);
		map.put("check", check);
		int result = eService.updateAllAlert(map);
		if(result>0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	//?????? ?????? ?????? and update
	@RequestMapping("aOneUpdate.do")
	@ResponseBody
	public String aOneUpdate(@RequestParam("aStatus")String aStatus, @RequestParam("alertNo")String alertNo) {
		HashMap<String,String> map = new HashMap<>();
		map.put("aStatus", aStatus);
		map.put("alertNo", alertNo);
		int result = eService.updateAlert(map);
		if(result>0) {
			return "success";
		}else{
			return "fail";
		}
	}
	
}
