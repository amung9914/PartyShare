package com.bitc.partyBoard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.SearchCriteria;
import com.bitc.partyBoard.service.PartyBoardService;
import com.bitc.partyBoard.vo.PartyBoardVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/partyBoard/*")
@RequiredArgsConstructor
public class PartyBoardController {
	
	//@Autowired
	private final PartyBoardService bs;
	
	
	/* "게시글 작성 페이지 요청" */
	@GetMapping("register") 
	public String register(int pnum,Model model)throws Exception{
		model.addAttribute("pnum",pnum);
		return "partyBoard/register";
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
			int bno, int pnum, RedirectAttributes rttr) throws Exception {
		// 조회수 증가
		bs.updateCnt(bno,pnum);
		rttr.addAttribute("bno",bno);
		rttr.addAttribute("pnum",pnum);
		return "redirect:/partyBoard/read";
	}
	
	// 상세보기 요청 게시글 정보
	@GetMapping("read")
	public String read(PartyBoardVO board, Model model) throws Exception{
		model.addAttribute("board",bs.read(board));
		return "partyBoard/read";
	}
	
	/**
	 * 게시글 수정 페이지 요청
	 * - 게시글 수정 화면 출력 
	 */
	@GetMapping("modify")
	public void modifyGet(
			PartyBoardVO board, Model model)throws Exception{
		PartyBoardVO vo = bs.read(board);
		model.addAttribute("board",vo);
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
	
	/**
	 *  페이징 처리 된 게시글 출력 페이지
	 *  param : 파티번호pnum필수, 요청 page, perPageNum 
	 */
	@GetMapping("listPage")
	public String listPage(int pnum, SearchCriteria cri, Model model) throws Exception {
		// 게시글 목록
		model.addAttribute("notice",bs.noticeList(pnum));
		model.addAttribute("list",bs.listCriteria(pnum,cri));
		model.addAttribute("pm",bs.getPageMaker(pnum,cri));
		model.addAttribute("pnum",pnum);
		return "partyBoard/listPage";
	}
	
	@GetMapping("reply")
	public String reply(int pnum,PartyBoardVO vo,Model model) throws Exception{
		model.addAttribute("board",bs.read(vo)); 
		return "partyBoard/reply";
	}
	
	/**
	 * 게시글 등록 요청 처리 추가
	 */
	@PostMapping("reply")
	public String replyPost(PartyBoardVO board,
			RedirectAttributes rttr)throws Exception{
			bs.registReply(board);
		rttr.addAttribute("pnum",board.getPnum());
		return "redirect:/partyBoard/listPage";
	}
}















