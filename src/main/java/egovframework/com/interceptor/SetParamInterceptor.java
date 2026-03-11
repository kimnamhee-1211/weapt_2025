package egovframework.com.interceptor;


import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class SetParamInterceptor implements HandlerInterceptor {

    public static final String HEADER_PG_ID = "X-PG-ID";
    public static final String PG_ID = "PG_ID";
    public static final String HEADER_MENU_ID = "X-MENU-ID";
    public static final String MENU_ID = "MENU_ID";

    public boolean preHandle(final HttpServletRequest request, final HttpServletResponse response, final Object handler) throws Exception {
        String pgId = request.getHeader(HEADER_PG_ID);
        if (pgId != null && !pgId.trim().isEmpty()){
            request.setAttribute(PG_ID, pgId);
        }
        String menuId = request.getHeader(HEADER_MENU_ID);
        if (menuId != null && !menuId.trim().isEmpty()){
            request.setAttribute(MENU_ID, menuId);
        }
        return true;
    }

}