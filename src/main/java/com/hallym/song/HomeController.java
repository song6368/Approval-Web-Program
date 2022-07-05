package com.hallym.song;

import java.io.File;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.hallym.song.*;
import com.hallym.vo.*;
import com.hallym.service.*;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	service service;
	
	GoogleVisionApiTester g = new GoogleVisionApiTester();
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Locale locale, Model model, HttpServletRequest request) {
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			if (u != null) {
				model.addAttribute("user", u);
			} else {
				model.addAttribute("user", null);
			}
			
			return "index";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
	}
	
	@RequestMapping(value = "current", method = RequestMethod.GET)
	public String current(Locale locale, Model model, HttpServletRequest request) {
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			if (u != null) {
				model.addAttribute("user", u);
			} else {
				model.addAttribute("user", null);
			}
			
			return "current";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
	}
	
	@RequestMapping(value = "solicitation", method = RequestMethod.GET)
	public String solicitation(Locale locale, Model model, HttpServletRequest request) {
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			if (u != null) {
				model.addAttribute("user", u);
			} else {
				model.addAttribute("user", null);
			}
			
			return "solicitation";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
	}
	
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insert(Locale locale, Model model, HttpServletRequest request) {
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			if (u != null) {
				model.addAttribute("user", u);
			} else {
				model.addAttribute("user", null);
				model.addAttribute("msg", "로그인이 필요합니다.");
				return "index";
			}
			
			if(!u.getUser_id().equals("root")) {
				model.addAttribute("msg", "등록 권한이 없습니다.");
				return "index";
			}
			
			return "insert";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
	}
	
	@RequestMapping(value = { "login" }, method = { RequestMethod.POST })
	public String login(HttpServletRequest request, Model model, @RequestParam("user_id") String user_id, @RequestParam("user_pw") String user_pw, @RequestParam("gr") String gr) throws Exception {
		try {
			HttpSession session = request.getSession();
			
			String user_ip = getServerIp(request);
			
			userVO user = new userVO();
			
			user.setUser_id(user_id);
			user.setUser_pw(user_pw);
			user.setUser_ip(user_ip);
			user.setGr(gr);
			
			int result = this.service.login(user);
			
			if (result != 0) {
				session.setAttribute("member", user);
				model.addAttribute("user", user);
				model.addAttribute("msg", "로그인에 성공하엿습니다.");
				return "index";
			}
			
			model.addAttribute("msg", "로그인에 실패하였습니다.");
			return "login";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = { "logout" }, method = { RequestMethod.GET})
	public String logout(HttpServletRequest request, Model model) throws Exception {
		
		try {
			HttpSession session = request.getSession();
			session.setAttribute("member", null);
			model.addAttribute("msg", "로그아웃하였습니다.");
			
			return "index";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = { "selectAllUser" }, method = { RequestMethod.GET})
	@ResponseBody
	public List<userVO> selectAllUser() throws Exception {
		
		List<userVO> u = new ArrayList<userVO>();
		u = service.selectAllUser();
		
		System.out.println(u.get(0).getUser_id());
		return u;
	}
	
	@RequestMapping(value = { "checkUser" }, method = { RequestMethod.POST})
	@ResponseBody
	public evaluationVO checkUser(HttpServletRequest request, Model model) throws Exception {
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		int target_no = service.selectTargetNo(name, email);
		
		if(target_no==-1) {
			return null;
		}
		
		evaluationVO e = service.selectTargetInfo(target_no);
		
		return e;
	}
	
	@RequestMapping(value = { "accept" }, method = { RequestMethod.POST})
	@ResponseBody
	public int accept(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		
		String eval_no_s = request.getParameter("eval_no");
		String which_s = request.getParameter("which");
		int eval_no = Integer.parseInt(eval_no_s);
		int which = Integer.parseInt(which_s);
		interviewVO i = new interviewVO();
		i.setInterview_id(u.getUser_id());
		i.setEval_no(eval_no);
		i.setWhich(which);
		int result = service.accept(i);
		
		return result;
	}
	
	@RequestMapping(value = { "selectInfo" }, method = { RequestMethod.POST})
	@ResponseBody
	public List<evaluationVO> selectInfo() throws Exception {
		
		List<targetVO> u = new ArrayList<targetVO>();
		u = service.selectAllTarget();
		
		List<evaluationVO> e = new ArrayList<evaluationVO>();
		
		evaluationVO e1 = new evaluationVO();
		
		for(int i = 0; i < u.size(); i++) {
			e1 = new evaluationVO();
			e1 = service.selectEval(u.get(i).getTarget_no());
			e1.setName(u.get(i).getName());
			if(agree(e1.getEval_no())==1){
				e1.setCheck(1);
			}
			e.add(e1);
		}
		
		return e;
	}
	
	@RequestMapping(value = { "selectInfo2" }, method = { RequestMethod.POST})
	@ResponseBody
	public List<evaluationVO> selectInfo2(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		
		List<evaluationVO> e = new ArrayList<evaluationVO>();
		
		e = service.suitable(u);
		
		for(int i = 0; i < e.size(); i++) {
			if(agree(e.get(i).getEval_no())==1){
				e.get(i).setCheck(1);
			}
		}
		
		return e;
	}
	
	@RequestMapping(value = { "selectInfo3" }, method = { RequestMethod.POST})
	@ResponseBody
	public List<evaluationVO> selectInfo3(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");

		if(u == null) {
			u = new userVO();
		}
		
		List<evaluationVO> e = new ArrayList<evaluationVO>();
		
		u.setName(request.getParameter("search"));
		
		e = service.search(u);
		
		for(int i = 0; i < e.size(); i++) {
			if(agree(e.get(i).getEval_no())==1){
				e.get(i).setCheck(1);
			}
		}
		
		return e;
	}
	
	@RequestMapping(value = { "selectInfo4" }, method = { RequestMethod.POST})
	@ResponseBody
	public List<evaluationVO> selectInfo4(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		
		List<evaluationVO> e = new ArrayList<evaluationVO>();
		
		u.setName(request.getParameter("search"));
		
		e = service.search(u);
		
		for(int i = 0; i < e.size(); i++) {
			if(agree(e.get(i).getEval_no())==1){
				e.get(i).setCheck(1);
			}
		}
		
		return e;
	}
	
	@RequestMapping(value = { "selectTargetInfo" }, method = { RequestMethod.POST})
	@ResponseBody
	public evaluationVO selectTargetInfo(HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		
		String target_no_s = request.getParameter("target_no");
		int target_no = Integer.parseInt(target_no_s);
		evaluationVO e = new evaluationVO();
		e = service.selectTargetInfo(target_no);

		List<interviewVO> i = new ArrayList<interviewVO>();
		i = service.selectInterview(e.getEval_no());
		
		for(int j = 0; j < i.size(); j++) {
			if(i.get(j).getInterview_id().equals(u.getUser_id())){
				e.setCheck1(i.get(j).getCheck1());
				e.setCheck2(i.get(j).getCheck2());
				e.setCheck3(i.get(j).getCheck3());
			}
		}
		
		if(request.getParameter("con")==null) {
			String read1 = g.readImage(e.getEval_image1());
			String read2 = g.readImage(e.getEval_image2());
			String read3 = g.readImage(e.getEval_image3());
			
			read1 = read1.replace("\n", "");
			read2 = read2.replace("\n", "");
			read3 = read3.replace("\n", "");
			
			read1 = read1.replace("지원자", "");
			read2 = read2.replace("지원자", "");
			read3 = read3.replace("지원자", "");
			read1 = read1.replace("면접관", "");
			read2 = read2.replace("면접관", "");
			read3 = read3.replace("면접관", "");
			read1 = read1.replace("점수", "");
			read2 = read2.replace("점수", "");
			read3 = read3.replace("점수", "");
			
			read1 = read1.replace(" ", "");
			read2 = read2.replace(" ", "");
			read3 = read3.replace(" ", "");
			
			e.setRead1(read1);
			e.setRead2(read2);
			e.setRead3(read3);
		}
		
		return e;
	}
	
	@RequestMapping(value = { "openModifyInfo" }, method = { RequestMethod.GET})
	public String openModifyInfo(HttpServletRequest request, Model model) throws Exception {
		
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			model.addAttribute("user", u);
			
			return "modifyInfo";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = { "modify2" }, method = { RequestMethod.POST})
	public String modify2(HttpServletRequest request, Model model, @RequestParam("target_no") String target_no) throws Exception {
		
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			model.addAttribute("user", u);
			
			model.addAttribute("msg", "정보 수정 후에는 다시 면접관들이 수락하여야합니다.");
			
			model.addAttribute("target_no", target_no);
			
			return "modify2";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = { "modify" }, method = { RequestMethod.GET})
	public String modify(HttpServletRequest request, Model model) throws Exception {
		
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			if (u != null) {
				model.addAttribute("user", u);
			} else {
				model.addAttribute("user", null);
				model.addAttribute("msg", "로그인이 필요합니다.");
				return "index";
			}
			
			if(!u.getUser_id().equals("root")) {
				model.addAttribute("msg", "수정 권한이 없습니다.");
				return "index";
			}
			
			return "modify";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = { "recieve" }, method = { RequestMethod.GET})
	public String recieve(HttpServletRequest request, Model model) throws Exception {
		
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			if (u != null) {
				model.addAttribute("user", u);
			} else {
				model.addAttribute("user", null);
				model.addAttribute("msg", "로그인이 필요합니다.");
				return "index";
			}
			
			if(u.getUser_id().equals("root")) {
				model.addAttribute("msg", "접수내역 확인 권한이 없습니다.");
				return "index";
			}
			
			return "recieve";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = { "modifyInfo" }, method = { RequestMethod.POST})
	public String modifyInfo(HttpServletRequest request, Model model, @RequestParam("user_pw") String user_pw) throws Exception {
		
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			u.setUser_pw(user_pw);
			
			int result= service.modifyInfo(u);
			
			if(result==1) {
				model.addAttribute("msg", "정보가 수정되었습니다. 로그아웃되었습니다.");
				
				return "index";
			} else {
				model.addAttribute("msg", "정보 수정에 실패하였습니다.");
				
				return "index";
			}
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = "openLogin", method = RequestMethod.GET)
	public String openLogin(Locale locale, Model model, HttpServletRequest request) {
		
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			if (u != null) {
				model.addAttribute("user", u);
			} else {
				model.addAttribute("user", null);
			}
			
			return "login";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = { "openSignUp" }, method = { RequestMethod.GET})
	public String openSignUp(HttpServletRequest request, Model model) throws Exception {
		
		try {
			String ip = getServerIp(request);
			
			model.addAttribute("ip", ip);
			
			return "signUp";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
		
	}
	
	@RequestMapping(value = { "recieve2" }, method = { RequestMethod.POST})
	public String recieve2(HttpServletRequest request, Model model, @RequestParam("target_no") String target_no) throws Exception {
		
		try {
			HttpSession session = request.getSession();
			userVO u = (userVO) session.getAttribute("member");
			
			if (u != null) {
				model.addAttribute("user", u);
			} else {
				model.addAttribute("user", null);
				model.addAttribute("msg", "로그인이 필요합니다.");
				return "index";
			}
			
			if(u.getUser_id().equals("root")) {
				model.addAttribute("msg", "접수내역 확인 권한이 없습니다.");
				return "index";
			}
			
			model.addAttribute("user", u);
			
			model.addAttribute("target_no", target_no);
			
			return "recieve2";
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생");
			return "index";
		}
	}
	
	@RequestMapping(value = { "upload" }, method = { RequestMethod.POST})
	public String upload(HttpServletRequest request, Model model, @RequestParam("eval_image") MultipartFile[] file, 
			@RequestParam("name") String name, @RequestParam("pn") String pn,
			@RequestParam("email") String email, @RequestParam("dept") String dept, 
			@RequestParam("eval_score1_1") int eval_score1_1, 
			@RequestParam("eval_score1_2") int eval_score1_2,
			@RequestParam("eval_score1_3") int eval_score1_3,
			@RequestParam("eval_score2_1") int eval_score2_1, 
			@RequestParam("eval_score2_2") int eval_score2_2,
			@RequestParam("eval_score2_3") int eval_score2_3,
			@RequestParam("eval_score3_1") int eval_score3_1, 
			@RequestParam("eval_score3_2") int eval_score3_2,
			@RequestParam("eval_score3_3") int eval_score3_3,
			@RequestParam("eval_score1_4") int eval_score1_4,
			@RequestParam("eval_score2_4") int eval_score2_4,
			@RequestParam("eval_score3_4") int eval_score3_4,
			@RequestParam("interview_id1") String interview_id1,
			@RequestParam("interview_id2") String interview_id2,
			@RequestParam("interview_id3") String interview_id3) throws Exception {
		
		String uploadPath = "C:\\u\\pic\\";

		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		
		if(!u.getUser_id().equals("root")) {
			model.addAttribute("msg", "등록 권한이 없습니다.");
			return "index";
		}
		
		if(interview_id1.equals(interview_id2) || interview_id1.equals(interview_id3) || interview_id2.equals(interview_id3)) {
			model.addAttribute("msg", "면접관 아이디가 겹치면 안됩니다.");
			return "insert";
		}
		
		File target;
		targetVO t = new targetVO();
		evaluationVO e = new evaluationVO();
		t.setName(name);
		t.setDept(dept);
		t.setEmail(email);
		t.setPn(pn);
		t.setRegister(u.getUser_id());
		
		int result1 = service.existTarget(t);
		
		if(result1 == 1) {
			model.addAttribute("msg", "이미 등록된 대상입니다.");
			return "insert";
		} else {
			service.insertTarget(t);
		}
		
		System.out.println(eval_score1_1);
		targetVO t1 = service.selectTarget(t);
		
		e.setTarget_no(t1.getTarget_no());
		e.setEval_score1_1(eval_score1_1);
		e.setEval_score1_2(eval_score1_2);
		e.setEval_score1_3(eval_score1_3);
		e.setEval_score2_1(eval_score2_1);
		e.setEval_score2_2(eval_score2_2);
		e.setEval_score2_3(eval_score2_3);
		e.setEval_score3_1(eval_score3_1);
		e.setEval_score3_2(eval_score3_2);
		e.setEval_score3_3(eval_score3_3);
		e.setEval_score1_4(eval_score1_4);
		e.setEval_score2_4(eval_score2_4);
		e.setEval_score3_4(eval_score3_4);
		e.setInterview_id1(interview_id1);
		e.setInterview_id2(interview_id2);
		e.setInterview_id3(interview_id3);
		
		if(file.length == 3) {
			for(int i = 0; i < file.length; i++) {
				target = new File(uploadPath, name+"_"+file[i].getOriginalFilename());
				file[i].transferTo(target);
				if(i == 0) {
					e.setEval_image1(uploadPath+name+"_"+file[i].getOriginalFilename());
				} if(i == 1) {
					e.setEval_image2(uploadPath+name+"_"+file[i].getOriginalFilename());
				} if(i == 2) {
					e.setEval_image3(uploadPath+name+"_"+file[i].getOriginalFilename());
				}
			}
			service.insertEval(e);
			
			evaluationVO e1 = new evaluationVO();
			e1 = service.selectEval(t1.getTarget_no());
			
			interviewVO i = new interviewVO();
			i.setEval_no(e1.getEval_no());
			
			i.setInterview_id(interview_id1);
			service.insertInterview(i);
			
			i.setInterview_id(interview_id2);
			service.insertInterview(i);
			
			i.setInterview_id(interview_id3);
			service.insertInterview(i);
			
		} else {
			model.addAttribute("msg", "첨부파일은 전부 올려야 합니다.");
			return "insert";
		}
		model.addAttribute("msg", "인력지원 정보가 접수되었습니다. 각 면접관이 수락하면 정상등록됩니다.");
		return "insert";

	}
	
	@RequestMapping(value = { "upload2" }, method = { RequestMethod.POST})
	public String upload2(HttpServletRequest request, Model model, @RequestParam("eval_image") MultipartFile[] file, 
			@RequestParam("name") String name, @RequestParam("pn") String pn,
			@RequestParam("email") String email, @RequestParam("dept") String dept, 
			@RequestParam("eval_score1_1") int eval_score1_1, 
			@RequestParam("eval_score1_2") int eval_score1_2,
			@RequestParam("eval_score1_3") int eval_score1_3,
			@RequestParam("eval_score2_1") int eval_score2_1, 
			@RequestParam("eval_score2_2") int eval_score2_2,
			@RequestParam("eval_score2_3") int eval_score2_3,
			@RequestParam("eval_score3_1") int eval_score3_1, 
			@RequestParam("eval_score3_2") int eval_score3_2,
			@RequestParam("eval_score3_3") int eval_score3_3,
			@RequestParam("eval_score1_4") int eval_score1_4,
			@RequestParam("eval_score2_4") int eval_score2_4,
			@RequestParam("eval_score3_4") int eval_score3_4,
			@RequestParam("interview_id1") String interview_id1,
			@RequestParam("interview_id2") String interview_id2,
			@RequestParam("interview_id3") String interview_id3,
			@RequestParam("target_no") int target_no) throws Exception {
		
		String uploadPath = "C:\\u\\pic\\";

		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		
		if(!u.getUser_id().equals("root")) {
			model.addAttribute("msg", "수정 권한이 없습니다.");
			return "index";
		}
		
		if(interview_id1.equals(interview_id2) || interview_id1.equals(interview_id3) || interview_id2.equals(interview_id3)) {
			model.addAttribute("msg", "면접관 아이디가 겹치면 안됩니다.");
			return "index";
		}
			
		File target;
		targetVO t = new targetVO();
		evaluationVO e = new evaluationVO();
		t.setTarget_no(target_no);
		
		evaluationVO test = service.selectTargetInfo(target_no);
		
		if(!test.getName().equals(name)) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "index";
		}
		
		t.setDept(dept);
		t.setEmail(email);
		t.setPn(pn);
		t.setRegister(u.getUser_id());
		
		int upd1 = service.updateTarget(t);
		
		if(upd1 == 0) {
			model.addAttribute("msg", "수정 실패");
			return "index";
		}
		
		e.setTarget_no(target_no);
		e.setEval_score1_1(eval_score1_1);
		e.setEval_score1_2(eval_score1_2);
		e.setEval_score1_3(eval_score1_3);
		e.setEval_score2_1(eval_score2_1);
		e.setEval_score2_2(eval_score2_2);
		e.setEval_score2_3(eval_score2_3);
		e.setEval_score3_1(eval_score3_1);
		e.setEval_score3_2(eval_score3_2);
		e.setEval_score3_3(eval_score3_3);
		e.setEval_score1_4(eval_score1_4);
		e.setEval_score2_4(eval_score2_4);
		e.setEval_score3_4(eval_score3_4);
		e.setInterview_id1(interview_id1);
		e.setInterview_id2(interview_id2);
		e.setInterview_id3(interview_id3);
		
		if(file.length == 3) {
			for(int i = 0; i < file.length; i++) {
				target = new File(uploadPath, name+"_"+file[i].getOriginalFilename());
				file[i].transferTo(target);
				if(i == 0) {
					e.setEval_image1(uploadPath+name+"_"+file[i].getOriginalFilename());
				} if(i == 1) {
					e.setEval_image2(uploadPath+name+"_"+file[i].getOriginalFilename());
				} if(i == 2) {
					e.setEval_image3(uploadPath+name+"_"+file[i].getOriginalFilename());
				}
			}
			service.updateEval(e);
			
			evaluationVO e1 = new evaluationVO();
			e1 = service.selectEval(target_no);
			
			interviewVO i = new interviewVO();
			i.setEval_no(e1.getEval_no());

			service.deleteInterview(i);
			
			i.setInterview_id(interview_id1);
			service.insertInterview(i);
			
			i.setInterview_id(interview_id2);
			service.insertInterview(i);
			
			i.setInterview_id(interview_id3);
			service.insertInterview(i);
			
			model.addAttribute("user", u);
			model.addAttribute("msg", "인력지원 정보가 접수되었습니다. 각 면접관이 수락하면 정상등록됩니다.");
			return "insert";
			
		} else {
			model.addAttribute("msg", "첨부파일은 전부 올려야 합니다.");
			return "insert";
		}

	}
	
	@RequestMapping(value = { "signUp" }, method = { RequestMethod.POST})
	public String signUp(HttpServletRequest request, Model model, @RequestParam("user_id") String user_id, @RequestParam("user_pw") String user_pw) throws Exception {
		
		try {
			userVO u = new userVO();
			u.setUser_id(user_id);
			u.setUser_ip(getServerIp(request));
			u.setUser_pw(user_pw);
			
			String gr = null;
			while(true) {
				gr = generateRandom();
				u.setGr(gr);
				
				if(service.checkGr(u) == 1) {
					continue;
				} else {
					System.out.println(gr);
					break;
				}
			}
			
			int result= service.signUp(u);
			
			if(result==1) {
				model.addAttribute("msg", "가입에 성공하였습니다.");
				model.addAttribute("gr", gr);
				return "index";
			} else {
				model.addAttribute("msg", "가입에 실패하였습니다. 동일 아이디나 ip가 존재합니다.");
				
				String ip = getServerIp(request);
				
				model.addAttribute("ip", ip);
				
				return "signUp";
			}
			
		} catch(Exception e) {
			model.addAttribute("msg", "오류 발생, 동일 아이디나 해당 ip에 아이디가 존재합니다.");
			return "index";
		}
		
	}
	
	private String getServerIp(HttpServletRequest request) throws UnknownHostException {
		String ip = request.getHeader("X-Forwarded-For");
	    if (ip == null) ip = request.getRemoteAddr();
	    return ip;
	}
	
	private String generateRandom() {
		char[] tmp = new char[10];
		for(int i=0; i<tmp.length; i++) {
			int div = (int) Math.floor( Math.random() * 2 );
			
			if(div == 0) {
				tmp[i] = (char) (Math.random() * 10 + '0') ;
			}else {
				tmp[i] = (char) (Math.random() * 26 + 'A') ;
			}
		}
		return new String(tmp);
	}
	
	private int agree(int eval_no) {
		List<interviewVO> inter = service.selectInterview(eval_no);
		
		int sum = 0;
		
		for(int i = 0; i < inter.size(); i++) {
			sum += inter.get(i).getCheck1();
			sum += inter.get(i).getCheck2();
			sum += inter.get(i).getCheck3();
		}
		
		if(sum == 9) {
			return 1;
		} else {
			return 0;
		}
	}
}
