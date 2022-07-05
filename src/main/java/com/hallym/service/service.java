package com.hallym.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hallym.dao.*;
import com.hallym.vo.*;

@Service
public class service {
	
	@Autowired
	dao dao;
	
	public int login(userVO u) {
		userVO result = dao.selectUserInfo(u);
		
		if(result != null) {
			return 1;
		} else {
			return 0;
		}
	}
	
	public int modifyInfo(userVO u) {
		int result = dao.modifyInfo(u);
		
		return result;
	}
	
	public int signUp(userVO u) {
		int result = 0;
		if(dao.selectUserInfo2(u)==null && dao.selectUserInfo3(u)==null)
			result = dao.signUp(u);
		
		return result;
	}
	
	public int checkGr(userVO u) {
		userVO result = dao.selectUserInfo4(u);
		
		if(result != null) {
			return 1;
		} else {
			return 0;
		}
	}
	
	public int existTarget(targetVO t) {
		targetVO result = dao.selectTarget(t);
		
		if(result != null) {
			return 1;
		} else {
			return 0;
		}
	}
	
	public targetVO selectTarget(targetVO t) {
		targetVO result = dao.selectTarget(t);
		
		return result;
	}
	
	public List<evaluationVO> suitable(userVO u) {
		List<evaluationVO> result = dao.suitable(u);
		
		return result;
	}
	
	public List<evaluationVO> search(userVO u) {
		List<evaluationVO> result = dao.search(u);
		
		return result;
	}
	
	public int insertTarget(targetVO t) {
		int result = dao.insertTarget(t);
		
		return result;
	}
	
	public int insertEval(evaluationVO e) {
		int result = dao.insertEval(e);
		
		return result;
	}
	
	public List<userVO> selectAllUser(){
		List<userVO> u = dao.selectAllUser();
		
		return u;
	}
	
	public evaluationVO selectEval(int target_no) {
		evaluationVO e = dao.selectEval(target_no);
		
		return e;
	}
	
	public int insertInterview(interviewVO i) {
		int result = dao.insertInterview(i);
		
		return result;
	}
	
	public int updateTarget(targetVO t) {
		int result = dao.updateTarget(t);
		
		return result;
	}
	
	public int updateEval(evaluationVO e) {
		int result = dao.updateEval(e);
		
		return result;
	}
	
	public List<targetVO> selectAllTarget(){
		List<targetVO> t = dao.selectAllTarget();
		
		return t;
	}
	
	public List<interviewVO> selectInterview(int eval_no){
		List<interviewVO> inter = dao.selectInterview(eval_no);
		
		return inter;
	}
	
	public evaluationVO selectTargetInfo(int target_no) {
		evaluationVO e = dao.selectTargetInfo(target_no);
		return e;
	}
	
	public int deleteInterview(interviewVO i) {
		int result = dao.deleteInterview(i);
		return result;
	}
	
	public int accept(interviewVO i) {
		int result = dao.accept(i);
		return result;
	}
	
	public int selectTargetNo(String name, String email) {
		int result = dao.selectTargetNo(name, email);
		return result;
	}
	 
}
