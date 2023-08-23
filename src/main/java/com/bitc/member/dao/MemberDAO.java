package com.bitc.member.dao;

import org.apache.ibatis.annotations.Select;

import com.bitc.member.vo.MemberVO;

public interface MemberDAO {

	/**
	 * test용 로그인 
	 */
	@Select("SELECT * FROM member WHERE mid = #{mid} AND mpw = #{mpw}")
	MemberVO login(MemberVO vo) throws Exception;
}
