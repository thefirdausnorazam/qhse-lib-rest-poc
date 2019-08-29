// Useful class for interaction with cookies. You can do the following:
// - setCookie: Save a cookie.
// - getCookie: Retrieve a cooke.
// - saveForm: Save the state of an HTML form to a cookie.
// - loadForm: Load the state of an HTML form from a cookie.

Cookies = {

	load: function() {
		if((typeof Prototype=='undefined') || 
				parseFloat(Prototype.Version.split(".")[0] + "." + Prototype.Version.split(".")[1]) < 1.5)
			throw("cookies requires the Prototype JavaScript framework >= 1.5.0");
	},

	// Get the cookie.
	// var someVariable = Cookies.getCookie('your_cookie_name');
	getCookie: function(name) {
		var arg = name + "=";
		var alen = arg.length;
		var clen = document.cookie.length;
		var i = 0;
		while (i < clen) {
			var j = i + alen;
			if (document.cookie.substring(i, j) == arg) return getCookieValue (j);
			i = document.cookie.indexOf(" ", i) + 1;
			if (i == 0) break;
		}
		return null;
	},

	getCookieValue: function (offset) {
		var endstr = document.cookie.indexOf (";", offset);
		if (endstr == -1) {
			endstr = document.cookie.length;
		}
		return unescape(document.cookie.substring(offset, endstr));
	},

	// Set the cookie.
	// Cookies.setCookie('your_cookie_name', 'your_cookie_value', exp);
	setCookie: function(name, value) {
		var argv = Cookies.setCookie.arguments;
		var argc = Cookies.setCookie.arguments.length;
		var expires = (argc > 2) ? argv[2] : null;
		var path    = (argc > 3) ? argv[3] : null;
		var domain  = (argc > 4) ? argv[4] : null;
		var secure  = (argc > 5) ? argv[5] : false;
		document.cookie = name + "=" + escape (value) +
			((expires == null ) ? "" : ("; expires=" + expires.toGMTString())) +
			((path    == null ) ? "" : ("; path="    + path)) +
			((domain  == null ) ? "" : ("; domain="  + domain)) +
			((secure  == false) ? "" : "; secure");
	},

// It works on text fields and dropdowns in IE 5+
// It only works on text fields in Netscape 4.5

	loadForm: function() {
		for (var f = 0; f < Cookies.loadForm.arguments.length; f++) {
			formName = Cookies.loadForm.arguments[f];
			cookie = getCookie('saved_'+formName);

			//console.log("Loading saved_" + formName + "=" + cookie);
			if (cookie != null) {
				var cookieArray = cookie.split('&');
				new Form.getElements(formName).each(function(element) {

					var savedValue = null;
					for (i = 0; i < cookieArray.length; i++) {
						var cookieValue = decodeURIComponent(cookieArray[i]);
						var x = element.name.length + 1;
						if (cookieValue.substring(0, x) == (element.name + "=")) {
							savedValue = cookieValue.substring(x, cookieValue.length);
						}
					}

					//console.log("Setting element value " + element.name + "=" + savedValue);
					if (savedValue != null) {
						if (['input', 'textarea'].include(element.tagName.toLowerCase())) {
							switch (element.type.toLowerCase()) {
								case 'checkbox':
								case 'radio':
									if (element.value == savedValue) {
										element.checked = true;
									}
									break;
								case 'password': // Don't save passwords
									break;
								default:
									// 'hidden', 'submit', 'text', 'textarea'
									element.value = savedValue;
									break;
							}
						} else
						if (['select'].include(element.tagName.toLowerCase())) {
							for (j = 0; j < element.options.length; j++) {
								element.options[j].selected = (element.options[j].value == savedValue);
							}
						}
					}
				});
			}
		}
	},

	saveForm: function() {
		for (f = 0; f < Cookies.saveForm.arguments.length; f++) {
			formName = Cookies.saveForm.arguments[f];
			cookieValue = Form.serialize(formName);
			//alert("Saving form to cookie as :" + cookieValue)

			var exp = new Date();
			exp.setTime(exp.getTime() + (100 * 24 * 60 * 60 * 1000));
			Cookies.setCookie('saved_' + formName, cookieValue, exp);
		}
	}
}

Cookies.load();

// use the above code as follows:
//	<body onLoad="Cookies.loadForm('form_1', 'form_2', 'form_n')" onUnLoad="Cookies.saveForm('form_1', 'form_2', 'form_n')">
