package com.bitc.report.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.member.vo.MemberVO;
import com.bitc.report.dao.ReportDAO;
import com.bitc.report.vo.PbReportVO;
import com.bitc.report.vo.ReportVO;

import lombok.RequiredArgsConstructor;

@Service("rs")
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {
	private final ReportDAO dao;
	
	@Override
	public int countReport() throws Exception {
		return dao.countReport();
	}	//rsi
	
	public ReportVO selectReport(int no) throws Exception {
		return dao.selectReport(no);
	}	//rsi
	
	@Override
	public List<ReportVO> reportList(Criteria cri, PageMaker pm) throws Exception {
		return dao.reportList();
	}	//rsi
	
	@Override
	public List<ReportVO> reportReview(MemberVO vo) throws Exception{
		return dao.reportReview(vo);
	}	//rsi
	
	@Override
	public void addReport(ReportVO vo) throws Exception {
		dao.addReport(vo);
		System.out.println("추가됐다");
	}	//rsi
	
	public void addReportCnt(String target) throws Exception{
		dao.addReportCnt(target);
		System.out.println(target + "의 신고 횟수 +1");
	}	//rsi

	@Override
	public int cntOut() throws Exception {
		return dao.cntOut();
		
	}	//rsi

	@Override
	public List<ReportVO> reportInMonth (ReportVO report) throws Exception {
		return dao.reportInMonth(report);
	}	// rsi

	@Override
	public String makeStringDate() {
		LocalDateTime now = LocalDateTime.now();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String date = now.format(formatter);
		return date;
		
	}

	@Override					
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		int countReport = dao.countReport();
		return new PageMaker(cri,countReport);
		}

	@Override
	public List<ReportVO> reportedBoard(Criteria cri) throws Exception {
				return dao.reportedBoard(cri);
	}

	@Override
	public List<PbReportVO> reportedPartyBoard() throws Exception {
		return dao.reportedPartyBoard();
	}	
}
