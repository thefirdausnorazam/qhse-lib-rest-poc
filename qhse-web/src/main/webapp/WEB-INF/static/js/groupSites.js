var moveAllLeft, moveAllLeftGroups, moveAllRight, moveAllRightGroups, moveSelectedLeft, moveSelectedLeftGroups, moveSelectedRight, moveSelectedRightGroups, onFormSubmit;

moveSelectedRight = function() {
  jQuery('#destinationFields').append(jQuery('.fc-selected'));
  unselect(); 
};

moveSelectedLeft = function() {
  //jQuery('#sourceFields').append(jQuery('.fc-selected'));
  sorDivs("#sourceFields", jQuery(".fc-selected"));
  unselect(); 
};

moveAllRight = function() {
  jQuery('#sourceFields').find('div').addClass('fc-selected');
  jQuery('#destinationFields').append(jQuery('.fc-selected'));
  unselect(); 
};

moveAllLeft = function() {
  jQuery('#destinationFields').find('div').addClass('fc-selected');
  jQuery('#sourceFields').append(jQuery('.fc-selected'));
  unselect(); 
};

moveSelectedRightGroups = function() {
  jQuery('#sourceFields').find('div').removeClass('fc-selected');
  jQuery('#destinationFields').find('div').removeClass('fc-selected');
  unselect(); 
};

moveSelectedLeftGroups = function() {
  jQuery('#sourceFields').find('div').removeClass('fc-selected');
  jQuery('#destinationFields').find('div').removeClass('fc-selected');
  unselect(); 
};

moveAllRightGroups = function() {
  jQuery('#sourceFields').find('div').removeClass('fc-selected');
  jQuery('#destinationFields').find('div').removeClass('fc-selected');
  unselect(); 
};

moveAllLeftGroups = function() {
  jQuery('#sourceFields').find('div').removeClass('fc-selected');
  jQuery('#destinationFields').find('div').removeClass('fc-selected');
  unselect(); 
};

onFormSubmit = function() {
  var currentSiteId, currentSiteName, i, option, valu, viewableSites, viewableSites1;
  viewableSites1 = jQuery('#destinationFields').find('div').length;
  viewableSites = document.getElementById('viewableSites');  
  if (viewableSites1.length === 0 || viewableSites1 === 0) {
    currentSiteName = document.getElementById('currentSiteName');
    currentSiteId = document.getElementById('currentSiteId');
    option = document.createElement('option');
    option.text = currentSiteName.value;
    option.value = currentSiteId.value;
    viewableSites.add(option);
    viewableSites.options[0].selected = true;
  } else {
    i = 0;
    while (i < viewableSites1) {     
      valu = jQuery('#destinationFields').find('div').eq(i).attr('id');      
      jQuery('#viewableSites').append(jQuery('<option></option>').val(valu).html('One'));
      viewableSites.options[i].selected = true;
      i++;
    }
  }
};

jQuery(document).ready(function() {
  var $chooser, $destinationFields, $sourceFields;
  onPermissionLoad();
  $sourceFields = $('#sourceFields');
  $destinationFields = $('#destinationFields');
  $chooser = $('#fieldChooser').fieldChooser(sourceFields, destinationFields);
});
