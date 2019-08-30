import Component from "../../../lib/Component.js";
class NavBar extends Component{
    render(){
        //Select Admin dropdown on start up
        $("#enviroDropdown").css("background-color","rgb(19, 171, 148)");
    }
}

export default NavBar;