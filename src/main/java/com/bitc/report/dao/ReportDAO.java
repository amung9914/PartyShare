package com.bitc.report.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.member.vo.MemberVO;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyCommentVO;
import com.bitc.report.vo.PbReportVO;
import com.bitc.report.vo.ReportVO;

public interface ReportDAO {
		
	@Select("SELECT * FROM report WHERE bno IS NULL ORDER BY date") //,no,bno,cno ")
	public List<ReportVO> reportList() throws Exception;	//reportDAO
	
	@Select("SELECT count(*) FROM report")
	public int countReport() throws Exception;	//reportDAO
	
	@Select("SELECT * FROM report WHERE no = #{no}")
	public ReportVO selectReport(int no) throws Exception;	//reportDAO
	
//	@Update("UPDATE freeboard reported = 'Y' WHERE bno = #{bno}")
//	public void reportBoard(int bno) throws Exception;	//reportDAO
	
//	@Update("UPDATE partyboard_comment reported = 'Y' WHERE cno = #{cno}")
//	public void reportComment(int cno) throws Exception;	//reportDAO
	
	// INSERT 諛섑솚���엯 �솗�씤�븯�윭 == void
	@Insert("INSERT INTO report (fromMid, toMid, category, context) "
			+ "VALUES (#{fromMid}, #{toMid}, #{category}, #{context})")  // no AI , date=DF
	void addReport(ReportVO vo) throws Exception;	// reportDAO
	
	@Select("SELECT * FROM report WHERE fromMid = #{mid} ")
	List<ReportVO> reportReview(MemberVO vo) throws Exception;	// reportDAO
	
	@Update("UPDATE member SET mbanCnt = mbanCnt+1 WHERE mid = #{target} ")
	void addReportCnt (String target) throws Exception;	// reportDAO
	
	@Update("UPDATE member SET mblackYN = 'Y' , mbanCnt = 0  WHERE mbanCnt = 10")
	int cntOut() throws Exception;	// reportDAO
	
	
	// �씤�꽣�뀎�꽣 �쟾泥섎━濡� �삷湲곌린
	@Select("SELECT * FROM report WHERE fromMid = #{fromMid} "
			+ "AND ( toMid = #{toMid} "
			+ "AND (date >= NOW() - INTERVAL 1 month AND date <= NOW()))")
	List<ReportVO> reportInMonth (ReportVO report) throws Exception;	// reportDAO
	
	//�떊怨좉� �젒�닔�맂 �뙎湲��씠�굹 寃뚯떆湲� 紐⑸줉 異쒕젰 
	@Select("SELECT * FROM report WHERE  bno IS NOT NULL ORDER BY date DESC limit #{startRow}, #{perPageNum} ")
	List<ReportVO> reportedBoard(Criteria cri) throws Exception;
//	reported = 'R' AND   WHERE  bno IS NOT NULL
	
	/**
	 * �뙆�떚蹂대뱶
	 * */
	@Select("SELECT * FROM  partyboard_report WHERE readed = 'N' ORDER BY date DESC")
	List<PbReportVO> reportedPartyBoard()throws Exception;
	
	@Update("UPDATE partyboard_report SET readed ='Y' WHERE no = #{no}")
	void readPBR(PbReportVO vo) throws Exception;
	
	
	@Update("UPDATE freeboard_comment SET showboard = 'B' WHERE showBoard = 'Y' AND cno = #{cno}")
	void blindComment(ReportVO vo) throws Exception;
	//파티 
	@Update("UPDATE freeboard SET showBoard = 'B' WHERE showBoard = 'Y' AND bno = #{bno}")
	void blindBoard(ReportVO vo) throws Exception;
	//파티 원본
	@Update("UPDATE partyboard SET showBoard = 'B' WHERE showBoard = 'Y' AND bno = #{bno}")
	void blindPartyBoard(PartyBoardVO vo) throws Exception;
	// 파티 코멘트
	@Update("UPDATE partyboard_comment SET showBoard = 'B' WHERE showBoard = 'Y' AND cno = #{cno}")
	void blindPartyBoardComment(PartyCommentVO vo) throws Exception;
	
	/**
	 * 처리한 신고를 read 속성값 변경 
	 * */
	/*
	@Update("UPDATE freeboard_comment SET showboard = 'B' WHERE showBoard = 'Y' AND cno = #{cno}")
	void blindComment(ReportVO vo) throws Exception;
	//파티 
	@Update("UPDATE freeboard SET showBoard = 'B' WHERE showBoard = 'Y' AND bno = #{bno}")
	void blindBoard(ReportVO vo) throws Exception;
	//파티 원본
	@Update("UPDATE partyboard SET showBoard = 'B' WHERE showBoard = 'Y' AND bno = #{bno}")
	void blindPartyBoard(PartyBoardVO vo) throws Exception;
	// 파티 코멘트
	@Update("UPDATE partyboard_comment SET showBoard = 'B' WHERE showBoard = 'Y' AND cno = #{cno}")
	void blindPartyBoardComment(PartyCommentVO vo) throws Exception;
	*/
	
}
