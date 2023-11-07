package util;

import java.util.ArrayList;
import java.util.List;

import vo.Page;

public class Paginator {
	final int defaultSize = 5;
	
	public List<Page> getPages(int total, int perPage, int currentPage) {
		// TODO: 총 total 개의 document가 있을 때 페이지네이션을 리턴한다.
		
		// 총 페이지는 total을 perPage로 나눈 값의 올림
		int totalPage = (int)Math.ceil(total * 1.0 / perPage);
		List<Page> before = new ArrayList<>();
		List<Page> pages = new ArrayList<>();
		List<Page> after = new ArrayList<>();
		
		// 페이징의 구성 : [처음, 이전, 1,2,3,4,5, 다음, 마지막]
		
		// 첫 페이지, 이전
		before.add(new Page(1, "처음"));
		if (currentPage > 1) before.add(new Page(currentPage - 1, "이전"));
		
		// 현 페이지 앞 뒤로 총 defaultSize 만큼 넣어준다.
		/* 
		 * startPage = currentPage - defaultSize / 2 에서 시작
		 * currentPage + defaultSize / 2 까지 넣어주면 됨.
		 * 단, startPage 가 1보다 작거나 startPage + defaultSize가 totalPage를 넘어가는 경우
		 * 적당히 조절시켜주어야 정상적으로 페이징 될 수 있다.
		 */
		int startPage = currentPage - defaultSize / 2;
		startPage = Math.max(startPage, 1);
		startPage = Math.min(startPage, totalPage - 4);
		
		for(int i = 0; i < defaultSize; i++) {
			int p = startPage + i;
			pages.add(new Page(p, Integer.toString(p)));
		}
		
		// 다음, 마지막 페이지
		if (currentPage < totalPage) after.add(new Page(currentPage + 1, "다음"));
		after.add(new Page(totalPage, "마지막"));
		
		List<Page> all = new ArrayList<>();
		
		all.addAll(before);
		all.addAll(pages);
		all.addAll(after);
		return all;
	}
}
