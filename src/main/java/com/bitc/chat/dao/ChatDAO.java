package com.bitc.chat.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.bitc.chat.vo.ChatVO;

public interface ChatDAO {

	@Select("SELECT * FROM chat WHERE pnum=#{pnum} AND cNum <= #{endNo} ORDER BY cNum desc limit 0, 10")
	public List<ChatVO> getChatList(@Param("pnum") int pnum, @Param("endNo") int endNo) throws Exception;

	@Select("SELECT * FROM chat WHERE pnum=#{pnum} AND finish='N' ORDER BY cNum asc limit #{totalCount}, 20")
	public List<ChatVO> getFirstChatList(@Param("pnum") int pnum, @Param("totalCount") int totalCount) throws Exception;

	@Insert("INSERT INTO chat(pnum, mnum, nick, content) VALUES(#{pnum}, #{mnum}, #{nick}, #{content})")
	public int insertChat(ChatVO chat)throws Exception;
	
	@Select("SELECT count(*) FROM chat WHERE pnum=#{pnum}")
	public int getTotalCount(int pnum) throws Exception;
	
	@Select("SELECT cNum FROM chat WHERE cNum=LAST_INSERT_ID()")
	public int getLastChatNum() throws Exception;
}
