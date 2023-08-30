package com.bitc.login.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.bitc.common.vo.AuthDTO;
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
	("SELECT * FROM member WHERE mId = #{mid}")
	MemberVO getMemberById(String mid)throws Exception;
	
	/**
	 * mId로 권한 정보 확인
	 */
	@Select("SELECT auth FROM validation_member_auth " + " WHERE mId = #{mid}")
	List<String> getAuthList(String mid) throws Exception;
	
	
	/**
	 * 회원가입한 회원 기본 권한 추가 ROLE_USER
	 */
	@Insert("INSERT INTO validation_member_auth " + " VALUES(#{mid},'ROLE_USER')")
	void insertAuth(String mid) throws Exception;
	
	/**
	 * Host 권한 부여
	 */
	@Insert("INSERT INTO validation_member_auth " + "VALUES(#{mid}, 'ROLE_HOST')")
	void insertHostAuth(String mid) throws Exception;

	/**
	 * 권한 회수
	 */
	@Delete("DELETE FROM validation_member_auth " + " WHERE mId = #{mid}" + " AND auth = #{auth}")
	void deleteAuth(AuthDTO auth) throws Exception;
	
}
