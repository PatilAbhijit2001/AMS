//package com.aadhar_management_system.controller;
//
//import java.io.IOException;
//import javax.servlet.*;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//@WebFilter(filterName = "SessionFilter", urlPatterns = {"/*"})
//public class SessionFilter implements Filter {
//
//    private final long SESSION_VALID_PERIOD = 10000; //ms
//
//    @Override
//    public void init(FilterConfig arg0) throws ServletException {
//    }
//
//    @Override
//    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
//            throws IOException, ServletException {
//        HttpServletRequest request = (HttpServletRequest) servletRequest;
//        HttpServletResponse response = (HttpServletResponse) servletResponse;
//        
//        
//        long lastAccessTime = getLastAccessTime(request);
//        long currentTime = System.currentTimeMillis();
//       request.getSession().setAttribute("SESSION_CURRENT_ACCESS_TIME", currentTime);
//       request.getSession().setAttribute("SESSION_LAST_ACCESS_TIME", lastAccessTime);
//
//        filterChain.doFilter(request, response);
//    }
//
//    private long getLastAccessTime(HttpServletRequest request) {
//        Long lastAccessTime = (Long) request.getSession().getAttribute("SESSION_LAST_ACCESS_TIME");
//        return (lastAccessTime != null) ? lastAccessTime : 0;
//    }
//
//    @Override
//    public void destroy() {
//    }
//}