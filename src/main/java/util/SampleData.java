package util;

import java.util.Arrays;
import java.util.List;

import vo.Goods;
import vo.GoodsImg;
import vo.Notice;

public class SampleData {
	public Goods getGoods() {
		Goods goods = new Goods();
		List<String> titles = List.of(
                "편안한 침대 매트리스",
                "스마트폰 거치대",
                "여성용 가을 니트",
                "초경량 노트북",
                "화이트보드 마커 세트",
                "휴대용 충전기",
                "유기농 샐러드 그린즈",
                "스포츠 스니커즈",
                "디자이너 책상 조명",
                "반려동물용 간식 선물세트"
        );
		
		// "Lorem Ipsum" 텍스트
        String loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

        // 문장 단위로 자르기
        String[] sentences = loremIpsum.split("\\.\\s*");

        // List<String>로 변환
        List<String> loremipsum = Arrays.asList(sentences);
        
        goods.setGoodsTitle(titles.get(rand(titles.size())));
        goods.setGoodsPrice(rand(100_000));
        goods.setSoldout(rand(2) >= 1 ? "Y" : "N");
        goods.setGoodsMemo("");
        for (int i = 0; i < loremipsum.size(); i++) {
        	if (rand(2) >= 1) {
        		goods.setGoodsMemo(goods.getGoodsMemo() + " ");
        	}
        }
		return goods;
	}
	public GoodsImg getGoodsImg() {
		GoodsImg goodsImg = new GoodsImg();
		List<String> titles = List.of(
                "assets\\image1.png",
                "assets\\image2.png",
                "assets\\image3.png",
                "assets\\image4.png",
                "assets\\image5.png",
                "assets\\image6.png",
                "assets\\image7.png",
                "assets\\image1.png",
                "assets\\image1.png"
        );
		
		goodsImg.setFileName(titles.get(rand(titles.size())));
		goodsImg.setOriginName(titles.get(rand(titles.size())));
		goodsImg.setContentType(titles.get(rand(titles.size())).split("[.]")[1]);
		
		return goodsImg;
	}
	
	public Notice getNotice() {
		Notice notice = new Notice();
		
		List<String> titles = List.of(
				"서비스 업데이트 안내",
			    "이용 중인 서비스 임시 중단 안내",
			    "신규 기능 추가 안내",
			    "이용자 모임 일정 공지",
			    "시스템 점검 일정 안내",
			    "서버 성능 향상 작업 공지",
			    "긴급 보안 업데이트 안내",
			    "이용자 피드백 이벤트 진행 중",
			    "오픈 베타 테스트 참가자 모집",
			    "서비스 이용약관 변경 안내",
			    "최신 버전 업데이트 안내",
			    "이용자 만족도 조사 이벤트",
			    "서비스 중단 예정 공지",
			    "채팅 기능 추가 안내",
			    "매주 정기 점검 안내",
			    "이용자 권리 및 의무 안내",
			    "신규 회원 가입 혜택 안내",
			    "서비스 이용 안내",
			    "공식 블로그 오픈 안내",
			    "이용자 커뮤니티 개설 안내"
	    );
		List<String> contents = List.of(
				"안녕하세요. 서비스 업데이트가 예정되어 있습니다. 자세한 내용은 공지를 참조해주세요.",
			    "이용 중인 서비스가 잠시 동안 중단될 예정입니다. 불편을 드려 죄송합니다.",
			    "새로운 기능이 추가되었습니다. 사용해보시고 피드백을 주시면 감사하겠습니다.",
			    "이용자 모임이 예정되어 있습니다. 참석을 희망하는 분들은 일정을 확인해주세요.",
			    "시스템 점검이 예정되어 있습니다. 일시적으로 서비스 이용이 제한될 수 있습니다.",
			    "서버 성능을 향상시키기 위한 작업이 진행 중입니다. 작업 중에는 일부 서비스가 느릴 수 있습니다.",
			    "긴급 보안 업데이트가 필요한 상황이 발생했습니다. 빠른 시일 내에 업데이트를 진행해주세요.",
			    "이용자 피드백을 받고자 이벤트를 진행 중입니다. 소중한 의견을 남겨주세요.",
			    "새로운 기능의 오픈 베타 테스트에 참가하실 분들을 모집합니다. 참여하시어 피드백을 주세요.",
			    "서비스 이용약관이 변경되었습니다. 변경된 내용을 확인하시고 동의해주세요.",
			    "최신 버전으로 업데이트하시면 더욱 안정적인 서비스를 이용하실 수 있습니다.",
			    "이용자 만족도 조사 이벤트가 진행 중입니다. 참여하시어 의견을 남겨주세요.",
			    "일부 서비스가 일시적으로 중단될 예정입니다. 불편을 드려 죄송합니다.",
			    "채팅 기능이 추가되었습니다. 이제 더 쉽게 소통할 수 있습니다.",
			    "매주 정기적으로 시스템 점검이 진행됩니다. 점검 시간을 참조해주세요.",
			    "이용자의 권리와 의무에 대한 안내가 업데이트되었습니다. 확인해주세요.",
			    "신규 회원 가입시 특별한 혜택이 제공됩니다. 가입하시어 혜택을 받아가세요.",
			    "서비스 이용에 관한 중요한 내용이 있습니다. 확인 부탁드립니다.",
			    "공식 블로그가 오픈되었습니다. 다양한 소식과 정보를 확인해보세요.",
			    "이용자 커뮤니티가 개설되었습니다. 자유롭게 의견을 나누고 정보를 교환해보세요."
	    );
		
		notice.setManagerNo(1);
		notice.setNoticeTitle(titles.get(rand(titles.size())));
		notice.setNoticeContent(contents.get(rand(contents.size())));
		
		return notice;
	}
	
	private int rand(int n) {
		return (int)(Math.random() * n);
	}
}
