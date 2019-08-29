package com.ideagen.qhse.web.utils.web.tags;

import com.ideagen.qhse.orm.query.QueryResult;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import java.io.IOException;
import java.text.MessageFormat;

public class PagingTag extends RequestContextAwareTag {

    private String outputNone;

    private String outputFirst;

    private String outputFull;

    private String outputLast;

    private String outputAll;

    private String firstAnchor;

    private String prevAnchor;

    private String nextAnchor;

    private String lastAnchor;

    private boolean init;

    private QueryResult result;

    public PagingTag() {
        outputNone = "<span class=\"pagelinks\">[Prev] {0} [Next] {5}</span>";
        outputFirst = "<span class=\"pagelinks\">[Prev] {0} [<a href=\"{3}\">Next</a>] {5}</span>";
        outputFull = "<span class=\"pagelinks\">[<a href=\"{2}\">Prev</a>] {0} [<a href=\"{3}\">Next</a>] {5}</span>";
        outputLast = "<span class=\"pagelinks\">[<a href=\"{2}\">Prev</a>] {0} [Next] {5}</span>";
        outputAll = "<span class=\"pagelinks\"></span>";
        firstAnchor = "javascript:page(''{0}'', 0)";
        prevAnchor = "javascript:page(''{0}'', {1}-1)";
        nextAnchor = "javascript:page(''{0}'', {1}+1)";
        lastAnchor = "javascript:page(''{0}'', {1})";
        init = false;
    }

    public void setResult(QueryResult result) {
        this.result = result;
    }

    private void init() {
        if (!init)
            synchronized (this) {
                if (!init) {
                    init = true;
                    outputNone = getRequestContext().getMessage("paging.outputNone");
                    outputFirst = getRequestContext().getMessage("paging.outputFirst");
                    outputFull = getRequestContext().getMessage("paging.outputFull");
                    outputLast = getRequestContext().getMessage("paging.outputLast");
                    outputAll = getRequestContext().getMessage("paging.outputAll");
                    firstAnchor = getRequestContext().getMessage("paging.firstAnchor");
                    prevAnchor = getRequestContext().getMessage("paging.prevAnchor");
                    nextAnchor = getRequestContext().getMessage("paging.nextAnchor");
                    lastAnchor = getRequestContext().getMessage("paging.lastAnchor");
                }
            }
    }

    @Override
    protected int doStartTagInternal() throws Exception {
        return 2;
    }

    @Override
    public int doEndTag() throws JspException {
        init();
        String msg;
        if(result != null)
        {
            if (result.getPageNumber() == 1 && !result.isMore()) {
                msg = outputNone;
            }
            else if (result.getPageNumber() == 1 && result.isMore()) {
                msg = outputFirst;
            }
            else if (result.getPageNumber() == 0 && !result.isMore()) {
                msg = outputAll;
            }
            else if (!result.isMore()) {
                msg = outputLast;
            } else {
                msg = outputFull;
            }
            int numOfPages = 0;
            String pageNumber, pageResults;
            if (result.getTotalResults() != null) {
                numOfPages = (result.getTotalResults().intValue() - 1) / result.getPageSize() + 1;
                pageNumber = "Page " + result.getPageNumber() + " of " + numOfPages;
                pageResults = "(" + result.getTotalResults() + " records found)";

            } else {
                pageNumber = "Page " + result.getPageNumber();
                pageResults = "";
            }
            final Object anchorObjs[] = { Long.valueOf(result.getPageNumber()), Long.valueOf(numOfPages) };
            final String first = (new MessageFormat(firstAnchor)).format(anchorObjs);
            final String prev = (new MessageFormat(prevAnchor)).format(anchorObjs);
            final String next = (new MessageFormat(nextAnchor)).format(anchorObjs);
            final String last = (new MessageFormat(lastAnchor)).format(anchorObjs);
            final MessageFormat mf = new MessageFormat(msg);
            write(pageContext, mf.format((new Object[] { pageNumber, first, prev, next, last, pageResults })));
        }
        return super.doEndTag();
    }

    protected static void write(PageContext pageContext, String text) throws JspException {
        final JspWriter writer = pageContext.getOut();
        try {
            writer.print(text);
        } catch (final IOException e) {
            throw new JspException(e.toString());
        }
    }
}