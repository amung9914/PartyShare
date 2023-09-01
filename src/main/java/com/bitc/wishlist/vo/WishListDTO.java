package com.bitc.wishlist.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WishListDTO {
	private String alias;			// 위시리스트 별칭
	private String partyImage1;		// 위시리스트에 등록된 파티 이미지 경로
}
