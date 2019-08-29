var $TABLE = $('#table');
var $BTN = $('#export-btn');
var $EXPORT = $('#export');

function addPerson() {
	var count = jQuery('table#participants tr#participantRow').length;
	var clone = jQuery('table#participants tr#participantRow:last').clone(true);
	clone.attr('style','');
	jQuery('table#participants tr#participantRow:last').after(clone);
	
	//Setting id of cloned attributes.
	jQuery('table#participants tr#participantRow:last input#incident\\.participants\\['+ (count-1) +'\\]\\.name').attr('id','incident.participants['+count+'].name');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count-1) +'\\]\\.type').attr('id','incident.participants['+count+'].type');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count-1) +'\\]\\.bodyPart').attr('id','incident.participants['+count+'].bodyPart');
	jQuery('table#participants tr#participantRow:last img#incident\\.participants\\['+ (count-1) +'\\]\\.bodyPartPicture').attr('id','incident.participants['+count+'].bodyPartPicture');
	jQuery('table#participants tr#participantRow:last canvas#incident\\.participants\\['+ (count-1) +'\\]\\.bodyPartCanvas').attr('id','incident.participants['+count+'].bodyPartCanvas');
	
	jQuery('table#participants tr#participantRow:last a#incident\\.participants\\['+ (count-1) +'\\]\\.open').attr('id','incident.participants['+count+'].open');
	jQuery('table#participants tr#participantRow:last a#incident\\.participants\\['+ (count-1) +'\\]\\.clear').attr('id','incident.participants['+count+'].clear');
	jQuery('table#participants tr#participantRow:last a#incident\\.participants\\['+ (count-1) +'\\]\\.save').attr('id','incident.participants['+count+'].save');
	
	jQuery('table#participants tr#participantRow:last input#incident\\.participants\\['+ (count-1) +'\\]\\.bodyPartPic').attr('id','incident.participants['+count+'].bodyPartPic');
	
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count-1) +'\\]\\.role').attr('id','incident.participants['+count+'].role');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count-1) +'\\]\\.department').attr('id','incident.participants['+count+'].department');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count-1) +'\\]\\.injuryType').attr('id','incident.participants['+count+'].injuryType');
	jQuery('table#participants tr#participantRow:last span#incident\\.participants\\['+ (count-1) +'\\]\\.roleMandatorySpan').attr('id','incident.participants['+count+'].roleMandatorySpan').text("");
	jQuery('table#participants tr#participantRow:last textarea').attr('id','incident.participants['+count+'].injuryDescription');
	
	//Setting name of cloned attributes.
	jQuery('table#participants tr#participantRow:last input#incident\\.participants\\['+ (count-1) +'\\]\\.name').attr('name','incident.participants['+count+'].name');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.type').attr('name','incident.participants['+count+'].type');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.bodyPart').attr('name','incident.participants['+count+'].bodyPart');
	jQuery('table#participants tr#participantRow:last img#incident\\.participants\\['+ (count) +'\\]\\.bodyPartPicture').attr('id','incident.participants['+count+'].bodyPartPicture');
	jQuery('table#participants tr#participantRow:last canvas#incident\\.participants\\['+ (count) +'\\]\\.bodyPartCanvas').attr('id','incident.participants['+count+'].bodyPartCanvas');
	
	jQuery('table#participants tr#participantRow:last a#incident\\.participants\\['+ (count) +'\\]\\.open').attr('name','incident.participants['+count+'].open');
	jQuery('table#participants tr#participantRow:last a#incident\\.participants\\['+ (count) +'\\]\\.clear').attr('name','incident.participants['+count+'].clear');
	jQuery('table#participants tr#participantRow:last a#incident\\.participants\\['+ (count) +'\\]\\.clear').hide();
	jQuery('table#participants tr#participantRow:last a#incident\\.participants\\['+ (count) +'\\]\\.save').attr('name','incident.participants['+count+'].save');
	jQuery('table#participants tr#participantRow:last a#incident\\.participants\\['+ (count) +'\\]\\.save').hide();
	
	jQuery('table#participants tr#participantRow:last input#incident\\.participants\\['+ (count-1) +'\\]\\.bodyPartPic').attr('name','incident.participants['+count+'].bodyPartPic');
	
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.role').attr('name','incident.participants['+count+'].role');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.department').attr('name','incident.participants['+count+'].department');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.injuryType').attr('name','incident.participants['+count+'].injuryType');
	jQuery('table#participants tr#participantRow:last textarea').attr('name','incident.participants['+count+'].injuryDescription');
	
	jQuery('table#participants tr#participantRow:last button').attr('id','count');
	
	//Empty cloned value.
	jQuery('table#participants tr#participantRow:last input').val('');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.type').val('');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.bodyPart').val('');
	jQuery('table#participants tr#participantRow:last img#incident\\.participants\\['+ (count) +'\\]\\.bodyPartPicture').val('');
	jQuery('table#participants tr#participantRow:last img#incident\\.participants\\['+ (count) +'\\]\\.bodyPartPicture').attr("src",'../images/body.JPG');
	jQuery('table#participants tr#participantRow:last img#incident\\.participants\\['+ (count) +'\\]\\.bodyPartPicture').hide();
	// Canvas resetting

	jQuery('table#participants tr#participantRow:last canvas#incident\\.participants\\['+ (count) +'\\]\\.bodyPartCanvas').remove();
	jQuery('table#participants tr#participantRow:last img#incident\\.participants\\['+ (count) +'\\]\\.bodyPartPicture').after('<canvas id="incident.participants['+ (count) +'].bodyPartCanvas" name="incident.participants['+ (count) +'].bodyPartCanvas" > </canvas>');
	jQuery('table#participants tr#participantRow:last canvas#incident\\.participants\\['+ (count) +'\\]\\.bodyPartCanvas').css('display','none');
	jQuery('table#participants tr#participantRow:last input#incident\\.participants\\['+ (count) +'\\]\\.bodyPartPic').val('');
	
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.role').val('');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.department').val('');
	jQuery('table#participants tr#participantRow:last select#incident\\.participants\\['+ (count) +'\\]\\.injuryType').val('');
	jQuery('table#participants tr#participantRow:last textarea').val('');
	
	reorganizationPerson();
	return false;
};

function deleteRow(row) {
	var count = jQuery('table#participants tr#participantRow').length;
	if(count==1){
		return false;//we do not allow to delete if there is single row.
	}
	var number = row.id;
	jQuery(row.parentElement.parentElement).remove();
	// increasing count in id
	reorganizationPerson();
	
  return false;
};

function reorganizationPerson(){
	var array = jQuery('table#participants tr#participantRow');
	for(var i=0;i<array.length;i++){
		
		jQuery(array[i]).find('input[id$="name"]').attr('id','incident.participants['+i+'].name');
		jQuery(array[i]).find('input[id$="name"]').attr('name','incident.participants['+i+'].name');

		jQuery(array[i]).find('select[id$="type"]').attr('id','incident.participants['+i+'].type');
		jQuery(array[i]).find('select[id$="type"]').attr('name','incident.participants['+i+'].type');
		
		jQuery(array[i]).find('select[id$="bodyPart"]').attr('id','incident.participants['+i+'].bodyPart');
		jQuery(array[i]).find('select[id$="bodyPart"]').attr('name','incident.participants['+i+'].bodyPart');
		
		jQuery(array[i]).find('img[id$="bodyPartPicture"]').attr('id','incident.participants['+i+'].bodyPartPicture');
		jQuery(array[i]).find('img[id$="bodyPartPicture"]').attr('name','incident.participants['+i+'].bodyPartPicture');
		
		jQuery(array[i]).find('canvas[id$="bodyPartCanvas"]').attr('id','incident.participants['+i+'].bodyPartCanvas');
		jQuery(array[i]).find('canvas[id$="bodyPartCanvas"]').attr('name','incident.participants['+i+'].bodyPartCanvas');
		
		jQuery(array[i]).find('input[id$="bodyPartPic"]').attr('id','incident.participants['+i+'].bodyPartPic');
		jQuery(array[i]).find('input[id$="bodyPartPic"]').attr('name','incident.participants['+i+'].bodyPartPic');
		
		jQuery(array[i]).find('a[id$="open"]').attr('id','incident.participants['+i+'].open');
		jQuery(array[i]).find('a[id$="open"]').attr('name','incident.participants['+i+'].open');
		
		jQuery(array[i]).find('a[id$="clear"]').attr('id','incident.participants['+i+'].clear');
		jQuery(array[i]).find('a[id$="clear"]').attr('name','incident.participants['+i+'].clear');
		
		jQuery(array[i]).find('a[id$="save"]').attr('id','incident.participants['+i+'].save');
		jQuery(array[i]).find('a[id$="save"]').attr('name','incident.participants['+i+'].save');
		
		jQuery(array[i]).find('select[id$="role"]').attr('id','incident.participants['+i+'].role');
		jQuery(array[i]).find('select[id$="role"]').attr('name','incident.participants['+i+'].role');

		jQuery(array[i]).find('select[id$="department"]').attr('id','incident.participants['+i+'].department');
		jQuery(array[i]).find('select[id$="department"]').attr('name','incident.participants['+i+'].department');

		jQuery(array[i]).find('select[id$="injuryType"]').attr('id','incident.participants['+i+'].injuryType');
		jQuery(array[i]).find('select[id$="injuryType"]').attr('name','incident.participants['+i+'].injuryType');
		
		jQuery(array[i]).find('textarea[id$="injuryDescription"]').attr('id','incident.participants['+i+'].injuryDescription');		
		jQuery(array[i]).find('textarea[id$="injuryDescription"]').attr('name','incident.participants['+i+'].injuryDescription');
	}
}

$('.table-up').click(function () {
  var $row = $(this).parents('tr');
  if ($row.index() === 1) return; // Don't go above the header
  $row.prev().before($row.get(0));
});

$('.table-down').click(function () {
  var $row = $(this).parents('tr');
  $row.next().after($row.get(0));
});

// A few jQuery helpers for exporting only
jQuery.fn.pop = [].pop;
jQuery.fn.shift = [].shift;

$BTN.click(function () {
  var $rows = $TABLE.find('tr:not(:hidden)');
  var headers = [];
  var data = [];
  
  // Get the headers (add special header logic here)
  $($rows.shift()).find('th:not(:empty)').each(function () {
    headers.push($(this).text().toLowerCase());
  });
  
  // Turn all existing rows into a loopable array
  $rows.each(function () {
    var $td = $(this).find('td');
    var h = {};
    
    // Use the headers from earlier to name our hash keys
    headers.forEach(function (header, i) {
      h[header] = $td.eq(i).text();   
    });
    
    data.push(h);
  });
  
  // Output the result
  $EXPORT.text(JSON.stringify(data));
});