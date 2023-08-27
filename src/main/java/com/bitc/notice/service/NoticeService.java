package com.bitc.notice.service;

import java.util.List;

import com.bitc.member.vo.MemberVO;
import com.bitc.notice.vo.NoticeVO;

public interface NoticeService {
	
	/**
	 * @return 읽지 않은 notice 개수 반환
	 * 
	 * */
	public List<NoticeVO> noReadNotice() throws Exception;	//notice
	
	/**
	 * 리스트에 vo 하나를 추가
	 * */
	public void addNotice (NoticeVO vo) throws Exception;	// notice
	
	/**
	 * @return 전체 notice 리스트 
	 * */
	public List<NoticeVO> allNotice() throws Exception;	//notice 
	
	/**
	 * readed update -> Y
	 * */
	public void readPost(int noticeNum, String mid) throws Exception;	//notice
	
	/**
	 * 관리자가 탈퇴하지 않은 모든 member의 mId를 포함해 notice 삽입
	 * */
	void sendPost(List<MemberVO> list , NoticeVO notice) throws Exception;	//noticeService
	/**
	 * 블랙리스트 대상자에게만 발신
	 * */
	void blackPost(String mId, NoticeVO vo) throws Exception;	//noticeService
	/**
	 * @return 탈퇴하지 않은 멤버VO반환
	 * */
	public List<MemberVO> currentMember() throws Exception;	//NoticeService
	
	/**
	 * 관리자가 보낸 메시지 리스트 확인            
	 * @param 유저 
	 * @return notice확인 from 관리자 
	 * */
	List<NoticeVO> viewNotice (MemberVO vo) throws Exception;	//noticeService
	/**
	 * 알림 삭제
	 * @return 관리자 알림을 삭제하고 결과를 반환함 from entity
	 * */
	String deleteNotice() throws Exception;	//noticeService
	/**
	 * @전체 reportVO 리스트
	 * */
//	List<ReportVO> reportList(ReportVO vo) throws Exception;
	/**
	 * @return 로그인 유저의 post(Notice)수신함
	 * */
	List<NoticeVO> myNotice(String mid) throws Exception;	//noticeService
	// 이미 본 알림 목록 보여주기
	List<NoticeVO> bonPostList(String mid) throws Exception;
	// 이미 본 알림 목록에서 제거
	void deletePost(int no , String mid) throws Exception;
}
