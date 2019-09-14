package com.spring.finalproject.Board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.finalproject.Board.model.exception.BoardException;
import com.spring.finalproject.Board.model.service.BoardService;
import com.spring.finalproject.Board.model.vo.Board;
import com.spring.finalproject.Board.model.vo.PageInfo;
import com.spring.finalproject.Employee.model.vo.Employee;
import com.spring.finalproject.common.Pagination;

@Controller
@SessionAttributes("loginEmp")
public class BoardController {

	@Autowired
	BoardService bService;

	@RequestMapping("notice.do")
	public ModelAndView noticeView(
									@RequestParam(value="search", required=false)String search,
									@RequestParam(value = "page", required = false) Integer page,
									@RequestParam(value="cate", required =false)String cate,
									ModelAndView mv) {
		int currentPage = 1; // 임의로 지정
		if (page != null) {
			// 페이징 버튼을 눌러서 페이지값이 바뀔 경우
			currentPage = page;
		}
		//전체 공지사항
		ArrayList<Board> important = bService.iSelectList();
		
		//페이징 공지사항
		int listCount = 0;
		
		
		//검색 영역
		String searchKey = "%" + search + "%";
		if(search == null){searchKey = "%%";}

		//검색 및 카테고리 넘기는 HashMap
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("searchKey", searchKey);
		map.put("cate",cate);
		
		if (search == null && cate ==null) {
			listCount = bService.getBListCount();
		} else {
			listCount = bService.SearchListCount(map);
		}
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		// pi로 유효한 페이지 가져오기
		ArrayList<Board> normal = new ArrayList<Board>();
		
		if (search == null) {
			normal = bService.bSelectList(pi);
		} else {
			normal = bService.selectSearchList(pi, map);
		}
		mv.addObject("cate",cate );
		mv.addObject("search",search);
		mv.addObject("important",important);
		mv.addObject("normal",normal);
		mv.addObject("pi", pi);
		mv.setViewName("board/board");
		return mv;
	}
	
	//글쓰기페이지로 이동
	@RequestMapping("bInsert.do")
	public String bInsertView() {
		return "board/boardInsert";
	}

	
	//사진 경로 변경 및 이름 가져오기
	@RequestMapping("getchagePhoto.do")
	@ResponseBody
	public String savePhoto(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "\\buploadFiles";

		File folder = new File(savePath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String originalFileName = file.getOriginalFilename();
		String renameFileName = sdf.format(new java.sql.Date(System.currentTimeMillis())) + "."
				+ originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
		// 확장자 빼고

		String renamePath = folder + "\\" + renameFileName;
		try {
			file.transferTo(new File(renamePath));// 전달받은 file이 rename명으로 저장
		} catch (IOException e) {
			e.printStackTrace();
		}

		return renameFileName;
	}
	
	//글삽입
	@RequestMapping("boardinsert.do")
	public String boardInsert(Board b, HttpSession session) {
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		b.setEmpNo(loginEmp.getEmpNo());
		int result = bService.boardInsert(b);
		if(result>0) {
			return "redirect:notice.do";
		}else {
			throw new BoardException("게시글 등록에 실패하였습니다.");
		}
	}
	
	//글보기
	@RequestMapping("bdetail.do")
	public ModelAndView boardDetail(@RequestParam("bNo") int bNo, @RequestParam("page") int page, ModelAndView mv) {
		int result = bService.addBoardCount(bNo);
		Board board = bService.selectBoard(bNo);
		if(board!=null && result>0) {
		mv.addObject("board",board).addObject("page",page).setViewName("board/boardDetail");
		}else {
			throw new BoardException("게시글 조회에 실패하였습니다.");
		}
		return mv;
	}
	
	//강조공지로 바꾸기(update)
	@RequestMapping("changeType.do")
	@ResponseBody
	public String changebType(Board b) {
		if(b.getbType().equals("I")) {
			b.setbType("B");
		}else {
			b.setbType("I");
		}
		int result = bService.changebType(b);
		if(result>0) {
		return b.getbType();
		}else {
			throw new BoardException("공지 상태 변경에 실패하였습니다.");
		}
	}
	
	//글수정 페이지로 이동
	@RequestMapping("bUpdateView.do")
	public ModelAndView bUpdateView(@RequestParam("bNo")String bNo, @RequestParam("page")int page,ModelAndView mv) {
		int no = Integer.parseInt(bNo);
		Board board = bService.selectBoard(no);
		if(board!=null) {
			mv.addObject("board",board).addObject("page",page).setViewName("board/boardUpdate");
		}else {
			throw new BoardException("게시글 수 정 페이지 이동에 실패하였습니다.");
		}
		
		return mv;
	}
	
	//글수정
	@RequestMapping("bUpdate.do")
	public String boardUpdat(Board b,@RequestParam("page")int page ) {
		int result = bService.boardUpdat(b);
		if(result>0) {
			return "redirect:notice.do?page="+page;
		}else {
			throw new BoardException("게시글 수정에 실패하였습니다.");
		}
	}
	
	//글 삭제
	@RequestMapping("bDelete.do")
	@ResponseBody
	public String deleteBoard(@RequestParam("bNo")String bNo) {
		int no = Integer.parseInt(bNo);
		int result = bService.deleteBoard(no);
		if(result>0) {
		return "success";
		}else {
			throw new BoardException("게시글 삭제에 실패하였습니다.");
		}
	}
	
	@RequestMapping("calPage.do")
	public ModelAndView calView(ModelAndView mv) {
		mv.setViewName("board/calender");
		return mv;
	}
}