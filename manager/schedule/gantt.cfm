<!--- 
<CF_GANTT>
Description: Base custom tag for <CF_GANTT>, creates the initial table.
File: gantt.cfm
Author: Shlomy Gantz
History:

Attributes:

STARTDATE [OPTIONAL] Gantt chart scale start date  (default: current date)
ENDDATE   [OPTIONAL] Gantt chart scale end date (default: one month from start date) 
--->

<!--- Make sure that the tag has an end tag --->
<cfif not thisTag.hasEndTag>
	<cfthrow type="Gantt" message="End tag required" detail="The cf_gantt custom tag requires an end tag">
</cfif>
 

<cfswitch expression="#thisTag.executionMode#">
<!--- Excute on CF_GANTT start  --->
	<cfcase value="Start">
		<CFSILENT>
			<cfparam name="attributes.StartDate" default="">
			<cfparam name="attributes.cellHeight" default="18">
			<cfparam name="attributes.cellWidth" default="18">
			<cfparam name="attributes.EndDate" default="">
			<cfparam name="attributes.Width" default="1000">
			<cfparam name="attributes.showAssignedTo" default="no">
			<cfparam name="attributes.showDuration" default="no">
			<cfparam name="attributes.ResizeGanttOnCollapse" default="YES">
			<cfparam name="attributes.dateformat" default="mm/dd/yy">
			<cfparam name="attributes.hscroll" default="yes">
			<cfparam name="attributes.Collapseable" default="yes">
			
			
			<CFIF not isboolean(attributes.showAssignedTo)>
				<cfthrow type="Gantt" message="showAssignedTo must be boolean" detail="The CF_GANTT attribute showAssignedTo value must be boolean (attributes.showAssignedTo:#attributes.showAssignedTo#)">
			</CFIF>
				<CFIF not isboolean(attributes.showDuration)>
				<cfthrow type="Gantt" message="showDuration must be boolean" detail="The CF_GANTT attribute showDuration value must be boolean (attributes.showDuration:#attributes.showDuration#)">
			</CFIF>
			<CFIF not isboolean(attributes.ResizeGanttOnCollapse)>
				<cfthrow type="Gantt" message="ResizeGanttOnCollapse  must be boolean" detail="The CF_GANTT attribute ResizeGanttOnCollapse value must be boolean (attributes.ResizeGanttOnCollapse:#attributes.ResizeGanttOnCollapse#)">
			</CFIF>
			<CFIF not isboolean(attributes.hscroll)>
				<cfthrow type="Gantt" message="hscroll  must be boolean" detail="The CF_GANTT attribute hscroll value must be boolean (attributes.hscroll:#attributes.hscroll#)">
			</CFIF>
			<CFIF not isboolean(attributes.Collapseable)>
				<cfthrow type="Gantt" message="Collapseable  must be boolean" detail="The CF_GANTT attribute Collapseable value must be boolean (attributes.Collapseable:#attributes.Collapseable#)">
			</CFIF>
			
			
			<!--- Create initial query to hold the gantt chart --->
			<cfset qItems = querynew("realid,dependencies,id,name,lenname,startdate,enddate,ghref,href,color,group,complete,children,child,parentid,milestone,assignedto,lenassignedto")>
			<cfset id = 0 >
		
			<cfscript>
				function maketree( query, unique, parent ){
			   var current = 0;
			   var path = 0;
			   var i = 0;
			   var j = 0;
			   var items = "";
			   var parents = "";
			   var position = "";
			   var column = "";
			   var retQuery = querynew( query.columnlist & ',sortlevel,allchildren' );
			   for (i=1;i lte query.recordcount;i=i+1)
				  items = listappend( items, query[unique][i] );
			   for (i=1;i lte query.recordcount;i=i+1)
				  parents = listappend( parents, query[parent][i] );
			   
			   for (i=1;i lte query.recordcount;i=i+1){
				  queryaddrow( retQuery );
				  position = listfind( parents, current );
				  while (not position){
					 path= listrest( path );
					 current = listfirst( path );
					 position = listfind( parents, current );
				  }
				  for (j=1;j lte listlen( query.columnlist ); j=j+1){
					 column = listgetat( query.columnlist, j );
					 querysetcell( retQuery, column, evaluate( 'query.'&column&'[position]') );
				  }
				  querysetcell( retQuery, 'sortlevel', listlen( path ) );
				  current = listgetat( items, position );
				  parents = listsetat( parents, position, '-' );
				  path = listprepend( path, current);
			   }
			   return retQuery;
			}
				</cfscript>
				
				<cfscript>
				function findallchildren(query, unique, parent,id,recurse )
				{
				var theChildren = "";
				var items="";
				var parents="";
				var i="";
				
				for (i=1;i lte query.recordcount;i=i+1)
				  items = listappend( items, query[unique][i] );
				  
				for (i=1;i lte query.recordcount;i=i+1)
				  parents = listappend( parents, query[parent][i] );
				
				for (i=1;i lte listlen(parents);i=i+1)
					{
					if(listgetat(parents,i) eq arguments.id)
						{
						theChildren = listappend(theChildren,listgetat(items,i));
						if(arguments.recurse) {
								if(listlen(findallchildren(arguments.query, arguments.unique, arguments.parent,listgetat(items,i),true)))
									{
										theChildren = listappend(theChildren,findallchildren(arguments.query, arguments.unique, arguments.parent,listgetat(items,i),true));
									}
							
							}
							
						}
					}
					
					
			
					return theChildren;
				
				}
				
				</cfscript>
				<cffunction name="deleteItems">
					<cfargument name="q">
					<cfargument name="id">
					<cfif not listlen(arguments.id)>
						<cfset arguments.id = 0>
					</cfif>
					<cfquery name="qRet" dbtype="query">
					select * from arguments.q
					where id not in (#arguments.id#)
					</cfquery>
					<cfreturn qRet>
				</cffunction>
				
				
				
				
				
		</CFSILENT>
		<CFOUTPUT>
		<!--- Main stylesheet --->
		<style type="text/css">
		.gdatehead {
		border-left:1px solid ##efefef;
		border-top:1px solid ##efefef;
		height:#attributes.cellHeight#px;
		font-size:10px;
		color:##000000;
		}
		.ghead {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-left:1px solid ##efefef;
		border-top:1px solid ##efefef;
		font-size:10px;
		}
		.gname {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-left:1px solid ##efefef;
		border-top:1px solid ##efefef;
		font-size:10px; font-weight:normal; color:##000000;
		}
		.gnameg {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-left:1px solid ##efefef;
		border-top:1px solid ##efefef;
		font-size:10px; font-weight:bold; color:##0000FF;
		}
		.ghead  a {
		font-size:10px;
		color:##000000;
		text-decoration:none;
		}
		.gheadwkend a {
		font-size:10px;
		color:##000000;
		text-decoration:none;
		}
		.gheadwkend {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-left:1px solid ##efefef;
		border-top:1px solid ##efefef;
		background-color:##cfcfcf;
		font-size:9px;
		}
		.gfiller {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-left:1px solid ##efefef;
		border-top:1px solid ##efefef;
		}
		.gfillerwkend {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-left:1px solid ##efefef;
		background-color:##cfcfcf;
		}
		.gitem {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-top:1px solid ##cccccc;
		}
		.gitemwkend {
		border-left:1px solid ##cccccc;
		border-top:1px solid ##cccccc;
		width: #attributes.cellWidth#px;
		height: #attributes.cellHeight#px;
		
		}
		
		
		.gitemgroup {
		height:#attributes.cellHeight#px;
		border-left:1px solid ##efefef;
		border-top:1px solid ##efefef;
		}
		.gitemgroupx5 {
		height:#attributes.cellHeight#px;
		
		border-left:1px solid ##efefef;
		border-top:1px solid ##efefef;
		}
		.gitemgroupwkend {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-left:1px solid ##efefef;
		background-color:##cfcfcf;
		}
		.gmilestone {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-top:1px solid ##efefef;
		border-left:1px solid ##efefef;
		font-size:14px;
		overflow:hidden;
		}
		.gmilestonewkend {
		width:#attributes.cellWidth#px;
		height:#attributes.cellHeight#px;
		border-left:1px solid ##cccccc;
		border-top:1px solid ##efefef;
		/*background-color:##cfcfcf;*/
		}
		.nodisplay {
		display:none;
		}
		.yesdisplay {
		}
		.btn {
		background-color:##FFFFFF;
		border:##FFFFFF;
		font:Arial, Helvetica, sans-serif;
		font-size:10px;
		color:##CCCCCC;
		width:12px;
		font-weight:bold;
		
		}
		
		.hrcomplete {

					color:##000000; height:4px; border:2px solid ##000000;
					width:#attributes.cellWidth+2#px;
					padding:0px;
					}
		.hrhalfcomplete {

					color:##000000; height:4px; border:2px solid ##000000; width:#round(attributes.cellWidth/2)#px;
					}
		
		</style>
		</CFOUTPUT>
		<!--- Tooltip start --->
		<script language="javascript">
function addEvent(elm, evType, fn, useCapture) {
	if (elm.addEventListener) { 
	elm.addEventListener(evType, fn, useCapture); 
	return true; 
	}
	else if (elm.attachEvent) { 
	var r = elm.attachEvent('on' + evType, fn); 
	EventCache.add(elm, evType, fn);
	return r; 
	}
	else {
	elm['on' + evType] = fn;
	}
}
function getEventSrc(e) {
	if (!e) e = window.event;

	if (e.originalTarget)
	return e.originalTarget;
	else if (e.srcElement)
	return e.srcElement;
}
function addLoadEvent(func) {
var oldonload = window.onload;
	if (typeof window.onload != 'function') {
	window.onload = func;
	} else {
	window.onload = 
		function() {
		oldonload();
		func();
		}
	}
}
var EventCache = function(){
	var listEvents = [];
	return {
		listEvents : listEvents,
	
		add : function(node, sEventName, fHandler, bCapture){
			listEvents.push(arguments);
		},
	
		flush : function(){
			var i, item;
			for(i = listEvents.length - 1; i >= 0; i = i - 1){
				item = listEvents[i];
				
				if(item[0].removeEventListener){
					item[0].removeEventListener(item[1], item[2], item[3]);
				};
				
				/* From this point on we need the event names to be prefixed with 'on" */
				if(item[1].substring(0, 2) != "on"){
					item[1] = "on" + item[1];
				};
				
				if(item[0].detachEvent){
					item[0].detachEvent(item[1], item[2]);
				};
				
				item[0][item[1]] = null;
			};
		}
	};
}();




var toolTipLib = { 
	xCord : 0,
	yCord : 0,
	attachToolTipBehavior: function() {
	var links = document.getElementsByTagName('a');
	var i;
		for ( i=0;i<links.length;i++ ) {
		addEvent(links[i],'mouseover',toolTipLib.tipOver,false);
		addEvent(links[i],'mouseout',toolTipLib.tipOut,false);
		links[i].setAttribute('tip',links[i].title);
		links[i].removeAttribute('title');
		}
	},
	tipOver: function(e) {
	obj = getEventSrc(e);
	toolTipLib.xCord = findPosX(obj);
	toolTipLib.yCord = findPosY(obj);
	tID = setTimeout("toolTipLib.tipShow(obj,'"+toolTipLib.xCord+"','"+toolTipLib.yCord+"')",500)
	},
	tipOut: function(e) {
		if ( window.tID )
		clearTimeout(tID);
		if ( window.opacityID )
		clearTimeout(opacityID);
	var l = getEventSrc(e);
	var div = document.getElementById('toolTip');
		if ( div ) {
		div.parentNode.removeChild(div);
		}
	},
	checkNode : function(obj) {
	var trueLink = obj;
		if ( trueLink.nodeName.toLowerCase() == 'a' ) {
		return trueLink;
		}
		while ( trueLink.nodeName.toLowerCase() != 'a' && trueLink.nodeName.toLowerCase() != 'body' )
		trueLink = trueLink.parentNode;
	return trueLink;
	},
	tipShow: function(obj,x,y) {
	var newDiv = document.createElement('div');
	var scrX = Number(x);
	var scrY = Number(y);
	var tp = parseInt(scrY+20);
	var lt = parseInt(scrX+20);
	var anch = toolTipLib.checkNode(obj);
	var hrf = anch.href;
	var addy = ( eval(hrf.length -7) > 25 ? hrf.toString().substr(7,25)+"..." : hrf.toString().substring(7) );
	newDiv.id = 'toolTip';
	newDiv.style.top = tp+'px'; newDiv.style.left = lt+'px';
	document.body.appendChild(newDiv);
	newDiv.innerHTML = "<p>"+anch.getAttribute('tip')+"</p>";
	newDiv.style.opacity = '.1';
	toolTipLib.tipFade('toolTip',10);
	},
	tipFade: function(div,opac) {
	var obj = document.getElementById(div);
	var passed = parseInt(opac);
	var newOpac = parseInt(passed+10);
		if ( newOpac < 80 ) {
		obj.style.opacity = '.'+newOpac;
		obj.style.filter = "alpha(opacity:"+newOpac+")";
		opacityID = setTimeout("toolTipLib.tipFade('toolTip','"+newOpac+"')",20);
		}
		else { 
		obj.style.opacity = '.80';
		obj.style.filter = "alpha(opacity:80)";
		}
	}
};
function findPosX(obj) {
var curleft = 0;
//alert(obj.parentNode)
if (obj.parentNode) {
	while (obj.offsetParent) {
	curleft += obj.offsetLeft
	obj = obj.offsetParent;
	}
}
else if (obj.x)
curleft += obj.x;
return curleft;
}

function findPosY(obj) {
var curtop = 0;
if (obj.offsetParent) {
	while (obj.offsetParent) {
	curtop += obj.offsetTop
	obj = obj.offsetParent;
	}
}
else if (obj.y)
curtop += obj.y;
return curtop;
}
addEvent(window,'load',toolTipLib.attachToolTipBehavior,false);
addEvent(window,'unload',EventCache.flush, false);

</script>
<style>
/* Fading Tooltips */
div#toolTip { position:absolute;background:#ffffff;border:1px solid #cfcfcf;text-align:left;padding:5px;-moz-border-radius:5px; }
div#toolTip p { margin:0;padding:0;color:#000;font:11px/12px verdana,arial,serif; }
div#toolTip p em { display:block;margin-top:3px;color:#f60;font-style:normal;font-weight:bold; } 
</style>
		<!--- Tooltip end --->
		<!--- Create initial table to hold the data --->
		<table cellpadding="0" cellspacing="0" border="0" id="theTable">
			<tr><td valign="top" bgcolor="#ffffff">
	</cfcase><!--- /cfcase value="Start" --->
	
	<!--- Excute on CF_GANTT end  --->
 	<cfcase value="End"><cfsilent>	
	<cfif not isdate(attributes.startdate)>
		<cfquery name="qGetMinDate" dbtype="query">
		select min(startdate) as minstart from qitems
		</cfquery>
		<cfset attributes.startdate = qGetMinDate.minstart>
	</cfif>
	<cfif not isdate(attributes.enddate)>
		<cfquery name="qGetMaxDate" dbtype="query">
		select max(enddate) as maxstart from qitems
		</cfquery>
		<cfset attributes.enddate = qGetMaxDate.maxstart>
	</cfif>
	
		<!--- Start on Saturday , End of saturday --->
			<cfif dayofweek(attributes.StartDate) neq 7>
				<cfset attributes.StartDate = dateadd("d","-#dayofweek(attributes.StartDate)#",attributes.StartDate)>
			</cfif>
			<cfif dayofweek(attributes.EndDate) neq 7>
				<cfset attributes.EndDate = dateadd("d",7-#dayofweek(attributes.EndDate)#,attributes.EndDate)>
			</cfif>
			<!--- Calculate the number of days between start and end --->
			<cfset Xunit_Count = datediff("d",attributes.StartDate,attributes.EndDate)>
			<!--- default unit size: to be replaced later by attributes --->
			<cfset Xunit_UnitSize = 10>
			<!--- Total width of gantt chart --->
			<cfset XWidth = Xunit_Count*Xunit_UnitSize>
	</cfsilent>
	
	<!--- Find Level for all items --->
	<cfset qitems = maketree(qItems,'id','parentid')>
	<!--- Find All children, grandchildren, illigitimate childs etc ..  --->
	<cfloop query="qitems">
		<cfset querysetcell(qitems,"allchildren",findallchildren(qItems,'id','parentid',qitems.id,true),qitems.id)>
	</cfloop>
	<!--- Find only level 1 children --->
	<cfloop query="qitems">
		<cfset querysetcell(qitems,"children",findallchildren(qItems,'id','parentid',qitems.id,false),qitems.id)>
	</cfloop>
	<cfif listlen(valuelist(qItems.dependencies))>
	<!--- <cfset attributes.Hscroll = "no"> 
	<cfset attributes.Collapseable = "no">--->
	</cfif>
	

	<!--- Figure out how big to make the left area --->
	<cfset maxLenOfName = arraymax(ListToArray(valuelist(qItems.lenname))) + arraymax(ListToArray(valuelist(qItems.sortlevel)))>	
	<cfset nameDivWidth = maxLenOfName*7>
	<cfset nameCellWidth = nameDivWidth-5>
	
	
	<cfif attributes.showAssignedTo>
		<cfset maxLenOfAssignedTo = arraymax(ListToArray(valuelist(qItems.lenAssignedTo)))>	
		<cfset nameDivWidth = nameDivWidth + maxLenOfAssignedTo*8>
		<cfset assigneToCellwidth = maxLenOfAssignedTo*8>
	</cfif>
	
	<cfif attributes.showDuration>
		<cfset nameDivWidth = nameDivWidth + 50>
		<cfset DurationCellwidth = 50>
	</cfif>

	<cfoutput>
	<cfset totHeight = (qitems.recordcount+2)*(attributes.cellHeight+2) >
	<!--- Fix firefox issues --->
	<cfif cgi.HTTP_USER_AGENT contains "firefox">
			<cfset leftHeight =	totHeight+12>
			<cfset rightHeight =	totHeight+attributes.cellHeight+12>
			<cfset firfoxGroupPositionFix =	"position:relative; top:-1px;">
			<cfset RightRowAdjustment =3>
			<cfset jsAdjustmentHide =0>
			<cfset jsAdjustmentShow =0>
			<cfif attributes.RESIZEGANTTONCOLLAPSE>
			<cfset LRDivStyle = 'style="height:#leftHeight#px"'>
			<cfelse>
			<cfset LRDivStyle = 'style="height:#leftHeight#px"'>
			</cfif>
	<cfelse>
			<cfset leftHeight =	totHeight>
			<cfset rightHeight =	totHeight+attributes.cellHeight-4>
			<cfset firfoxGroupPositionFix =	"">
			<cfset RightRowAdjustment =2>
			<cfset jsAdjustmentHide =0>
			<cfset jsAdjustmentShow =2>
			<cfif attributes.RESIZEGANTTONCOLLAPSE>
				<cfset LRDivStyle = ''>
			<cfelse>
				<cfset LRDivStyle = 'style="height:#leftHeight#px"'>
			</cfif>
	</cfif>
		
		
	<style type="text/css">
		div.scroll {  
		width: #nameDivWidth#px;	
		overflow:hidden;	
		border: 1px solid ##efefef;
		background-color: ##ffffff;
		padding: 0px;
		}
		div.scroll2 {	
		background-color: ##FFFFFF;
		padding: 0px;
		<cfif attributes.hscroll>
		width: #attributes.Width-nameDivWidth#px;
		overflow: scroll;
		/* IE properties */
		overflow-y: hidden;
		overflow-x: scroll;	
		
		</cfif>
		}
		<cfif attributes.hscroll>
		/* Fix for firefox : this is hidden from IE*/
		head:first-child+body div.scroll2 { overflow:-moz-scrollbars-none;overflow:-moz-scrollbars-horizontal; } 
		</cfif>
	</style>
	<script language="javascript" type="text/javascript">
			function findObj(theObj, theDoc)
			{
			var p, i, foundObj;if(!theDoc) theDoc = document;if( (p = theObj.indexOf("?")) > 0 && parent.frames.length){theDoc = parent.frames[theObj.substring(p+1)].document;theObj = theObj.substring(0,p);}
			if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];for (i=0; !foundObj && i < theDoc.forms.length; i++) foundObj = theDoc.forms[i][theObj];for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) foundObj = findObj(theObj,theDoc.layers[i].document);if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);  return foundObj;
			}
			
			aHide = new Array();
			
			
			function hide(list,groupid) {
			a = list.split(",");
			x=0;
			// Collapse all children 
			for(i=0;i<a.length;i++)
			{
				if(findObj('childgrid_'+a[i]).className== "yesdisplay")
				{
					x++
					
				}
				aHide[aHide.length] = a[i];
				findObj('child_'+a[i]).className = "nodisplay";
				findObj('childgrid_'+a[i]).className = "nodisplay";
			}
			
			<cfif attributes.ResizeGanttOnCollapse AND cgi.HTTP_USER_AGENT contains "firefox">
			// Adjust div
			
			curHeight = findObj('leftside').style.height;
			
			realHeight = curHeight.substring(0,curHeight.indexOf('p'));
			newHeight = 1*realHeight - Math.round(1*(x*#attributes.cellHeight+jsAdjustmentHide#)) ;
			
			findObj('leftside').style.height = newHeight + 'px';
			findObj('rightside').style.height = newHeight + 'px';
			</cfif>
			// Chage +/- sign
				findObj('minus_'+groupid).className = "nodisplay";
				findObj('plus_'+groupid).className = "yesdisplay";
				ReDrawDependencies();
			}
	
			function show(list,groupid) {
			a = list.split(",");
			for(i=0;i<a.length;i++)
				{
				findObj('child_'+a[i]).className = "gdatehead";
				findObj('childgrid_'+a[i]).className = "yesdisplay";
				
					for (var j = 0; j<aHide.length; j++)
					{
					if(aHide[j]==a[i]) {aHide.splice(j,1)}
					}
				
				
				
				
				
				
				if(findObj('minus_'+a[i])) {
											findObj('minus_'+a[i]).className = "nodisplay";
											findObj('plus_'+a[i]).className = "yesdisplay";
											}
				}
				
			<cfif attributes.ResizeGanttOnCollapse AND cgi.HTTP_USER_AGENT contains "firefox">
			// Adjust div
			curHeight = findObj('leftside').style.height;
			realHeight = curHeight.substring(0,curHeight.indexOf('p'));
			newHeight = 1*realHeight + 1*(a.length*#attributes.cellHeight+round(jsAdjustmentShow)#) ;
			findObj('leftside').style.height = newHeight + 'px';
			findObj('rightside').style.height = newHeight + 'px';
			</cfif>
			
			
				findObj('plus_'+groupid).className = "nodisplay";
				findObj('minus_'+groupid).className = "yesdisplay";
				ReDrawDependencies();
			}
		
		</script>
		</CFOUTPUT>
		<!--- Draw dependencies --->
		<script language="javascript">
function Graphics(canvas)
{
	this.canvas = canvas;
	this.cache = new Array;
	this.shapes = new Object;
	this.nObject = 0;

	// defaults
	this.penColor = "black";
	this.zIndex = 0;
}

Graphics.prototype.createPlotElement = function(x,y,w,h) 
{
	// detect canvas
	if ( !this.oCanvas )
	{
		if ( (this.canvas == undefined) || (this.canvas == "") ) 
			this.oCanvas = document.body;
		else 
			this.oCanvas = document.getElementById(this.canvas);
	}

	// retrieve DIV
	var oDiv;
	if ( this.cache.length )
		oDiv = this.cache.pop();
	else 
	{
		oDiv = document.createElement('div');
		this.oCanvas.appendChild(oDiv);

		oDiv.style.position = "absolute";
		oDiv.style.margin = "0px";
		oDiv.style.padding = "0px";
		oDiv.style.overflow = "hidden";
		oDiv.style.border = "0px";
	}

	// set attributes
	oDiv.style.zIndex = this.zIndex;
	oDiv.style.backgroundColor = this.penColor;
	
	oDiv.style.left = x;
	oDiv.style.top = y;
	oDiv.style.width = w + "px";
	oDiv.style.height = h + "px";

	oDiv.style.visibility = "visible";
	
	return oDiv;
}

Graphics.prototype.releasePlotElement = function(oDiv)
{
	oDiv.style.visibility = "hidden";
	this.cache.push(oDiv);
}

Graphics.prototype.addShape = function(shape)
{
	shape.oGraphics = this;
	shape.graphicsID = this.nObject;
	this.shapes[this.nObject] = shape;
	this.nObject++;
	shape.draw();
	return shape;
}

Graphics.prototype.removeShape = function(shape)
{
	if ( (shape instanceof Object) && 
		(shape.oGraphics == this) && 
		(this.shapes[shape.graphicsID] == shape) )
	{
		shape.undraw();
		this.shapes[shape.graphicsID] = undefined;
		shape.oGraphics = undefined;
	}
}
Graphics.prototype.clear = function()
{
	for ( var i in this.shapes )
		this.removeShape(this.shapes[i]);
}


//=============================================================================
// Point
Graphics.prototype.drawPoint = function(x,y)
{
	return this.addShape(new Point(x,y))
}

function Point(x,y)
{
	this.x = x;
	this.y = y;
}
Point.prototype.draw = function()
{
	this.oDiv = this.oGraphics.createPlotElement(this.x,this.y,1,1);
}
Point.prototype.undraw = function()
{
	this.oGraphics.releasePlotElement(this.oDiv);
	this.oDiv = undefined;
}

//=============================================================================
// Line
Graphics.prototype.drawLine = function(x1,y1,x2,y2)
{
	return this.addShape(new Line(x1,y1,x2,y2))
}

function Line(x1,y1,x2,y2)
{
	this.x1 = x1;
	this.y1 = y1;
	this.x2 = x2;
	this.y2 = y2;
}

Line.prototype.draw = function()
{
	this.plots = new Array;

	var dx = this.x2 - this.x1;
	var dy = this.y2 - this.y1;
	var x = this.x1;
	var y = this.y1;

	var n = Math.max(Math.abs(dx),Math.abs(dy));
	dx = dx / n;
	dy = dy / n;
	for ( i = 0; i <= n; i++ )
	{
		this.plots.push(this.oGraphics.createPlotElement(Math.round(x),Math.round(y),1,1));

		x += dx;
		y += dy;
	}
}
Line.prototype.undraw = function()
{
	while ( this.plots.length )
		this.oGraphics.releasePlotElement(this.plots.pop());
	this.plots = undefined;
}




function clearit() 
{
   gr.clear();
}
var gr = new Graphics();



function myDrawFunction(x1,y1,x2,y2)
{

gr.penColor = "red";
if(x1 < x2)
{
gr.drawLine(x1,y1,x1+5,y1);
gr.drawLine(x1+5,y1,x1+5,y2);
gr.drawLine(x1+5,y2,x2,y2);
}
else
{
var Xpoints = new Array(x1,x1+5,   x1+5,   x2-5,    x2-5,x2);
var Ypoints = new Array(y1,y1,   y2-5,    y2-5,    y2,y2);
gr.drawLine(x1,y1,x1+5,y1);
gr.drawLine(x1+5,y1,x1+5,y2-5);
gr.drawLine(x1+5,y2-5,x2-5,y2-5);
gr.drawLine(x2-5,y2-5,x2-5,y2);
gr.drawLine(x2-5,y2,x2,y2);
}
}


function findPosition( obj ) {
  if( obj.offsetParent ) {
    for( var posX = 0, posY = 0; obj.offsetParent; obj = obj.offsetParent ) {
      posX += obj.offsetLeft;
      posY += obj.offsetTop;
    }
    return [ posX, posY ];
  } else {
    return [ obj.x, obj.y ];
  }
}

</script>

		<!--- End Draw dependencies --->
<!--- //myDrawFunction(200,200,150,350); --->
	
	<!--- Left side starts --->
		<CFOUTPUT>
		<script>
	function arrayContains(array, search)
{
	for (var i = 0; i<array.length; i++)
	{
		if (array[i] == search)
		{
			return true;
		}
	}
	return false;
}



		function ReDrawDependencies() {
		//alert(aHide.join());
		clearit();
		<cfloop query="qItems">
			<cfif len(trim(qitems.dependencies))>
				//draw a line between end of dependency and start of this item 
				<cfloop list="#qitems.dependencies#" index="dependencyIDX">
				<cfquery name="qGetItemID" dbtype="query">
				SELECT id as dependencyRealID
				FROM qItems
				WHERE realID = '#dependencyIDX#'
				</cfquery>
				if( arrayContains(aHide,#id#) || arrayContains(aHide,#qGetItemID.dependencyRealID#))
				{
				
				}
				else
				{
					<cfif cgi.HTTP_user_agent contains "firefox">
					x1 = findPosX2(findObj('end_#dependencyIDX#'))+#round(attributes.cellwidth)#;
					y1 = findPosY2(findObj('end_#dependencyIDX#'))+#round(attributes.cellheight/2)#-220;
					x2 = findPosX2(findObj('start_#realid#'));
					y2 = findPosY2(findObj('start_#realid#'))/2+61<!--- -#round(attributes.cellheight)#-220 --->;
					
					<cfelse>
						x1 = findPosX(findObj('end_#dependencyIDX#'))+#round(attributes.cellwidth)#;
					y1 = findPosY(findObj('end_#dependencyIDX#'))+#round(attributes.cellheight/2)#;
					x2 = findPosX(findObj('start_#realid#'));
					y2 = findPosY(findObj('start_#realid#'))+#round(attributes.cellheight/2)#;
					</cfif>
					x1 = x1 - document.getElementById("rightside").scrollLeft;
					x2 = x2 - document.getElementById("rightside").scrollLeft;
					if(x1 <= x2)
					{
					if(x1 < #nameDivWidth#+5 ){x1 = #nameDivWidth#+5;}
					if(x2 <= #nameDivWidth#+5)	{x1 = -40;x2 = -40;}
					}
					else
					{
					if(x2 < #nameDivWidth#+10 ){x2 = #nameDivWidth#+10;}
					if(x1 <= #nameDivWidth#+5)	{x2 = -40;x1 = -40;}
					}
				//alert(y2)
					myDrawFunction(x1,y1,x2,y2);
				}
				</CFLOOP>
			</cfif>
		</cfloop>
	
		
		}
		
function findPosX2(obj) {
var curleft = 0;
//alert(obj.parentNode)
if (obj.parentNode) {
	while (obj.parentNode) {
	curleft += obj.offsetLeft
	obj = obj.parentNode;
	}
}
else if (obj.x)
curleft += obj.x;
return curleft;
}

function findPosY2(obj) {
var curtop = 0;
if (obj.parentNode) {
	while (obj.parentNode) {
	curtop += obj.offsetTop
	obj = obj.parentNode;
	}
}
else if (obj.y)
curtop += obj.y;
return curtop;
}


		</script>

	<div  id="leftside" class="scroll" #LRDivStyle# >
	<TABLE cellpadding="0" cellspacing="0" border="0" >
	
		<TR style="height:#attributes.cellHeight-1#px;">
				<cfif attributes.Collapseable><TD style="height:#attributes.cellHeight-1#px; width:5px"></TD></cfif>
			<TD style="width:#nameCellWidth#px;height:#attributes.cellHeight-1#px;"><nobr></TD>
			<cfif attributes.showAssignedTo>
			<TD style="height:#attributes.cellHeight-1#px; width:#assigneToCellwidth#px"></TD>
			</cfif>
			<cfif attributes.showDuration>
			<TD style="height:#attributes.cellHeight-1#px; width:#DurationCellwidth#px"></TD>
			</cfif>
		</TR>
		<TR style="height:#attributes.cellHeight#px; ">
				<cfif attributes.Collapseable><TD style="height:#attributes.cellHeight#px; width:5px;border-top:1px solid ##efefef"></TD></cfif>
			<TD style="width:#nameCellWidth#px;height:#attributes.cellHeight#px;border-top:1px solid ##efefef"><nobr></TD>
			<cfif attributes.showAssignedTo>
			<TD style="height:#attributes.cellHeight-1#px; width:#assigneToCellwidth#px;border-top:1px solid ##efefef"></TD>
			</cfif>
			<cfif attributes.showDuration>
			<TD  style="height:#attributes.cellHeight-1#px; width:#DurationCellwidth#px; font-size:12px; border-left:1px solid ##efefef;border-top:1px solid ##efefef" align="center">Duration</TD>
			</cfif>
		</TR>
		</CFOUTPUT>
		<CFOUTPUT query="qItems">
		<TR id="child_#qitems.id#">
		<cfif attributes.Collapseable>
			<TD class="gdatehead"  style="height:#attributes.cellHeight+RightRowAdjustment#px; width:5px"><cfif group><span id="minus_#qitems.id#"><input type="button" class="btn" onClick="hide('#allchildren#',#qitems.id#)" value="&##8211" /></span><span id="plus_#qitems.id#" class="nodisplay"><input type="button" class="btn" onClick="show('#children#',#qitems.id#)" value="+" /></span><cfelse>&nbsp;</cfif></TD>
			</cfif>
			<TD class="gnameg" style="height:#attributes.cellHeight+2#px;width:#nameCellWidth#px;"><nobr>
			<cfif sortlevel>
				#repeatstring("&nbsp;&nbsp;&nbsp;",sortlevel)#
				<cfif len(trim(qItems.ghref))>
				<a href="#qItems.ghref#" class="gnameg" target="_blank">#qItems.name#</a>
				<cfelseif len(trim(qItems.href))>
				<a href="#qItems.href#" class="gname" target="_blank">#qItems.name#</a>
				<cfelse>
				#qItems.name#
				</cfif>
			</cfif>
			
			</TD>
			<cfif attributes.showAssignedTo>
			<TD class="gname" style="height:#attributes.cellHeight+2#px;width:#assigneToCellwidth#px" align="center"><cfif len(trim(qItems.assignedTo))>#qItems.assignedTo#<cfelse>&nbsp;</cfif></TD>
			</cfif>
			<cfif attributes.showDuration>
			<TD  class="gname" style="height:#attributes.cellHeight+2#px;width:#DurationCellwidth#px; text-align:center; font-size:12px;" align="center"><cfif group><strong></cfif><cfif datediff("d",qItems.startdate,qItems.endDate)+1 gt 1>#datediff("d",qItems.startdate,qItems.endDate)+1# days<cfelse>1 day&lt;</cfif><cfif group></strong></cfif></TD>
			</cfif>
		</TR>
		</cfoutput>
	</TABLE></div>
	</TD><!--- Main table /td --->
	<!--- Left side ends --->
	
	<!--- Right side starts --->
		<cfoutput>
<!--- Main table td ---><TD valign="top" bgcolor="##ffffff"><div id="rightside" class="scroll2" #LRDivStyle# onscroll="ReDrawDependencies()"> 
<table cellpadding="0" cellspacing="0" border="0" style="width:1100px;">
			<!--- Headers with first day of week dates --->
		
			<TR style="height:#attributes.cellHeight#;">
				<cfloop from="1" to="#Xunit_Count#" index="a">
					<cfif DayOfWeek(dateadd('d',a-1,attributes.StartDate)) is 6 or DayOfWeek(dateadd('d',a-1,attributes.StartDate)) is 7>
						<TD class="ghead">&nbsp;</TD>
					<cfelseif DayOfWeek(dateadd('d',a-1,attributes.StartDate)) is 1>
						<TD colspan="5" align="center" class="gdatehead"> #dateformat(dateadd('d',a-1,attributes.StartDate),'mmm dd')#</TD>
					</cfif>
				</cfloop>
			</TR> 
			<!--- Headers with days of week  --->
			<TR>
				<cfloop from="1" to="#Xunit_Count#" index="a">
					<TD class="#iif(listfind('7,1',DayOfWeek(dateadd('d',a,attributes.StartDate))),de('gheadwkend'),de('ghead'))#" align="center"><A href="##" Title="#dateformat(dateadd('d',a,attributes.StartDate),'long')#">#left(dayofweekasstring(DayOfWeek(dateadd("d",a,attributes.StartDate))),1)#</A></td>
				</cfloop>
			</TR>
			</cfoutput>

		<cfoutput query="qItems">
	
			<!--- Calculate number of days between Gantt start date and Item start date --->
			<cfset current_Start = datediff("d",attributes.StartDate,qItems.StartDate)-1>
			<!--- Calculate total number of days for Item  --->
			<cfset current_End = datediff("d",qItems.StartDate,qItems.EndDate)+1>
			<!--- Calculate number of days between Item end date and Gantt end date --->
			<cfset Filler_End = Xunit_Count - current_Start - current_End>

			<TR id="childgrid_#qitems.id#" style="height:#attributes.cellHeight#px;" class="yesdisplay">
			<cfset x=1>
			<!--- Fill in the days from gantt startate till the item startdate --->
			<cfloop from="1" to="#current_Start#" index="i">
				<td class="<cfif listfind('7,1',DayOfWeek(dateadd("d",x,attributes.StartDate)))>gfillerwkend<cfelse>gfiller</cfif>">&nbsp;</td><cfset x=x+1>
			</cfloop>
			
			<!--- Start drawing the item  --->
			<!--- If it is a regular item just draw it --->
			<cfif not group>
				<cfloop from="1" to="#current_End#" index="i">
					<!--- Milestone --->
					<cfif current_End eq 1 and qitems.milestone>
						<td <cfif listfind('7,1,2',DayOfWeek(dateadd("d",x,attributes.StartDate)))>class="gmilestonewkend"<cfelse>class="gmilestone"</cfif> align="center"><div style="display:none;" id="start_#realid#"></div><a href="##" title="#name# #dateformat(startdate,attributes.dateformat)#" style="TEXT-DECORATION: none; color:###qitems.color#;"><strong>&diams;</strong></a><div style="display:none;" id="end_#realid#"></div></td>
					<!--- Regular item --->
					<cfelse>
						<cfset percentcompleteforCell = 1/current_End*i>
						<td <cfif listfind('7,1,2',DayOfWeek(dateadd("d",x,attributes.StartDate)))>class="gitemwkend"<cfelse>class="gitem"</cfif> bgcolor="#color#" align="left"><cfif i eq 1><a style="display:none;" id="start_#realid#"></a></cfif><a href="##" style="TEXT-DECORATION: none;" title="#name# <br>#dateformat(startdate,attributes.dateformat)#-#dateformat(enddate,attributes.dateformat)#"><cfif complete gte percentcompleteforCell><hr color="##000000" class="hrcomplete" /><cfelseif complete gte (percentcompleteforCell-(1/current_End)/2)><hr  class="hrhalfcomplete" <cfif caller.cgi.HTTP_USER_AGENT contains "firefox">style="position:relative; left:-7px;"</cfif> /><cfelse><hr style="color:###color#; height:#attributes.cellheight-14#px; border:2px solid ###color#;" noshade="noshade" color="###color#" /></cfif></a><cfif i eq current_End><a style="display:none;" id="end_#realid#"></a></cfif></td>
					</cfif>
				
					<cfset x=x+1>
				</cfloop>
			<cfelse><!--- cfif not group --->
				<!--- Groups are drawn differently because of the hr line --->
				<cfset mondayexists = 0 >
				<cfset presatexists = 0 >
				<cfloop from="1" to="#current_End#" index="i">
				
				
					<cfif listfind('7,1',DayOfWeek(dateadd("d",x,attributes.StartDate)))>
							<td style="border-left:1px solid ##efefef;border-top:1px solid ##cccccc;" bgcolor="##cccccc" align="left"><a href="##" title="#name# <br>#dateformat(startdate,attributes.dateformat)#-#dateformat(enddate,attributes.dateformat)#" style="TEXT-DECORATION: none;color:##000000;"><cfif i eq 1 or i eq current_End><div style="height:18px; overflow:hidden; #firfoxGroupPositionFix#"></cfif><hr style="color:##000000; height:4px; border:2px solid ##000000;" noshade="noshade"/><cfif i eq 1 or i eq current_End><div style="position:relative; top:-17px;#iif(i eq current_End,de('float:right;'),de(''))#">&diams;</div></div></cfif></a></td>
					<cfelse><!--- /cfif listfind('7,1',DayOfWeek(dateadd("d",x,attributes.StartDate))) --->
						<!--- If we haven't hit monday yet, and it is not monday --->
						<cfif not mondayexists and NOT DayOfWeek(dateadd("d",x,attributes.StartDate)) eq 2>
							<cfif not presatexists>
							<cfset colspan = 7-DayOfWeek(dateadd("d",x,attributes.StartDate))>
							<cfset showRtdiams = false>
							<cfif colspan gt current_end>
								<cfset colspan = current_end>
								<cfset showRtdiams = true>
							</cfif>
								<td colspan="#colspan#" class="gitemgroup" bgcolor="##ffffff" align="left"><a href="##" title="#name# <br>#dateformat(startdate,attributes.dateformat)#-#dateformat(enddate,attributes.dateformat)#" style="TEXT-DECORATION: none;color:##000000;"><cfif i eq 1 or i eq current_End><div style="height:18px; overflow:hidden; #firfoxGroupPositionFix#"></cfif><hr style="color:##000000; height:4px;border:2px solid ##000000;" noshade="noshade"/><cfif i eq 1 or i eq current_End><CFIF showRtdiams><div style="position:relative; top:-17px; float:right">&diams;</div><div style="position:relative; top:-17px; z-index:4">&diams;</div><cfelse><div style="position:relative; top:-17px;">&diams;</div></CFIF></div></cfif></a></td>
								<cfset presatexists = 1 >
							</cfif>
						<!--- If it is monday then try to colspan the whole week, if a whole week is not left, then COLSPAN what it left --->
						<cfelseif  DayOfWeek(dateadd("d",x,attributes.StartDate)) eq 2>
							<cfif datediff("d",dateadd("d",x,attributes.StartDate),qitems.enddate)+1 gte 5>
								<td colspan="5" class="gitemgroupx5" bgcolor="##ffffff" align="left"><a href="##" title="#name# <br>#dateformat(startdate,attributes.dateformat)#-#dateformat(enddate,attributes.dateformat)#" style="TEXT-DECORATION: none;color:##000000;"><cfif i eq 1 or i eq current_End><div style="height:18px; overflow:hidden; #firfoxGroupPositionFix#"></cfif><hr style="color:##000000; height:4px;border:2px solid ##000000" noshade="noshade"/><cfif i eq 1 or i eq current_End><div style="position:relative; top:-17px; #iif(i eq current_End,de('float:right;'),de(''))#">&diams;</div></div></cfif></a></td>
							<cfelse>
								<td colspan="#datediff('d',dateadd('d',x,attributes.StartDate),qitems.enddate)+1#" class="gitemgroup" bgcolor="##ffffff" align="left"><a href="##" title="#name# <br>#dateformat(startdate,attributes.dateformat)#-#dateformat(enddate,attributes.dateformat)#" style="TEXT-DECORATION: none;color:##000000;"><div style="height:18px; overflow:hidden; #firfoxGroupPositionFix#"><hr style="color:##000000; height:4px;border:2px solid ##000000" noshade="noshade"/><div style="position:relative; top:-17px; float:right;">&diams;</div></div></a></td>
							</cfif>
						<cfset mondayexists=1>
						
						<cfelseif mondayexists><!--- /cfif not mondayexists and NOT DayOfWeek(dateadd("d",x,attributes.StartDate)) eq 2 --->
					
						</cfif><!--- /cfif not mondayexists and NOT DayOfWeek(dateadd("d",x,attributes.StartDate)) eq 2 --->
				
					</cfif><!--- /cfif listfind('7,1',DayOfWeek(dateadd("d",x,attributes.StartDate))) --->
					<cfset x=x+1>
				</cfloop>
			</cfif><!--- /cfif not group --->
			
			<!--- Fill in the days from item end till the gantt enddate --->
			<cfloop from="1" to="#Filler_End#" index="i">
				<td class="<cfif listfind('7,1',DayOfWeek(dateadd("d",x,attributes.StartDate)))>gfillerwkend<cfelse>gfiller</cfif>">&nbsp;</td><cfset x=x+1>
			</cfloop>
	
		</TR>
	</cfoutput>
	</table></div>
	</td>
	</tr>	
	</table>
	<script language="javascript" type="text/javascript">
	ReDrawDependencies();
	</script>
	</cfcase>
	
 </cfswitch>