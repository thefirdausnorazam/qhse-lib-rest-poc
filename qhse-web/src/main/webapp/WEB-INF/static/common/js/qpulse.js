import Component from "/static/js/lib/Component.js";
import SideBar from "/static/js/modules/common/layout/SideBar.js";
import NavBar from "/static/js/modules/common/layout/NavBar.js";
class Framework extends Component{
    constructor() {
        super();
        this.NavBar = new NavBar();
        this.SideBar = new SideBar();
    }
    render(){
        //Load all behavior on startup
        this.NavBar.load();
        this.SideBar.load();
    }
}
window.qpulseFramework = new Framework();
window.qpulseFramework.load();