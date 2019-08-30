import Component from "../../../lib/Component.js";
class Form extends Component{
    constructor(){
        super();
        this.config={};


        //datepicker
        this.config.datepicker={};
        this.config.datepicker.format="dd-MM-yyyy";
        this.config.datepicker.startDate="01-January-2010";
        this.config.datepicker.autoclose=true;
        this.config.datepicker.clearBtn=true;
        this.config.datepicker.orientation="left";

        //select2
    }
    datePicker() {
        var config = this.config.datepicker;
        $(".qhse_form_date").datepicker({
            format: config.format,
            startDate: config.startDate,
            autoclose: config.autoclose,
            clearBtn:config.clearBtn,
            orientation:this.config.datepicker.orientation
        });
        $('.qhse_page_form select').select2({
                width:'100%',
                dropdownCssClass:'qhse_form_select'
        });
        $('.qhse_page_form select').on("select2:select", function (e) {
            $(e.currentTarget).children().attr("selected",false);
            $(e.currentTarget).children("option[value='"+$(e.currentTarget).val()+"']").attr("selected","selected");
        });
    }

    select2(){

    }
    render(){
        this.datePicker();
    }
}

export default Form;