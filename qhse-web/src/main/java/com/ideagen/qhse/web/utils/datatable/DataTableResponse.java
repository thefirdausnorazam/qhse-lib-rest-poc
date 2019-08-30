package com.ideagen.qhse.web.utils.datatable;

import java.util.ArrayList;
import java.util.List;

public class DataTableResponse {
    private Integer draw;
    private Integer recordsTotal;
    private Integer recordsFiltered;
    private List<Object> data;
    private String error;

    public DataTableResponse(Integer draw, Integer recordsTotal, Integer recordsFiltered) {
        this.draw = draw;
        this.recordsTotal = recordsTotal;
        this.recordsFiltered = recordsFiltered;
        this.data = new ArrayList<>();
        this.error = null;
    }

    public Integer getDraw() {
        return draw;
    }

    public void setDraw(Integer draw) {
        this.draw = draw;
    }

    public Integer getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(Integer recordsTotal) {
        this.recordsTotal = recordsTotal;
    }

    public Integer getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(Integer recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

    public List<Object> getData() {
        return data;
    }

    public void setData(List<Object> data) {
        this.data = data;
    }

    public void addDataEntry(Object data){
        this.data.add(data);
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
