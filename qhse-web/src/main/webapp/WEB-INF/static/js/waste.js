
  function populateSuperCodes() {
    DWRUtil.removeAllOptions("superCode");
    DWRUtil.removeAllOptions("code");
    DWRUtil.addOptions("superCode", {" ":" ", "  ":"Please Wait..."});   
    WasteDWRService.getSuperCodes(jQuery("#superSuperCode option:selected" ).val(), populateSuperCodesCallback);
  }

  function populateSuperCodesCallback(data) {
    DWRUtil.removeAllOptions("superCode");
    DWRUtil.addOptions("superCode", {" ":" "});
    DWRUtil.addOptions("superCode", data);
  }
  
  function populateCodes() {
    DWRUtil.removeAllOptions("code");
    DWRUtil.addOptions("code", {" ":" ", "  ":"Please Wait..."});
    WasteDWRService.getCodes(jQuery("#superCode option:selected" ).val(), populateCodesCallback);
  }
  
  function populateCodesCallback(data) {
    DWRUtil.removeAllOptions("code");
    DWRUtil.addOptions("code", {" ":" "});
    DWRUtil.addOptions("code", data);
  }
