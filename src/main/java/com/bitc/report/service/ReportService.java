package com.bitc.report.service;

import java.util.List;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.member.vo.MemberVO;
import com.bitc.report.vo.PbReportVO;
import com.bitc.report.vo.ReportVO;

public interface ReportService {
	/**
	 * @return 신고 건수
	 * */
	public int countReport()throws Exception;	//reportService
	
	/**
	 * 
	 * */
	ReportVO selectReport(int no) throws Exception;	//reportService
	
	/**
	 * @param 신고 대상자
	 * @return 대상자의 mBanCount + 1 
	 * */
	void addReportCnt (String target) throws Exception;	// reportService
	
	/**
	 * @return 신고 횟수 20 되면 블랙
	 * */
	int cntOut () throws Exception;	// reportService
	
	/**
	 * @param 신고자VO mId
	 * @return 해당 신고자가 30분 이내에 신고한 내역 // 신고자는 신고자 id로 고정 
	 * */
	List<ReportVO> reportInMonth (ReportVO report) throws Exception;	// reportService
	
	/**
	 * @return 현재 시각을 포맷으로 반환 String
	 * */
	String makeStringDate();	// reportService
	
	/**
	 * @param 로그인 유저  // 리포트 유저 아이디는 form태그로 인해 전달 중에 있음 reportVO가 만들어지니까 추가 형식으로 들어감 
	 * 							DAO method == INSERT 
	 * @return 결과 확인
	 * */
	void addReport(ReportVO report) throws Exception;	// reportService
	
	/**
	 * @param 로그인 유저 
	 * @return 본인이 얼마나 신고를 일삼았는지 깨닫게 해줌
	 * */
	List<ReportVO> reportReview (MemberVO vo) throws Exception;	// reportService
	
	/**
	 * @return 관리자 화면에서 출력되는 전체 신고내역 리스트
	 * */
	List<ReportVO> reportList(Criteria cri, PageMaker pm) throws Exception;	//reportService
	
	/**
	 * @return report 페이징처리
	 * */
	PageMaker getPageMaker(Criteria cri)throws Exception;
	
	/**
	 * @게시글류 신고 리스트
	 * */
	List<ReportVO> reportedBoard(Criteria cri) throws Exception;
	
	List<PbReportVO> reportedPartyBoard()throws Exception;
}
