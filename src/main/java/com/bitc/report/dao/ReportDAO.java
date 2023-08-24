package com.bitc.report.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.member.vo.MemberVO;
import com.bitc.report.vo.PbReportVO;
import com.bitc.report.vo.ReportVO;

public interface ReportDAO {
		
	@Select("SELECT * FROM report WHERE bno IS NULL ORDER BY date") //,no,bno,cno ")
	public List<ReportVO> reportList(Criteria cri, PageMaker pm) throws Exception;	//reportDAO
	
	@Select("SELECT count(*) FROM report")
	public int countReport() throws Exception;	//reportDAO
	
	@Select("SELECT * FROM report WHERE no = #{no}")
	public ReportVO selectReport(int no) throws Exception;	//reportDAO
	
	@Update("UPDATE freeBoard reported = 'Y' WHERE bno = #{bno}")
	public void reportBoard(int bno) throws Exception;	//reportDAO
	
	@Update("UPDATE freeBoardComment reported = 'Y' WHERE cno = #{cno}")
	public void reportComment(int cno) throws Exception;	//reportDAO
	
	// INSERT 반환타입 확인하러 == void
	@Insert("INSERT INTO report (fromMid, toMid, category, context) "
			+ "VALUES (#{fromMid}, #{toMid}, #{category}, #{context})")  // no AI , date=DF
	void addReport(ReportVO vo) throws Exception;	// reportDAO
	
	@Select("SELECT * FROM report WHERE fromMid = #{mId} ")
	List<ReportVO> reportReview(MemberVO vo) throws Exception;	// reportDAO
	
	@Update("UPDATE member SET mBanCnt = mBanCnt+1 WHERE mId = #{target} ")
	void addReportCnt (String target) throws Exception;	// reportDAO
	
	@Update("UPDATE member SET mBlackYN = 'Y' , mBanCnt = 0  WHERE mBanCnt = 10")
	int cntOut() throws Exception;	// reportDAO
	
	
	// 인터셉터 전처리로 옮기기
	@Select("SELECT * FROM report WHERE fromMid = #{fromMid} "
			+ "AND ( toMid = #{toMid} "
			+ "AND (date >= NOW() - INTERVAL 1 month AND date <= NOW()))")
	List<ReportVO> reportInMonth (ReportVO report) throws Exception;	// reportDAO
	
	//신고가 접수된 댓글이나 게시글 목록 출력 
	@Select("SELECT * FROM report WHERE  bno IS NOT NULL ORDER BY date DESC limit #{startRow}, #{perPageNum} ")
	List<ReportVO> reportedBoard(Criteria cri) throws Exception;
//	reported = 'R' AND   WHERE  bno IS NOT NULL
	
	/**
	 * 파티보드
	 * */
	@Select("SELECT * FROM  partyboard_report WHERE readed = 'N' ORDER BY date DESC")
	List<PbReportVO> reportedPartyBoard()throws Exception;
	
	@Update("UPDATE partyboard_report SET readed ='Y' WHERE no = #{no}")
	void readPBR(PbReportVO vo) throws Exception;
	
	@Update("UPDATE freeBoardComment SET reported = 'B' WHERE reported = 'N' AND cno = #{cno}")
	void blindComment(ReportVO vo) throws Exception;
	
	@Update("UPDATE freeBoard SET reported = 'B' WHERE reported = 'N' AND bno = #{bno}")
	void blindBoard(ReportVO vo) throws Exception;
	

	
}
