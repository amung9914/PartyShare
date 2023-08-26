package com.bitc.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.Criteria;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

public interface MemberDAO {

	// 회원 번호로 회원 정보 검색 
	@Select("select * from member where mnum=#{mnum}")
	public MemberVO selectMember(int mnum) throws Exception;
	
	// 회원 정보 수정
	@Update("UPDATE member SET mpw=#{mpw}, mname=#{mname}, mage=#{mage}, mgender=#{mgender}, maddr=#{maddr}, profileImageName=#{profileImageName} WHERE mnum=#{mnum}")
	public int modifyMember(MemberVO member) throws Exception;
	
	// 참여했던 파티 목록
	@Select("SELECT * FROM party WHERE pnum IN (SELECT pnum FROM joinmember WHERE mnum=#{mnum}) ORDER BY pnum DESC limit #{cri.startRow}, #{cri.perPageNum}")
	public List<PartyVO> joinPartyList(@Param("mnum") int mnum, @Param("cri") Criteria cri) throws Exception;
	
	// 참여한 파티 수
	@Select("SELECT count(*) FROM joinmember WHERE mnum=#{mnum}")
	public int joinCnt(int mnum) throws Exception; 
	
}
