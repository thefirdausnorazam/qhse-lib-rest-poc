package com.ideagen.qhse.web.utils.datatable;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class DataTableRequest {
    private Integer draw;
    private Integer start;
    private Integer length;
    private List<DataTableColumn> columns;
    private List<DataTableOrder> order;
    private DataTableSearch search;

    public Integer getDraw() {
        return draw;
    }

    public void setDraw(Integer draw) {
        this.draw = draw;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public List<DataTableColumn> getColumns() {
        return columns;
    }

    public void setColumns(List<DataTableColumn> columns) {
        this.columns = columns;
    }

    public List<DataTableOrder> getOrder() {
        return order;
    }

    public void setOrder(List<DataTableOrder> order) {
        this.order = order;
    }

    public DataTableSearch getSearch() {
        return search;
    }

    public void setSearch(DataTableSearch search) {
        this.search = search;
    }
}
