package com.trip.seocance.util;

import org.springframework.data.domain.Page;

public class PagingParam {

    private int START_BLOCK_PAGE; //시작 페이지 번호
    private int END_BLOCK_PAGE; //마지막 페이지 번호
    private int PAGE_NUMBER;
    private int TOTAL_PAGES;

    public PagingParam(int pageBlock, Page page) {
        this.PAGE_NUMBER = page.getPageable().getPageNumber(); //현재 페이지 번호
        this.TOTAL_PAGES = page.getTotalPages(); //총 페이지 수
        this.START_BLOCK_PAGE = ((PAGE_NUMBER) / pageBlock) * pageBlock + 1;
        this.END_BLOCK_PAGE = (PAGE_NUMBER / pageBlock) == TOTAL_PAGES / pageBlock ? TOTAL_PAGES : START_BLOCK_PAGE + pageBlock - 1; //현재 페이지가 마지막 블록이면 마지막 페이지 = 전체 페이지 수
    }

    public int getStartBlockPage() {
        return START_BLOCK_PAGE;
    }

    public int getEndBlockPage() {
        return END_BLOCK_PAGE;
    }

    public int getPageNumber() {
        return PAGE_NUMBER;
    }

    public int getTotalPages() {
        return TOTAL_PAGES;
    }
}
