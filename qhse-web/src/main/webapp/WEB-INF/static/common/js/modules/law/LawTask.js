import Component from "/static/js/lib/Component.js";
import QueryPage from "/static/js/modules/querypage/QueryPage.js";
import Form from "/static/js/modules/common/form/Form.js";

class LawTask extends Component{
    constructor(queryTableId){
        super();
        this.form = new Form();

       this.queryPage= new QueryPage("qhse_law_tasks_"+queryTableId,"/law/lawTask","mix");

    }
    render() {
        this.form.load();
        this.queryPage.load();
    }
}

export default LawTask;