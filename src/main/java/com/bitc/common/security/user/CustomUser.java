package com.bitc.common.security.user;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.bitc.member.vo.MemberVO;

import lombok.Getter;

/**
 * 
 * 인가가 완료된 사용자 정보
 */
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;

	@Getter
	private MemberVO member;

	public CustomUser(MemberVO member) {
		super(member.getMid(), member.getMpw(), authorities(member.getAuthList()));
		//여기서 아이디 비밀번호 검증(security에서 비밀번호 검증)하고 맞으면 등록됨, 틀리면(인증안되있으면) 예외발생
		this.member = member;
	}

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public static Collection<? extends GrantedAuthority> authorities(List<String> authList) {
		List<GrantedAuthority> grantedAuthorityList = new ArrayList<>();
		for (String auth : authList) {
			grantedAuthorityList.add(new SimpleGrantedAuthority(auth));
		}
		return grantedAuthorityList;
	}

}
