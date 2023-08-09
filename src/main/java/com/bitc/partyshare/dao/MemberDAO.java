package com.bitc.partyshare.dao;

import org.apache.ibatis.annotations.Select;

import com.bitc.partyshare.vo.MemberVO;

public interface MemberDAO {

	/**
	 * 로그인 
	 */
	@Select("SELECT * FROM member WHERE mid = #{mid} AND mpw = #{mpw}")
	MemberVO login(MemberVO vo) throws Exception;
}
