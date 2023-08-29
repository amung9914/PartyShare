package com.bitc.partyBoard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.SearchCriteria;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.service.PartyService;
import com.bitc.partyBoard.service.PartyBoardService;
import com.bitc.partyBoard.vo.PartyBoardVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/partyBoard/*")
@RequiredArgsConstructor
public class PartyBoardController {
	
	private final PartyBoardService bs;
	private final PartyService ps;
	
	// 내부에서 사용하는 메소드
	public boolean isPartyMember(HttpSession session, int pnum)throws Exception {
		//파티멤버인지 아닌지 확인한다. 
				MemberVO loginsession = (MemberVO)session.getAttribute("loginMember");
				List<MemberVO> joinMemberList = null;
				joinMemberList = ps.getJoinPartyMemberList(pnum);
				
				if(joinMemberList.contains(loginsession)) {
					return true;
				}
		return false;
	}
	
	/**
	 *  페이징 처리 된 게시글 출력 페이지
	 *  param : 파티번호pnum필수, 요청 page, perPageNum 
	 */
	@GetMapping("listPage")
	public String listPage(HttpSession session, 
			int pnum, SearchCriteria cri, 
			RedirectAttributes rttr,Model model) throws Exception {
		
		if(isPartyMember(session,pnum)) {
			model.addAttribute("notice",bs.noticeList(pnum));
			model.addAttribute("list",bs.listCriteria(pnum,cri));
			model.addAttribute("pm",bs.getPageMaker(pnum,cri));
			model.addAttribute("pnum",pnum);
			return "partyBoard/listPage";
		}else{
			String message = "파티 멤버만 입장할 수 있습니다.";
			rttr.addFlashAttribute("message",message);
			return "redirect:/partyDetail/detailOfParty?pNum="+pnum;
		}
		
	}
	
	
	/* "게시글 작성 페이지 요청" */
	@GetMapping("register") 
	public String register(HttpSession session, int pnum,
			RedirectAttributes rttr,Model model)throws Exception{
		
		if(isPartyMember(session,pnum)) {
			model.addAttribute("pnum",pnum);
			return "partyBoard/register";
		}else{
			String message = "파티 멤버만 입장할 수 있습니다.";
			rttr.addFlashAttribute("message",message);
			return "redirect:/partyDetail/detailOfParty?pNum="+pnum;
		}
	
	}
	
	/**
	 * 게시글 등록 요청 처리 추가
	 */
	@PostMapping("register")
	public String registerPost(PartyBoardVO board,
			RedirectAttributes rttr)throws Exception{
		bs.regist(board);
		rttr.addAttribute("pnum",board.getPnum());
		return "redirect:/partyBoard/listPage";
	}
	
	/**
	 * 게시글 상세보기 요청 처리 - 게시글 번호
	 * @throws Exception 
	 */
	@GetMapping("readPage")
	public String readPage(
			HttpSession session,
			int bno, int pnum, RedirectAttributes rttr) throws Exception {
		
		if(isPartyMember(session,pnum)) {
			// 조회수 증가
			bs.updateCnt(bno,pnum);
			rttr.addAttribute("bno",bno);
			rttr.addAttribute("pnum",pnum);
			return "redirect:/partyBoard/read";
		}else{
			String message = "파티 멤버만 입장할 수 있습니다.";
			rttr.addFlashAttribute("message",message);
			return "redirect:/partyDetail/detailOfParty?pNum="+pnum;
		}
	}
	
	// 상세보기 요청 게시글 정보
	@GetMapping("read")
	public String read(
			HttpSession session, RedirectAttributes rttr,
			PartyBoardVO board, Model model) throws Exception{
		
		if(isPartyMember(session,board.getPnum())) {
			model.addAttribute("board",bs.read(board));
			return "partyBoard/read";
		}else{
			String message = "파티 멤버만 입장할 수 있습니다.";
			rttr.addFlashAttribute("message",message);
			return "redirect:/partyDetail/detailOfParty?pNum="+board.getPnum();
		}
		
	}
	
	/**
	 * 게시글 수정 페이지 요청
	 * - 게시글 수정 화면 출력 
	 */
	@GetMapping("modify")
	public String modifyGet(
			HttpSession session, RedirectAttributes rttr,
			PartyBoardVO board, Model model)throws Exception{
		
		if(isPartyMember(session,board.getPnum())) {
			PartyBoardVO vo = bs.read(board);
			model.addAttribute("board",vo);
			return "partyBoard/modify";
		}else{
			String message = "파티 멤버만 입장할 수 있습니다.";
			rttr.addFlashAttribute("message",message);
			return "redirect:/partyDetail/detailOfParty?pNum="+board.getPnum();
		}
	}

	/**
	 * 게시글 수정 처리 요청
	 * 게시글 수정 완료 후 redirect - 수정게시글 상세보기 페이지 이동
	 */
	@PostMapping("modify")
	public String modify(
			RedirectAttributes rttr,
			PartyBoardVO vo)throws Exception{
		String result = bs.modify(vo);
		rttr.addFlashAttribute("result",result);
		rttr.addAttribute("bno",vo.getBno()); // get방식으로 파라미터값 삽입.
		rttr.addAttribute("pnum",vo.getPnum()); // get방식으로 파라미터값 삽입.
		return "redirect:/partyBoard/read";//?bno="+vo.getBno();
	}
	/**
	 * 게시글 삭제 완료 후 listPage 페이지 로 이동 - redirect 
	 */
	 // @PostMapping("board/remove")
	@PostMapping("remove")
	public String remove(int pnum,int bno, Criteria cri, RedirectAttributes rttr)throws Exception{
		String result = bs.remove(pnum,bno);
		rttr.addFlashAttribute("result",result);
		rttr.addAttribute("page",cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addAttribute("pnum",pnum);
		return "redirect:/partyBoard/listPage";
	}
	

	@GetMapping("reply")
	public String reply(
			HttpSession session, RedirectAttributes rttr,
			int pnum,PartyBoardVO vo,Model model) throws Exception{
		
		if(isPartyMember(session,pnum)) {
			model.addAttribute("board",bs.read(vo)); 
			return "partyBoard/reply";
		}else{
			String message = "파티 멤버만 입장할 수 있습니다.";
			rttr.addFlashAttribute("message",message);
			return "redirect:/partyDetail/detailOfParty?pNum="+pnum;
		}
		
	}
	
	/**
	 * 답글 등록 요청 처리 추가
	 */
	@PostMapping("reply")
	public String replyPost(PartyBoardVO board,
			RedirectAttributes rttr)throws Exception{
			bs.registReply(board);
		rttr.addAttribute("pnum",board.getPnum());
		return "redirect:/partyBoard/listPage";
	}
}















