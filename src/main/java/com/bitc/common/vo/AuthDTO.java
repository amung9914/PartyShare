package com.bitc.common.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuthDTO implements Serializable {

	private static final long serialVersionUID = 6493733453001687444L;

	private String mid; // 사용자
	private String auth; // 권한

}
