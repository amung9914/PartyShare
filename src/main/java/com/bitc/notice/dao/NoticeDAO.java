package com.bitc.notice.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.checkerframework.checker.units.qual.degrees;

import com.bitc.member.vo.MemberVO;
import com.bitc.notice.provider.NoticeProvider;
import com.bitc.notice.vo.NoticeVO;

import lombok.Delegate;

public interface NoticeDAO {
		// date가 1년 이내인 것으로 date가 최신 순으로 선택
	@Select("SELECT * FROM notice WHERE date >= NOW() - INTERVAL 1 YEAR ORDER BY date DESC")
	public List<NoticeVO> allNotice() throws Exception;	// noticeDAO
	
	@Select("SELECT * FROM notice WHERE date >= NOW() - INTERVAL 1 YEAR AND readed ='N' ORDER BY date DESC ")
	public List<NoticeVO> noReadList() throws Exception;	// noticeDAO
	
	
	@Insert("INSERT INTO notice (context) VALEUS(#{context})")
	public void addNotice(NoticeVO vo) throws Exception;	// noticeDAO
	
	@Update("UPDATE notice SET readed = 'Y' WHERE noticeNum = #{noticeNum} AND mid=#{mid} ")
	public void readPost(@Param("noticeNum") int noticeNum, @Param("mid")String mid) throws Exception;	// noticeDAO
	
	@Select("SELECT * FROM member WHERE withdraw = 'N' ")
	public List<MemberVO> currentMember() throws Exception;	//noticeDAO
	
	//(type = BoardQueryProvider.class , method ="searchSelectSql")
	@InsertProvider(type = NoticeProvider.class , method ="insertPostAll")
	public void sendPost(List<MemberVO> list, NoticeVO notice) throws Exception; //noticeDAO
	
	@InsertProvider(type = NoticeProvider.class , method ="blackPost")	
	public void BlackPost(String mId, NoticeVO vo) throws Exception;	//noticeDAO
	
	@Select("SELECT * FROM notice WHERE readed ='N' AND mid = #{mid} ORDER BY date DESC")
	public List<NoticeVO> myNotcie (String mid) throws Exception;	//noticeDAO
	
	@Select("SELECT * FROM notice WHERE  readed ='Y' AND mid = #{mid} ORDER BY date DESC")
	public List<NoticeVO> bonPostList (String mid) throws Exception;
	
	@Delete("DELETE FROM notice WHERE no = #{no} AND mid = #{mid}")
	public void deletePost (@Param("no") int no ,@Param("mid") String mid ) throws Exception;
	
}
