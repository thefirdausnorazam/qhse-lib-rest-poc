var App = function () {

  var config = {//Basic Config
    tooltip: true,
    popover: true,
    nanoScroller: true,
    nestableLists: true,
    hiddenElements: false,
    bootstrapSwitch:false,
    dateTime:true,
    select2:true,
    switchh:true,
    tags:true,
    slider:false
  }; 
  

  
  /*DASHBOARD*/
  var dashboard = function(){
	  
  };
  /*END OF DASHBOARD*/  
  
      function toggleSideBar(_this){
        var b =jQuery("#sidebar-collapse")[0];
        var w =jQuery("#cl-wrapper");
        var s =jQuery(".cl-sidebar");
        
        if(w.hasClass("sb-collapsed")){
         jQuery(".fa",b).addClass("fa-angle-left").removeClass("fa-angle-right");
          w.removeClass("sb-collapsed");
        }else{
         jQuery(".fa",b).removeClass("fa-angle-left").addClass("fa-angle-right");
          w.addClass("sb-collapsed");
        }
        //updateHeight();
      }
      
      function updateHeight(){
        if(!jQuery("#cl-wrapper").hasClass("fixed-menu")){
          var button =jQuery("#cl-wrapper .collapse-button").outerHeight();
          var navH =jQuery("#head-nav").height();
          //var document = $(document).height();
          var cont =jQuery("#pcont").height();
          var sidebar = (jQuery(window).width() > 755 &&jQuery(window).width() < 963)?0:jQuery("#cl-wrapper .menu-space .content").height();
          var windowH =jQuery(window).height();
          
          if(sidebar < windowH && cont < windowH){
            if((jQuery(window).width() > 755 && jQuery(window).width() < 963)){
              var height = windowH;
            }else{
              var height = windowH - button - navH;
            }
          }else if((sidebar < cont && sidebar > windowH) || (sidebar < windowH && sidebar < cont)){
            var height = cont + button + navH;
          }else if(sidebar > windowH && sidebar > cont){
            var height = sidebar + button;
          }  
          
          // var height = ($("#pcont").height() < $(window).height())?$(window).height():$(document).height();
          jQuery("#cl-wrapper .menu-space").css("min-height",height);
        }else{
        	jQuery("#cl-wrapper .nscroller").nanoScroller({ preventPageScrolling: true });
        }
      }
        
  return {
   
    init: function (options) {
      //Extends basic config with options
     jQuery.extend( config, options );
      
      /*VERTICAL MENU*/
     jQuery(".cl-vnavigation li ul").each(function(){
       jQuery(this).parent().addClass("parent");
      });
      
     jQuery(".cl-vnavigation li ul li.active").each(function(){
       jQuery(this).parent().show().parent().addClass("open");
        //setTimeout(function(){updateHeight();},200);
      });
      
     jQuery(".cl-vnavigation").delegate(".parent > a","click",function(e){
       jQuery(".cl-vnavigation .parent.open > ul").not($(this).parent().find("ul")).slideUp(300, 'swing',function(){
          jQuery(this).parent().removeClass("open");
        });
        
        var ul =jQuery(this).parent().find("ul");
        ul.slideToggle(300, 'swing', function () {
          var p =jQuery(this).parent();
          if(p.hasClass("open")){
            p.removeClass("open");
          }else{
            p.addClass("open");
          }
          //var menuH = $("#cl-wrapper .menu-space .content").height();
          // var height = ($(document).height() < $(window).height())?$(window).height():menuH;
          //updateHeight();
        jQuery("#cl-wrapper .nscroller").nanoScroller({ preventPageScrolling: true });
        });
        e.preventDefault();
      });
      
      /*Small devices toggle*/
     jQuery(".cl-toggle").click(function(e){
        var ul =jQuery(".cl-vnavigation");
        ul.slideToggle(300, 'swing', function () {
        });
        e.preventDefault();
      });
      
      /*Collapse sidebar*/
     jQuery("#sidebar-collapse").click(function(){
          toggleSideBar();
      });
      
      
      if(jQuery("#cl-wrapper").hasClass("fixed-menu")){
        var scroll = jQuery("#cl-wrapper .menu-space");
        scroll.addClass("nano nscroller");
 
        function update_height(){
          var button =jQuery("#cl-wrapper .collapse-button");
          var collapseH = button.outerHeight();
          var navH = jQuery("#head-nav").height();
          var height = jQuery(window).height() - ((button.is(":visible"))?collapseH:0) - navH;
          scroll.css("height",height);
          jQuery("#cl-wrapper .nscroller").nanoScroller({ preventPageScrolling: true });
        }
        
        jQuery(window).resize(function() {
          update_height();
        });    
            
        update_height();
        jQuery("#cl-wrapper .nscroller").nanoScroller({ preventPageScrolling: true });
        
      }else{
    	  jQuery(window).resize(function(){
          //updateHeight();
        }); 
        //updateHeight();
      }

      
      /*SubMenu hover */
        var tool = jQuery("<div id='sub-menu-nav' style='position:fixed;z-index:9999;'></div>");
        
        function showMenu(_this, e){        	
          if((jQuery("#hoverTest").hasClass("testHover")||jQuery("#cl-wrapper").hasClass("sb-collapsed") || (jQuery(window).width() > 755 && jQuery(window).width() < 963)) && jQuery("ul",_this).length > 0){   
        	  jQuery(_this).removeClass("ocult");
            var menu = jQuery("ul",_this);
            if(!jQuery(".dropdown-header",_this).length){
              var head = '<li class="dropdown-header">' +  jQuery(_this).children().html()  + "</li>" ;
              menu.prepend(head);
            }            
            tool.appendTo("body");
            var top = (jQuery(_this).offset().top + 8) - jQuery(window).scrollTop();
            var left = jQuery(_this).width();
            
            tool.css({
              'top': top,
              'left': left + 8
            });
            tool.html('<ul class="sub-menu">' + menu.html() + '</ul>');
            tool.show();
            
            menu.css('top', top);
          }else{
            tool.hide();
          }
        }

        jQuery(".cl-vnavigation li").hover(function(e){
          showMenu(this, e);
        },function(e){
          
          tool.removeClass("over");
          setTimeout(function(){
            if(!tool.hasClass("over") && !jQuery(".cl-vnavigation li:hover").length > 0){
              tool.hide();
            }
          },500);
        });
        
        tool.hover(function(e){
        	jQuery(this).addClass("over");
        },function(){
        	jQuery(this).removeClass("over");
          setTimeout(function(){
            if(!tool.hasClass("over") && !jQuery(".cl-vnavigation li:hover").length > 0){
              tool.fadeOut("fast");
            }
          },500);
        });
        
        
        jQuery(document).click(function(){
          tool.hide();
        });
        jQuery(document).on('touchstart click', function(e){
          tool.fadeOut("fast");
        });
        
        tool.click(function(e){
          e.stopPropagation();
        });
     
        jQuery(".cl-vnavigation li").click(function(e){
          if(((jQuery("#cl-wrapper").hasClass("sb-collapsed") || (jQuery("#hoverTest").hasClass("testHover")) || (jQuery(window).width() > 755 && jQuery(window).width() < 963)) && jQuery("ul",this).length > 0) && !(jQuery(window).width() < 755)){
            showMenu(this, e);
            e.stopPropagation();
          }
        });
        
        jQuery(".cl-vnavigation li").on('touchstart click', function(){
          //alert($(window).width());
        });
        
        jQuery(window).resize(function(){
        //updateHeight();
      });

      var domh = jQuery("#pcont").height();
      jQuery(document).bind('DOMSubtreeModified', function(){
        var h = jQuery("#pcont").height();
        if(domh != h) {
          //updateHeight();
        }
      });
      
      /*Return to top*/
      var offset = 220;
      var duration = 500;
      var button = jQuery('<a href="#" class="back-to-top"><i class="fa fa-angle-up"></i></a>');
      button.appendTo("body");
      
      jQuery(window).scroll(function() {
        if (jQuery(this).scrollTop() > offset) {
            jQuery('.back-to-top').fadeIn(duration);
        } else {
            jQuery('.back-to-top').fadeOut(duration);
        }
      });
    
      jQuery('.back-to-top').click(function(event) {
          event.preventDefault();
          jQuery('html, body').animate({scrollTop: 0}, duration);
          return false;
      });
      
      /*Datepicker UI
     jQuery( ".ui-datepicker" ).datepicker();*/
      
      /*Tooltips*/
      jQuery('[data-toggle="tooltip"]').tooltip({trigger: 'hover','placement': 'top'});
      /*if(config.tooltip){
    	  jQuery('.ttip, [data-toggle="tooltip"]').tooltip();
      }*/
      
      /*Popover*/
      if(config.popover){
    	  jQuery('[data-popover="popover"]').popover();
      }

      /*switch*/
      if(config.switchh){
    	  jQuery('.switch').bootstrapSwitch();
      }
     
     
      
      /*DateTime Picker*/
      if(config.dateTime){    	  
    	  jQuery('.datetime').datepicker({autoclose: true,clearBtn:true});         
      }
      
      /*Select2*/
      if(config.select2){
    	  jQuery(".select2").select2({
          width: '100%'
         });
      }
      
       /*Tags*/
      if(config.tags){
    	  jQuery(".tags").select2({tags: 0,width: '100%'});
      }
      
       /*Slider*/
      if(config.slider){
    	  jQuery('.bslider').slider();     
      }
      
      /*Input & Radio Buttons*/
      if(jQuery().iCheck){
    	  jQuery('.icheck').iCheck({
          checkboxClass: 'icheckbox_square-blue checkbox',
          radioClass: 'iradio_square-blue'
        });
      }
      
      /*Bind plugins on hidden elements*/
      if(config.hiddenElements){
      	/*Dropdown shown event*/
    	  jQuery('.dropdown').on('shown.bs.dropdown', function () {
    		  jQuery(".nscroller").nanoScroller();
        });
          
        /*Tabs refresh hidden elements*/
    	  jQuery('.nav-tabs').on('shown.bs.tab', function (e) {
    		  jQuery(".nscroller").nanoScroller();
        });
      }
      
    },
      
    /*Pages Javascript Methods*/
    dashBoard: function (){
      dashboard();
    },
    
    
    toggleSideBar: function(){
      toggleSideBar();
    }
    
   /* nestableLists: function(){
      nestable();
    },
 
    wizard: function(){
      wizard();
    },
    
    masks: function(){
      masks();
    },
    
    textEditor: function(){
      textEditor();
    },
    
    dataTables: function(){
      dataTables();
    },
    
    maps: function(){
      maps();
    },
    
    charts: function(){
      charts();
    },
    
    widgets: function(){
      widgets();
    }*/
    
  };
 
}();

$(function(){
  //$("body").animate({opacity:1,'margin-left':0},500);
	jQuery("body").css({opacity:1,'margin-left':0});
});