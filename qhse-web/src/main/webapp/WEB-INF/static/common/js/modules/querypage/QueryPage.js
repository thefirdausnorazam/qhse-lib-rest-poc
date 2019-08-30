import Component from "../../lib/Component.js";
class QueryPage extends Component{
    constructor(id,url,serverSide){
        super();
        this.id = id;
        this.url = url;
        this.content = $("#"+id+" .queryTable .queryTable_content");
        this.loading_message = $("#"+id+" .queryTable .queryTable_loading");
        this.columTitle=$("#"+id+" .queryTable #queryTable_table_head");
        this.tableBody = $("#"+this.id+" #queryTable_table_body")
        this.datatable="";
        this.serverSide=serverSide;
        this.drawNumber=1;
        //todo
        this.columnDef=[];

        this.columnOrder=[{
            column: 0,
            dir: "asc"
        }];
        this.loading(true);
    }

    getCurrentPage(currentPage){
        if(window.localStorage.getItem("qhse_queryTable_currentPage")) {
            return window.localStorage.getItem("qhse_queryTable_currentPage");
        } else {
            this.setCurrentPage(0);
            return 0;
        }
    }
    setCurrentPage(currentPage){
        window.localStorage.setItem("qhse_queryTable_currentPage",currentPage);
    }
    getRecordPerPage(rpp){
        if(window.localStorage.getItem("qhse_queryTable_recordPerPage")) {
            return window.localStorage.getItem("qhse_queryTable_recordPerPage");
        } else {
            this.setRecordPerPage(25);
            return 25;
        }


    }
    setRecordPerPage(rpp){
        window.localStorage.setItem("qhse_queryTable_recordPerPage",rpp);
    }


    loading(flag){
        if(flag){
            this.content.hide();
            this.loading_message.show();
        } else {
            this.content.show();
            this.loading_message.hide();
        }
    }

    loadPage(){
        var parentContext = this;
        $.get(this.url+"/getColumns",function(data){
            data.forEach(function(item,index){
                parentContext.columTitle.append("<th>"+item+"</th>");
            });
            if(parentContext.serverSide=="server"){
                parentContext.loadTableFromServer();
            }
            else if(parentContext.serverSide=="client"){
                parentContext.loadTableClient();
            }
            else if(parentContext.serverSide=="mix"){
                parentContext.loadTableMix();
            }
            parentContext.loading(false);
        }).fail(function(){
            parentContext.loading_message("An error has occured. Please try again");
        });
    }

    refreshTable(currentPage, start,length){
        let request = {
            draw:currentPage,
            start:start,
            length:length,
            columns:this.columnDef,
            order: this.columnOrder,
        };

        let parentContext = this;
        $.post({
            url:this.url+"/getRows",
            data:JSON.stringify(request),
            contentType: "application/json",
            success:function(dbData) {
                parentContext.drawNumber = dbData.draw;
                if(parentContext.dataTable){
                    parentContext.dataTable.clear();
                    parentContext.dataTable.rows.add(dbData.data);
                    parentContext.dataTable.draw(dbData.draw);
                    parentContext.dataTable.columns.adjust();
                }
                if(!parentContext.dataTable) {
                    parentContext.dataTable = $("#" + parentContext.id + " #queryTable_table").DataTable({
                        "lengthMenu": [10, 20, 50, 100],
                        "bInfo" : false,
                        "paging":false
                    });
                    parentContext.dataTable.rows.add(dbData.data);
                    parentContext.dataTable.page.len(10);
                    parentContext.dataTable.draw(dbData.draw);
                    parentContext.dataTable.columns.adjust();
                    parentContext.loadRecordsPerPage();
                }

                let totalPage = Math.ceil(Number(dbData.recordsTotal)/Number(request.length));

                parentContext.updateShowingInfo(Number(request.start),Number(request.start)+Number(request.length),Number(dbData.recordsTotal));
                parentContext.loadPaging(currentPage,totalPage,Number(request.length));
            },
            dataType: "json"
        });
    }

    loadPaging(currentPage, totalPage, dataLength){
        let pagingElement ='<div class="dataTables_paginate paging_simple_numbers" id="queryTable_table_paginate">';
        pagingElement +='<ul class="pagination">';
        if(currentPage==0){
            pagingElement +='<li class="paginate_button page-item previous disabled" id="queryTable_table_previous"><a aria-controls="queryTable_table" class="page-link">Previous</a></li>';
        } else {
            pagingElement +='<li class="paginate_button page-item previous" id="queryTable_table_previous"><a aria-controls="queryTable_table" class="page-link">Previous</a></li>';
        }

        let visibleStart = ((currentPage - 2)<1)?1:(currentPage - 2);
        let visibleStartElipses = ((visibleStart - 1)<1)?1:((visibleStart - 1) - 2);
        let visibleStop = ((currentPage + 2)>totalPage)?totalPage:(((currentPage + 2)<5)?5:(currentPage + 2));
        let visibleStopElipses = ((visibleStop + 1)>totalPage)?totalPage:(visibleStop + 1);

        //console.log(visibleStartElipses+"-"+visibleStart+"-"+visibleStop+"-"+visibleStopElipses+"-"+totalPage);

        for(let pageNum=1;pageNum<=totalPage;pageNum++){

            if(pageNum<visibleStart){
                if(pageNum==visibleStartElipses) {
                    pagingElement +='<li class="paginate_button page-item"><span class="page-link">...</span></li>';
                }
                continue;
            }
            if(currentPage==pageNum){
                pagingElement +='<li class="paginate_button page-item active"><a aria-controls="queryTable_table" data-dt-idx="'+pageNum+'" tabindex="0" class="page-link">'+pageNum+'</a></li>';
            } else {
                pagingElement +='<li class="paginate_button page-item"><a aria-controls="queryTable_table" data-dt-idx="'+pageNum+'" tabindex="0" class="page-link">'+pageNum+'</a></li>';
            }
            if(pageNum>visibleStop){
                if(pageNum==visibleStopElipses) {
                    pagingElement +='<li class="paginate_button page-item"><span class="page-link">...</span></li>';
                }
                continue;
            }
        }

        if(currentPage==totalPage){
            pagingElement +='<li class="paginate_button page-item next disabled" id="queryTable_table_next"><a aria-controls="queryTable_table" class="page-link">Next</a></li></ul></div>';
        } else {
            pagingElement +='<li class="paginate_button page-item next" id="queryTable_table_next"><a aria-controls="queryTable_table" class="page-link">Next</a></li></ul></div>';
        }
        let parentContext = this;
        $("#" + this.id + " #queryTable_table_wrapper > div:nth-child(3) > div:nth-child(2)").html(pagingElement);
        $("#" + this.id + " #queryTable_table_paginate > ul > li.paginate_button.page-item > a").click(function(){
            switch($(this).html()){
                case "Next":
                    if(currentPage<totalPage){
                        let nextPage = Number(currentPage+1);
                        if(nextPage>totalPage){
                            nextPage=totalPage;
                        }
                        let nextIndex = (nextPage-1)*Number(dataLength);
                        parentContext.refreshTable(nextPage,nextIndex,dataLength);
                    }
                    break;
                case "Previous":
                    if(currentPage<totalPage){
                        let prevPage = Number(currentPage-1);
                        if(prevPage<0){
                            prevPage=0;
                        }
                        let prevIndex = (prevPage-1)*Number(dataLength);
                        parentContext.refreshTable(prevPage,prevIndex,dataLength);
                    }
                    break;
                default:
                    if(Number($(this).html())>0&&Number($(this).html())<=totalPage){
                        let curPage = Number($(this).html());
                        let curIndex = (curPage-1)*dataLength;
                        parentContext.refreshTable(curPage,curIndex,dataLength);
                    }
                    break;
            }
        });
    }

    updateShowingInfo(startIndex,recordLength,totalRecords){
        if(recordLength>totalRecords){
            recordLength=totalRecords;
        }
        let bInfo = '<div class="dataTables_info" id="queryTable_table_info" role="status" aria-live="polite">Showing '+(startIndex+1)+' to '+ (recordLength) +' of '+totalRecords+' entries</div>';
        $("#" + this.id + " #queryTable_table_wrapper > div:nth-child(3) > div:nth-child(1)").html(bInfo);
    }

    loadRecordsPerPage(){
        let rppElement = '<div class="dataTables_length" id="queryTable_table_length"><label>';
        rppElement += '<select name="queryTable_table_length" aria-controls="queryTable_table" class="custom-select custom-select-sm form-control form-control-sm">';
        rppElement += '<option value="10">10</option>';
        rppElement += '<option value="20" selected>20</option>';
        rppElement += '<option value="50">50</option>';
        rppElement += '<option value="100">100</option>';
        rppElement += '</select> Records per page</label></div>';

        let parentContext = this;
        $("#"+this.id+" #queryTable_table_wrapper > div:nth-child(1) > div:nth-child(1)").html("");
        $("#"+this.id+" #queryTable_table_wrapper > div:nth-child(1) > div:nth-child(1)").append(rppElement);

        $("#"+this.id+" #queryTable_table_length > label > select").change(function(){
            let rpp = $(this).children("option:selected").val();
            parentContext.refreshTable(1,0,rpp);
        });
    }

    loadTableMix(){
        this.refreshTable(1,0,20);
    }

    loadTableClient(){
        this.dataTable = $("#"+this.id+" #queryTable_table").DataTable({
            "lengthMenu": [ 10, 20, 50, 100 ],
        });
        this.dataTable.page.len(20);
    }

    loadTableFromServer(){
        var parentContext = this;
        parentContext.drawNumber=-1;
        this.dataTable = $("#"+this.id+" #queryTable_table").DataTable( {
            "processing": true,
            "serverSide": true,
            "lengthMenu": [ 10, 20, 50, 100 ],
            ajax: {
                "url": parentContext.url+'/getRows',
                "contentType": "application/json",
                "type": "POST",
                "data": function ( d ) {
                    return JSON.stringify(d);
                },
                "dataType":"json"
            },
        } );
        this.dataTable.page.len(20);
    }

    render(){
        this.loadPage();
    }
}

export default QueryPage;