<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="law" tagdir="/WEB-INF/tags/law" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>
<%@ taglib prefix="scannell" uri="https://www.envirosaas.com/tags"%>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<!DOCTYPE">
<html>
<head>
  <meta http-equiv="expires" content="0">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="copyright" content="&copy; Scannell Solutions">
  <meta http-equiv="robots" content="noindex, nofollow, noarchive">
 <link rel="stylesheet" type="text/css" href="<scannell:resource value="/js/jsj/jquery.easypiechart/jquery.easy-pie-chart.css" />" />
 <!--  <title>enviroMANAGER Dashboard</title> -->
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.sparkline/jquery.sparkline.min.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.easypiechart/jquery.easy-pie-chart.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.datatables/jquery.datatables.min.js" />"></script>
<script type="text/javascript" src="<scannell:resource value="/js/jsj/jquery.datatables/bootstrap-adapter/js/datatables.js" />"></script>
	

 <script type="text/javascript">
 jQuery(document).ready(function() {
	 jQuery('div').removeClass('block-flat');	
	 
	 jQuery("#datatable").dataTable();
	    
	    //Search input style
	 jQuery('.dataTables_filter input').addClass('form-control').attr('placeholder','Search');
	 jQuery('.dataTables_length select').addClass('form-control');  
	 
	 
	 
	 
	 jQuery('.epie-chart').easyPieChart({
	        lineWidth: 8,
	        animate: 600,
	        size: 100,
	        onStep: function(val){//Update current value while animation
	          $("span", this.$el).html(parseInt(val) + "%");
	        }
	        });

});
 
 </script>

  
  
 

</head>

<body id="tip">

        
               <div class="stats_bar">
		      <div class="butpro butstyle">
				  <div class="sub">
					  <h2>due</h2>
					  <span>64</span></div>
					<div class="stat"><span class="up"><br>
					Actions for Completion</span></div>
				</div>
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>overdue</h2><span>3</span></div>
					<div class="stat"><span class="down"><br>Actions for Verification</span></div>
				</div>	
				<div class="butpro butstyle">
					<div class="sub">
					  <h2>OverDUE</h2>
					  <span>0</span></div>
					<div class="stat"><span class="equal"><br>Tasks</span></div>
				</div>
                <div class="butpro butstyle">
					<div class="sub">
					  <h2 style="font-size: 95%;">Completed on Target</h2>
					  <span>33</span></div>
					<div class="stat"><span class="equal"><br>Investigation</span></div>
				</div>
                <div class="butpro butstyle">
					<div class="sub">
					  <h2>OverDUE</h2>
					  <span>12</span></div>
					<div class="stat"><span class="down"><br>Actions &gt;30 Days</span></div>
				</div>
                <div class="butpro butstyle">
					<div class="sub">
					  <h2>OverDUE</h2>
					  <span>3</span></div>
					<div class="stat"><span class="down"><br>Actions &gt;60 Days</span></div>
				</div>
		    </div>
		    
		    <div class="row dash-cols">
			
				<div class="col-sm-6 col-md-6">
					<div class="block">
						<div class="header no-border">
							<h2>Incidents YTD by Cause in 2014 <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h2>
						</div>
                        <div class="content" style="height: 517px; text-align:center;">
                        <div style="float:left; width: 50%;"><h4>Human Error</h4>
                        <div class="epie-chart easyPieChart" data-barcolor="#5491F6" data-trackcolor="#F3F3F3" data-percent="45" style="width: 103px; height: 103px; line-height: 103px;"><span>45%</span><canvas width="150" height="150"></canvas><canvas width="103" height="103"></canvas></div></div>
                        <div style="float:left; width: 50%;"><h4>No Storage Procedure</h4>
                        <div class="epie-chart easyPieChart" data-barcolor="#FF9D25" data-trackcolor="#F3F3F3" data-percent="10" style="width: 103px; height: 103px; line-height: 103px;"><span>10%</span><canvas width="150" height="150"></canvas><canvas width="103" height="103"></canvas></div></div>
                         <div style="float:left; width: 50%;"><h4>Floor Surfacer</h4>
                        <div class="epie-chart easyPieChart" data-barcolor="#D3E050" data-trackcolor="#F3F3F3" data-percent="5" style="width: 103px; height: 103px; line-height: 103px;"><span>5%</span><canvas width="150" height="150"></canvas><canvas width="103" height="103"></canvas></div></div>
                        <div style="float:left; width: 50%;"><h4>Poor Training</h4>
                        <div class="epie-chart easyPieChart" data-barcolor="#FFC509" data-trackcolor="#F3F3F3" data-percent="8" style="width: 103px; height: 103px; line-height: 103px;"><span>8%</span><canvas width="150" height="150"></canvas><canvas width="103" height="103"></canvas></div></div>
                                              <div style="float:left; width: 50%;">
                        <h4>Safety Guards</h4>
                        <div class="epie-chart easyPieChart" data-barcolor="#E14440" data-trackcolor="#F3F3F3" data-percent="45" style="width: 103px; height: 103px; line-height: 103px;"><span>45%</span><canvas width="150" height="150"></canvas><canvas width="103" height="103"></canvas></div></div>
                        <div style="float:left; width: 50%;">
                        <h4>Engineering Fault</h4>
                        <div class="epie-chart easyPieChart" data-barcolor="#E04C78" data-trackcolor="#F3F3F3" data-percent="10" style="width: 103px; height: 103px; line-height: 103px;"><span>10%</span><canvas width="150" height="150"></canvas><canvas width="103" height="103"></canvas></div></div>

                        </div>
					</div>
				</div>	
				
				<div class="col-sm-6 col-md-6">
					<div class="block">
						<div class="header no-border">
							<h2>Incident by Type <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h2>
						</div>
						<div class="content">
						<h4>Incident</h4>
							<div class="progress">
							  <div class="progress-bar progress-bar-success" style="width: 40%">4</div>
							  <div class="progress-bar progress-bar-warning" style="width: 20%">2</div>
                              <div class="progress-bar progress-bar-danger" style="width: 5%">1</div>
							
							</div>
                            <h4>Accident</h4>
							<div class="progress">
						  <div class="progress-bar progress-bar-success" style="width: 30%">3</div>
							  <div class="progress-bar progress-bar-warning" style="width: 10%">1</div>
							  
							</div>
                            <h4>Complaint</h4>
							<div class="progress">
							  <div class="progress-bar progress-bar-success" style="width: 60%">11</div>
							  <div class="progress-bar progress-bar-warning" style="width: 20%">3</div>
							  
							</div>
                            <h4>Safety Comment</h4>
							<div class="progress">
						  <div class="progress-bar progress-bar-success" style="width: 80%">34</div>
							  <div class="progress-bar progress-bar-warning" style="width: 5%">0</div>
							  
							</div>
                              
                            </div>
						<div class="content no-padding">
							<table class="red">
								<thead>
									<tr>
										<th>Name</th>
										<th class="right"><span>59%</span>Minor</th>
										<th class="right"><span>41%</span>Major</th>
										<th class="right"><span>0%</span>Critical</th>
									</tr>
								</thead>
								<tbody class="no-border-x">
									<tr>
										<td style="width:40%;"><i class="fa fa-sitemap"></i>Incident</td>
										<td class="text-right">4</td>
										<td class="text-right">2</td>
										<td class="text-right">1</td>
									</tr>
									<tr>
										<td><i class="fa fa-tasks"></i> Accident</td>
										<td class="text-right">3</td>
										<td class="text-right">1</td>
										<td class="text-right">0</td>
									</tr>
									<tr>
										<td><i class="fa fa-signal"></i> Complaint</td>
										<td class="text-right">11</td>
										<td class="text-right">3</td>
										<td class="text-right">0</td>
									</tr>
									<tr>
										<td><i class="fa fa-bolt"></i> Safety Comment</td>
										<td class="text-right">34</td>
										<td class="text-right">0</td>
										<td class="text-right">0</td>
									</tr>
								</tbody>
							</table>
						</div>
                        
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12">
					<div class="block">
						<div class="header">							
							<h3>Open Incidents Assigned to Me <font style="text-shadow: orange;font-size: 200%; font-weight: bold;color: red">(SAMPLE)</font></h3>
						</div>
						<div class="content">
							<div class="table-responsive">
								<div id="datatable_wrapper" class="dataTables_wrapper form-inline" role="grid"><div class="row"><div class="col-sm-12"><div class="pull-right"><div id="datatable_filter" class="dataTables_filter"></div></div><div class="pull-left"><div class="dataTables_length" id="datatable_length"></div></div><div class="clearfix"></div></div></div><table aria-describedby="datatable_info" class="table table-bordered dataTable" id="datatable">
									<thead>
										<tr role="row"><th aria-label="ID: activate to sort column descending" aria-sort="ascending" style="width: 47px;" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting_asc">ID</th><th aria-label="Type: activate to sort column ascending" style="width: 344px;" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting">Type</th><th aria-label="Severity: activate to sort column ascending" style="width: 87px;" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting">Severity</th><th aria-label="Status: activate to sort column ascending" style="width: 303px;" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting">Status</th><th aria-label="Man Days Lost: activate to sort column ascending" style="width: 154px;" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting">Man Days Lost</th><th aria-label="Occured Date: activate to sort column ascending" style="width: 146px;" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting">Occured Date</th><th aria-label="Location: activate to sort column ascending" style="width: 129px;" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting">Location</th><th aria-label="Created By: activate to sort column ascending" style="width: 169px;" colspan="1" rowspan="1" aria-controls="datatable" tabindex="0" role="columnheader" class="sorting">Created By</th></tr>
									</thead>
									
								<tbody aria-relevant="all" aria-live="polite" role="alert"><tr class="gradeX odd">
											<td class="  sorting_1">67</td>
											<td class=" ">Incident : Machinery - Sheet Feed</td>
											<td class=" ">Minor</td>
											<td class="center ">Investigation In Progress</td>
											<td class="center ">0.2</td>
											<td class="center ">04-Oct-2010</td>
											<td class="center ">Area 12</td>
											<td class="center ">Doyle, Gemma</td>
										</tr><tr class="gradeC even">
											<td class="  sorting_1">152</td>
											<td class=" ">Incident : Machinery-Screen Printing</td>
											<td class=" ">Minor</td>
											<td class="center ">Incident Open (No Investigation)</td>
											<td class="center ">0.2</td>
											<td class="center ">01-Oct-2010</td>
											<td class="center ">Area 2</td>
											<td class="center ">Scannell, Mary C</td>
										</tr><tr class="odd gradeA">
											<td class="  sorting_1">160</td>
											<td class=" ">Accident : First Aid</td>
											<td class=" ">Major</td>
											<td class="center ">Incident Open (No Investigation)</td>
											<td class="center ">0.1											</td>
											<td class="center ">24-Sep-2010</td>
											<td class="center ">Boiler house</td>
											<td class="center ">Scannell, Mary C</td>
										</tr><tr class="even gradeA">
											<td class="  sorting_1">218</td>
											<td class=" ">Incident : Items falling</td>
											<td class=" ">Critical</td>
											<td class="center ">Incident Open (No Investigation)</td>
											<td class="center ">0.2</td>
											<td class="center ">08-Aug-2010</td>
											<td class="center ">Area 12</td>
											<td class="center ">McCullagh, Sheila</td>
										</tr><tr class="odd gradeA">
											<td class="  sorting_1">222</td>
											<td class=" ">Complaint : Noise nuisance</td>
											<td class=" ">Critical</td>
											<td class="center ">Investigation In Progress</td>
											<td class="center ">0</td>
											<td class="center ">05-Aug-2010</td>
											<td class="center ">Canteen</td>
											<td class="center ">O'Brien, Eileen</td>
										</tr><tr class="even gradeA">
											<td class="  sorting_1">230</td>
											<td class=" ">Complaint : Noise nuisance</td>
											<td class=" ">Critical</td>
											<td class="center ">Action In Progress</td>
											<td class="center ">0</td>
											<td class="center ">25-May-2010</td>
											<td class="center ">Area 15											</td>
											<td class="center ">O'Brien, Eileen</td>
										</tr></tbody></table><div class="row"><div class="col-sm-12"><div class="pull-left"><div id="datatable_info" class="dataTables_info">Showing 1 to 6 of 6 entries</div></div><div class="pull-right"><div class="dataTables_paginate paging_bs_normal"><ul class="pagination"><li class="prev disabled"><a href="#"><span class="fa fa-angle-left"></span>&nbsp;Previous</a></li><li class="active"><a href="#">1</a></li><li class="next disabled"><a href="#">Next&nbsp;<span class="fa fa-angle-right"></span></a></li></ul></div></div><div class="clearfix"></div></div></div></div>							
							</div>
						</div>
					</div>				
				</div>
			</div>
			

</body>
</html>