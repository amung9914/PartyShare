package com.bitc.login.vo;

import lombok.Data;

@Data
public class LoginDTO {
	private String mid;			// 로그인 아이디
	private String mpw;			// 로그인 비밀번호
	private boolean cookie;		// 내가 만든 쿠키
	
}
