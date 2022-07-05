package com.hallym.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hallym.vo.*;

@Repository
public class dao {
	
	@Autowired
	private SqlSession sqlSession1;
  
	private static final String Namespace = "com.hallym.solicitation";
	
	public userVO selectUserInfo(userVO u) {
		userVO result = this.sqlSession1.selectOne(Namespace + ".selectUserInfo", u);
	    return result;
	}
	
	public userVO selectUserInfo2(userVO u) {
		userVO result = this.sqlSession1.selectOne(Namespace + ".selectUserInfo2", u);
	    return result;
	}
	
	public userVO selectUserInfo3(userVO u) {
		userVO result = this.sqlSession1.selectOne(Namespace + ".selectUserInfo3", u);
	    return result;
	}
	
	public userVO selectUserInfo4(userVO u) {
		userVO result = this.sqlSession1.selectOne(Namespace + ".selectUserInfo4", u);
	    return result;
	}
	
	public int signUp(userVO u) {
		int result = this.sqlSession1.insert(Namespace + ".signUp", u);
	    return result;
	}
	
	public int modifyInfo(userVO u) {
		int result = this.sqlSession1.update(Namespace + ".modifyInfo", u);
	    return result;
	}
	
	public targetVO selectTarget(targetVO t) {
		targetVO result = this.sqlSession1.selectOne(Namespace + ".selectTarget", t);
	    return result;
	}
	
	public int insertTarget(targetVO t) {
		int result = this.sqlSession1.insert(Namespace + ".insertTarget", t);
	    return result;
	}
	
	public int insertEval(evaluationVO e) {
		int result = this.sqlSession1.insert(Namespace + ".insertEval", e);
	    return result;
	}
	
	public int insertInterview(interviewVO i) {
		int result = this.sqlSession1.insert(Namespace + ".insertInterview", i);
	    return result;
	}
	
	public int updateTarget(targetVO t) {
		int result = this.sqlSession1.update(Namespace + ".updateTarget", t);
	    return result;
	}
	
	public int updateEval(evaluationVO e) {
		int result = this.sqlSession1.update(Namespace + ".updateEval", e);
	    return result;
	}
	
	public List<userVO> selectAllUser(){
		List<userVO> u = this.sqlSession1.selectList(Namespace+ ".selectAllUser");
		return u;
	}
	
	public List<targetVO> selectAllTarget(){
		List<targetVO> t = this.sqlSession1.selectList(Namespace+ ".selectAllTarget");
		return t;
	}
	
	public List<interviewVO> selectInterview(int eval_no){
		evaluationVO e = new evaluationVO();
		e.setEval_no(eval_no);
		List<interviewVO> i = this.sqlSession1.selectList(Namespace+ ".selectInterview", e);
		return i;
	}
	
	public evaluationVO selectEval(int target_no){
		evaluationVO i = new evaluationVO();
		i.setTarget_no(target_no);
		evaluationVO e = this.sqlSession1.selectOne(Namespace+ ".selectEval", i);
		return e;
	}
	
	public evaluationVO selectTargetInfo(int target_no) {
		evaluationVO i = new evaluationVO();
		i.setTarget_no(target_no);
		evaluationVO e = this.sqlSession1.selectOne(Namespace+ ".selectTargetInfo", i);
		return e;
	}
	
	public int deleteInterview(interviewVO i) {
		int result = this.sqlSession1.delete(Namespace + ".deleteInterview", i);
	    return result;
	}
	
	public int accept(interviewVO i) {
		int result = 0;
		
		if(i.getWhich()==1) {
			i.setCheck1(1);
			result = this.sqlSession1.update(Namespace + ".updateInterview1", i);
		} else if(i.getWhich()==2) {
			i.setCheck2(1);
			result = this.sqlSession1.update(Namespace + ".updateInterview2", i);
		} else {
			i.setCheck3(1);
			result = this.sqlSession1.update(Namespace + ".updateInterview3", i);
		}
			
	    return result;
	}
	
	public List<evaluationVO> suitable(userVO u) {
		List<evaluationVO> result = this.sqlSession1.selectList(Namespace + ".suitable", u);
		return result;
	}
	
	public List<evaluationVO> search(userVO u) {
		List<evaluationVO> result;
		
		if(u.getUser_id()==null) {
			result = this.sqlSession1.selectList(Namespace + ".search", u);
			return result;
		}
		
		if(!u.getUser_id().equals("root")) {
			result = this.sqlSession1.selectList(Namespace + ".search2", u);
		} else {
			result = this.sqlSession1.selectList(Namespace + ".search", u);
		}
		return result;
	}
	
	public int selectTargetNo(String name, String email) {
		targetVO t = new targetVO();
		
		t.setName(name);
		t.setEmail(email);
		
		targetVO t1 = this.sqlSession1.selectOne(Namespace + ".selectTargetNo", t);

		if(t1 == null) {
			return -1;
		}
		
		return t1.getTarget_no();
	}
}
