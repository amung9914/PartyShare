package com.bitc.login.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.bitc.login.vo.LoginDTO;
import com.bitc.member.vo.MemberVO;

public interface JoinDAO {
	
	// 회원가입 쿼리문
	@Insert
	("INSERT INTO Member (mId,mPw,mName,mNick,mAge,mGender,mEmail,mAddr,profileImageName)"
			+"VALUES(#{mId},#{mPw},#{mName},#{mNick},#{mAge},#{mGender},#{mEmail},#{mAddr},#{profileImageName})")
	public int join(MemberVO vo) throws Exception;
	
	// 중복확인 쿼리문
	@Select
	("SELECT count(*) FROM Member WHERE mId=#{mId}")
	public int joinCheck(String mId);
	
	// 로그인 할때 쿼리문
	@Select
	("SELECT * FROM Member WHERE mId = #{mId} AND mPw = #{mPw}")
	public MemberVO loginCheck(LoginDTO dto);
	
	// 블랙아이디
	@Select
	("SELECT * FROM Member WHERE mBlacYN ='Y'")
	public String BlackId(MemberVO vo);
	
	// 쿠키관련
	@Select
	("SELECT * FROM Member WHERE uid = #{uid}")
	MemberVO getMemberById(String mId)throws Exception;
	
	
}
