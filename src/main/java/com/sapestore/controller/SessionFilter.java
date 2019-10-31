package com.sapestore.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.sapestore.hibernate.entity.User;
import com.sapestore.service.AccountService;

public class SessionFilter implements Filter {

                
                private AccountService as;
                
                private ArrayList<String> urlList;
                private ArrayList<String> urlList1;
                private ArrayList<String> urlList2;
                
                public void destroy() {
                }

                public void doFilter(ServletRequest req, ServletResponse res,
                                                FilterChain chain) throws IOException, ServletException {

                                HttpServletRequest request = (HttpServletRequest) req;
                                HttpServletResponse response = (HttpServletResponse) res;
                                String url = request.getServletPath();
                                System.out.println(url);
                                boolean allowedRequest = false;
                                boolean allowedRequest1 = false;
                                boolean allowedRequest2 = false;
                                System.out.println(urlList);
                                System.out.println(urlList1);
                                System.out.println(urlList2);
                                
                                if(urlList.contains(url)) {
                                                allowedRequest = true;
                                }
                                if(urlList1.contains(url)) {
                                                allowedRequest1 = true;
                                }
                                if(urlList2.contains(url)) {
                                                allowedRequest2 = true;
                                }
                                System.out.println(allowedRequest);
                                System.out.println(allowedRequest1);
                                System.out.println(allowedRequest2);
                                HttpSession session = request.getSession(false);
                                if (allowedRequest == true) {
                                                System.out.println("1");
                                                String userId = (String) session.getAttribute("userId");
                                                String userIsAdmin = (String) session.getAttribute("isAdmin");
                                                System.out.println(userIsAdmin);
                                                if (userId == null) {
                                                                System.out.println("2");
                                                                response.sendRedirect("redirect:/");
                                                }else{
                                                                System.out.println(userId);
                                                                
                                                                if(allowedRequest1 == true){
                                                                                if(userIsAdmin == null || userIsAdmin.equals("N")){
                                                                                                response.sendRedirect("redirect:/");
                                                                                }
                                                                }
                                                                if(allowedRequest2 == true){
                                                                                if(userIsAdmin == null || userIsAdmin.equals("Y")){
                                                                                                response.sendRedirect("redirect:/");
                                                                                }
                                                                }
                                                }
                                }else{
                                                if(allowedRequest1 == true){
                                                                String userId = (String) session.getAttribute("userId");
                                                                String userIsAdmin = (String) session.getAttribute("isAdmin");
                                                                if(userId == null){
                                                                                response.sendRedirect("redirect:/");
                                                                }else{
                                                                                if(userIsAdmin == null || userIsAdmin.equals("N")){
                                                                                                response.sendRedirect("redirect:/");
                                                                                }
                                                                }                                                              
                                                }
                                                if(allowedRequest2 == true){
                                                                String userId = (String) session.getAttribute("userId");
                                                                String userIsAdmin = (String) session.getAttribute("isAdmin");
                                                                if(userId == null){
                                                                                response.sendRedirect("redirect:/");
                                                                }else{
                                                                                if(userIsAdmin == null || userIsAdmin.equals("Y")){
                                                                                                response.sendRedirect("redirect:/");
                                                                                }
                                                                }                                                              
                                                }
                                }
                                
                                chain.doFilter(req, res);
                }

                public void init(FilterConfig config) throws ServletException {
                                String urls = config.getInitParameter("avoid-urls");
                                StringTokenizer token = new StringTokenizer(urls, ",");

                                urlList = new ArrayList<String>();

                                while (token.hasMoreTokens()) {
                                                urlList.add(token.nextToken());

                                }
                                
                                String urls1 = config.getInitParameter("avoid-urls-user");
                                StringTokenizer token1 = new StringTokenizer(urls1, ",");

                                urlList1 = new ArrayList<String>();

                                while (token1.hasMoreTokens()) {
                                                urlList1.add(token1.nextToken());

                                }
                                
                                String urls2 = config.getInitParameter("avoid-urls-admin");
                                StringTokenizer token2 = new StringTokenizer(urls2, ",");

                                urlList2 = new ArrayList<String>();

                                while (token2.hasMoreTokens()) {
                                                urlList2.add(token2.nextToken());

                                }
                }
}
