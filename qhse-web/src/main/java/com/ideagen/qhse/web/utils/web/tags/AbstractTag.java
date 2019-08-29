package com.ideagen.qhse.web.utils.web.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

public class AbstractTag extends TagSupport {

    protected String cssClass;

    protected String cssStyle;

    public String getCssClass() {
        return cssClass;
    }

    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }

    public String getCssStyle() {
        return cssStyle;
    }

    public void setCssStyle(String cssStyle) {
        this.cssStyle = cssStyle;
    }

    protected void writeTag(String element) throws IOException {
        JspWriter tag = pageContext.getOut();
        tag.println(element);
    }
}
