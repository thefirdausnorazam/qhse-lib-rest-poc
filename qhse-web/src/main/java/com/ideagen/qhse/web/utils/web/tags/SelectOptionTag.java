package com.ideagen.qhse.web.utils.web.tags;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class SelectOptionTag extends AbstractTag {
    private List<Map<String,String>> items;
    private String selected;
    private String name;

    public List<Map<String, String>> getItems() {
        return items;
    }

    public void setItems(List<Map<String, String>> items) {
        this.items = items;
    }

    public String getSelected() {
        return selected;
    }

    public void setSelected(String selected) {
        this.selected = selected;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public int doStartTag() throws JspException {

        try {
            String element = "<select id=\""+this.id+"\" name=\""+this.name+"\" class=\""+this.cssClass+"\" style=\""+ this.cssStyle+"\">";
            element+="<option value=\"\""+ ((this.selected==null)?" selected=selected ":"") +">Choose</option>";
            Iterator<Map<String,String>> itemIterator= items.iterator();

            while(itemIterator.hasNext()) {
                Map<String,String> item = itemIterator.next();
                element+="<option value=\""+item.get("value")+"\""+ ((item.get("value").compareToIgnoreCase(this.selected)==0)?" selected=selected ":"") +">"+item.get("label")+"</option>";
            }
            element+="</select>";
            writeTag(element);
        } catch (Exception e) {
            throw new JspException(e);
        }
        return EVAL_BODY_INCLUDE;
    }

    @Override
    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }
}
