package com.bitc.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bitc.chat.vo.ChatVO;

public interface ChatDAO {

	/**
	 * 채팅 목록 출력(무한페이징) 
	 */
	@Select("SELECT * FROM chat WHERE pnum=#{pnum} AND cnum <= #{endNo} ORDER BY cnum desc limit 0, 10")
	public List<ChatVO> getChatList(@Param("pnum") int pnum, @Param("endNo") int endNo) throws Exception;

	/**
	 * 채팅창 입장시 저장된 채팅 목록 출력
	 */
	@Select("SELECT * FROM chat WHERE pnum=#{pnum} AND finish='N' ORDER BY cNum asc limit #{totalCount}, 20")
	public List<ChatVO> getFirstChatList(@Param("pnum") int pnum, @Param("totalCount") int totalCount) throws Exception;
	
	/**
	 * 채팅 내용 저장 
	 */
	@Insert("INSERT INTO chat(pnum, mnum, nick, content) VALUES(#{pnum}, #{mnum}, #{nick}, #{content})")
	public int insertChat(ChatVO chat)throws Exception;
	
	/**
	 * 채팅 방마다 총 채팅 개수
	 */
	@Select("SELECT count(*) FROM chat WHERE pnum=#{pnum}")
	public int getTotalCount(int pnum) throws Exception;
	
	/**
	 * 마지막으로 저장된 채팅번호
	 */
	@Select("SELECT cnum FROM chat WHERE cnum=LAST_INSERT_ID()")
	public int getLastChatNum() throws Exception;
}
