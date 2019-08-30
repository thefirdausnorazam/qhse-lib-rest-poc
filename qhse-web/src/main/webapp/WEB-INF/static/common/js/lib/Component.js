class Component {
    constructor(){
        if(this.render === undefined) {
            throw new TypeError("Class must override render")
        }
    }
    load(){
        var parentContext = this;
        $(document).ready(function(){
            parentContext.render();
        });
    }
}

export default Component;