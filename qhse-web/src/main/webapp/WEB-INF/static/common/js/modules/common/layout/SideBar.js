import Component from "../../../lib/Component.js";

class SideBar extends Component {
    constructor(){
        super();
        $(".cl-wrapper").css("top",$("#qhse_head_nav").css("height"));
        $(window).resize(function(){
            $(".cl-wrapper").css("top",$("#qhse_head_nav").css("height"));
        });
        this.toggleButton=$("#qhse_head_nav #sidebar-collapse");
    }
    render(){
        $("#qhse_page_sidebar .nav .nav-item .nav-link>span").on("show.bs.collapse",function(){
            $(".cl-sidebar").css("width",$("#qhse_page_sidebar").css("width"));
            $("#qhse_page_sidebar .nav .nav-item .nav-link").addClass("expanded");
            $("#qhse_head_nav #sidebar-collapse i").removeClass("fa-angle-right");
            $("#qhse_head_nav #sidebar-collapse i").addClass("fa-angle-left");
        });
        $("#qhse_page_sidebar .nav .nav-item .nav-link>span").on("hidden.bs.collapse",function(){
            $(".cl-sidebar").css("width",$("#qhse_page_sidebar").css("width"));
            $("#qhse_page_sidebar .nav .nav-item .nav-link").removeClass("expanded");
            $("#qhse_head_nav #sidebar-collapse i").removeClass("fa-angle-left");
            $("#qhse_head_nav #sidebar-collapse i").addClass("fa-angle-right");
        });
    }
}

export default SideBar;