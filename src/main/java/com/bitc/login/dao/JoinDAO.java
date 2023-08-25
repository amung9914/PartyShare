package com.bitc.login.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.bitc.login.vo.LoginDTO;
import com.bitc.member.vo.MemberVO;

public interface JoinDAO {
	
	// 회원가입 쿼리문
	@Insert
	("INSERT INTO member (mid,mpw,mname,mnick,mage,mgender,memail,maddr,profileImageName)"
			+"VALUES(#{mid},#{mpw},#{mname},#{mnick},#{mage},#{mgender},#{memail},#{maddr},#{profileImageName})")
	public int join(MemberVO vo) throws Exception;
	
	// 중복확인 쿼리문
	@Select
	("SELECT count(*) FROM member WHERE mid=#{mid}")
	public int joinCheck(String mId);
	
	// 로그인 할때 쿼리문
	@Select
	("SELECT * FROM member WHERE mid = #{mid} AND mpw = #{mpw}")
	public MemberVO loginCheck(LoginDTO dto);
	
	// 블랙아이디
	@Select
	("SELECT * FROM member WHERE mblackYN ='Y'")
	public String BlackId(MemberVO vo);
	
	// 쿠키관련
	@Select
	("SELECT * FROM member WHERE uid = #{uid}")
	MemberVO getMemberById(String mId)throws Exception;
	
	
}
