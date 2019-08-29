package com.ideagen.qhse.web.utils.web.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

public class FormTag extends AbstractTag {
    private String action;
    private String onsubmit;
    private String method;

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getOnsubmit() {
        return onsubmit;
    }

    public void setOnsubmit(String onsubmit) {
        this.onsubmit = onsubmit;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    @Override
    public int doStartTag() throws JspException {
        try {
            String element = "<form ";
            if(this.getId()!=null) {
                element += "id=\""+this.getId()+"\" ";
            }
            if(this.getAction()!=null) {
                element += "action=\""+this.getAction()+"\" ";
            }
            if(this.getMethod()!=null) {
                element += "method=\""+this.getMethod()+"\" ";
            }else {
                element += "method=\""+this.getMethod()+"\" ";
            }
            if(this.getCssClass()!=null) {
                element += "class=\""+this.getCssClass()+"\" ";
            }
            if(this.getCssStyle()!=null) {
                element += "style=\""+this.getCssStyle()+"\" ";
            }
            if(this.getOnsubmit()!=null) {
                element += "onsubmit=\""+this.getOnsubmit()+"\" ";
            }
            writeTag(element);
        } catch (Exception e) {
            throw new JspException(e);
        }
        return EVAL_BODY_INCLUDE;
    }

    @Override
    public int doEndTag() throws JspException {
        try {
            String element = "</form>";
            writeTag(element);
        } catch (Exception e) {
            throw new JspException(e);
        }
        return EVAL_PAGE;
    }
}
