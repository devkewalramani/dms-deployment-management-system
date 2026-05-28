<CFSETTING ENABLECFOUTPUTONLY="Yes">
<!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<!--  CT_DATE_INPUT.CFM                                            -->
<!--  VERSION 2.0                                                  -->
<!--  COLDFUSION CUSTOM TAG: FREEWARE POPUP DATE CONTROL           -->

<!--  TO USE THIS TAG, YOU AGREE TO LEAVE THE CONTENTS UNALTERED   -->
<!--  INCLUDING THESE COMMENTS.                                    -->

<!--  CAN REPLACE AN INPUT TAG FOR A DATE FIELD WITHOUT ANY        -->
<!--  SPECIAL PROGRAMMING.                                         -->

<!--  PROGRAMMER:  ORVILLE CHOMER (CHOMER.COM) (c) 2004-2005       -->
<!--                                                               -->
<!--  TESTED USING MICROSOFT INTERNET EXPLORER, NOT TESTED WITH    -->
<!--  OTHER BROWSERS AS OF YET.                                    -->
<!--                                                               -->
<!--  FOR INFO ON USAGE, SEE THE FILE: README.TXT                  -->
<!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

<!-- @@@@@@@@@@@@@@@@@@@@@@@ CHANGES AND UPDATES @@@@@@@@@@@@@@@@@ 

     FOR V: 2.0:
     7/28/05 - Now if the date control is too low on the page
               (the popup gets cut off), the popup will be placed
               Above the control instead of Below the control. OC

     7/28/05 - Bug created by ver 1.4 has been fixed. If you clicked
               on the text area of the control before clicking on
               the popup button, you would get a Javascript error.
               This bug has been fixed. OC
               
     FOR V: 1.4:   
     5/26/05 - Finally fixed the positioning of the pop-up if its
               buried in a layer. In the previous version, if the
               first date control was Not in a layer then the ones
               in the layers would work.  Instead of putting the
               date control whereever the first control was placed,
               it now puts it right After the BODY tag. Although
               in the style I'm using position: absolute (which,
               in my opinion, should just work...) it doesn't!
               IE is fussy about layering sometimes. If you put 
               a layer <DIV> inside the <BODY> tag, but outside
               any tables or other layers, it works just as you'd
               expect. Hence the new code to deliberately places
               the layer at the top of the page after the <BODY>
               tag!   OC
               
     FOR V: 1.3:
     3/31/05 - Modified the code that calculates how many days are
               in each month. Some subsequent update of Internet
               Explorer "broke" the original code. I wrote new code
               that is not dependent on the Date object functioning
               the way it was assumed before.  OC
               
     FOR V: 1.2:
     9/30/04 - Added a Clear button to the calendar popup so a user
               can clear out the current date in the control. This
               is especially important if a user accidentally picks
               a date and then realizes the value should still be 
               blank!  OC
               
     FOR V: 1.1:
     9/27/04 - Changed CALLER to REQUEST variable to eliminate 
               problems with using this custom tag inside another
               custom tag. OC
     9/27/04 - Added javascript to change z-order of popup so it 
               will show properly when tag embedded on 
               a lower layer. OC
     9/27/04 - Added READONLY attribute, works like READONLY on 
               normal INPUT tag.
     9/27/04 - Added LOCKED attribute, use for dynamically disabling control.
               (See readme file for more info on disabling control)
     9/27/04 - Add ONCHANGE attribute. Works like ONCHANGE attribute of a
               SELECT tag. Use javascript in this tag the same way.
               So, now you can run javascript to do something when user picks 
               a date!

     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->

<cfparam name="ATTRIBUTES.NAME" type="string" default="">


<!-- DEFAULT VALUES -->
<cfset sValue = "">
<cfset sClass = "">
<cfset sStyle = "">
<cfset sButtonSrc = "calendar.gif">
<cfset sHeadColor = "white">
<cfset sSelBgColor = "##CCCCCC">
<cfset sSelFgColor = "white">
<cfset sCalColor = "white">
<cfset sCalFontColor = "black">
<Cfset sButtonEdgeColor = "black">
<Cfset sButtonColor = "##999999">
<CFset sBackColor = "##CCCCCC">
<cfset sCalBorderColor = "black">
<cfset sOnChange = "">



<cfif IsDefined("ATTRIBUTES.VALUE")>
   <cfset sValue = ATTRIBUTES.VALUE>
</cfif>

<cfif IsDefined("ATTRIBUTES.ONCHANGE")>
   <cfset sOnChange = " " & ATTRIBUTES.ONCHANGE & " ">
   <cfset sWork = Replace(sOnChange,"("," ","ALL")>
   <cfset sWork = Replace(sWork,")"," ","ALL")>
   <cfset sWork = Replace(sWork,"="," ","ALL")>
   <cfset sWork = Replace(sWork,"+"," ","ALL")>
   <cfset sWork = Replace(sWork,"-"," ","ALL")>
   <cfset sWork = Replace(sWork,"."," ","ALL")>
   <cfset nPos = Find(" this ", sWork)>
   
   <cfif nPos EQ 1>
      <cfset sOnChange = "document.all.#ATTRIBUTES.NAME#_ctl" & Mid(sOnChange, nPos+5, Len(sOnChange)-5)>
   </cfif>
   <cfif nPos GT 1>
      <cfset sOnChange = Mid(sOnChange,1,nPos) & "document.all.#ATTRIBUTES.NAME#_ctl" & Mid(sOnChange, nPos+5, Len(sOnChange)-5)>
   </cfif>

</cfif>

<cfif IsDefined("ATTRIBUTES.CLASS")>
   <cfset sClass = ATTRIBUTES.CLASS>
</cfif>

<cfif IsDefined("ATTRIBUTES.STYLE")>
   <cfset sStyle = ATTRIBUTES.STYLE>
</cfif>

<cfif IsDefined("ATTRIBUTES.BTN_SRC")>
   <cfset sButtonSrc = ATTRIBUTES.BTN_SRC>
</cfif>

<cfif IsDefined("ATTRIBUTES.HDCOLOR")>
   <cfset sHeadColor = ATTRIBUTES.HDCOLOR>
</cfif>

<!-- currently selected date background color variable: -->
<cfif IsDefined("ATTRIBUTES.SELBGCOLOR")>
   <cfset sSelBgColor = ATTRIBUTES.SELBGCOLOR>
</cfif>

<!-- currently selected date foreground color variable: -->
<cfif IsDefined("ATTRIBUTES.SELFGCOLOR")>
   <cfset sSelFgColor = ATTRIBUTES.SELFGCOLOR>
</cfif>

<cfif IsDefined("ATTRIBUTES.CALCOLOR")>
   <cfset sCalColor = ATTRIBUTES.CALCOLOR>
</cfif>

<cfif IsDefined("ATTRIBUTES.CALFONTCOLOR")>
   <cfset sCalFontColor = ATTRIBUTES.CALFONTCOLOR>
</cfif>

<cfif IsDefined("ATTRIBUTES.BUTTON_EDGE_COLOR")>
   <Cfset sButtonEdgeColor = ATTRIBUTES.BUTTON_EDGE_COLOR>
</cfif>

<cfif IsDefined("ATTRIBUTES.BUTTON_COLOR")>
   <Cfset sButtonColor = ATTRIBUTES.BUTTON_COLOR>
</cfif>

<cfif IsDefined("ATTRIBUTES.BACK_COLOR")>
   <CFset sBackColor = ATTRIBUTES.BACK_COLOR>
</cfif>

<cfif IsDefined("ATTRIBUTES.CAL_BORDER_COLOR")>
   <cfset sCalBorderColor = ATTRIBUTES.CAL_BORDER_COLOR>
</cfif>

<CFSET sDisabled="">

<cfoutput>
<CFIF IsDefined("REQUEST.DATE_CTRL_JS_ADDED") EQ False>
   <script language="javascript" type="text/javascript">
      var editDate = new Date();
      var initDate = new Date();
      var sDtCtrlName;
      var bPopupElementCreated = false;
	  
	  // global offset variables used for calculating the date popup's offset position value!
	  var nPiXOffset = 0;
	  var nPiYOffset = 0;
      
	  // **** figures out popup offset regardless how it is nested in layers using recursion!
	  function figurePopupOffset(obj) {
	  
	     if (obj.nodeName == "BODY") {
	        nPiXOffset = nPiXOffset + obj.scrollLeft;
		    nPiYOffset = nPiYOffset + obj.scrollTop;
		 } // end if
		 
		 if (obj.nodeName != "BODY" && obj.parentNode != null) {
		    figurePopupOffset(obj.parentNode);
		 } // end if
	  } // end of function figurePopupOffset(obj)
	  
      function pickPopupDate(btn, ctl_name, sBtnColor, sBtnBorderColor, sBackColor, sCalColor, sCalFontColor, sSelBgColor, sSelFgColor, sHeadColor, sCalBorderColor) {
         
         if (bPopupElementCreated == false) {  
            createPopupElement();  // create DIV tag to place popup calendar in (if its not made already)
         } // end if
         
         var cal =document.all.popup_cal;
         var a =document.all;
         
         // Make popup's colors look as desired:
         // ------------------------------------
         a.prev_year_btn.style.backgroundColor = sBtnColor;
         a.prev_year_btn.style.borderColor = sBtnBorderColor;
         a.prev_month_btn.style.backgroundColor = sBtnColor;
         a.prev_month_btn.style.borderColor = sBtnBorderColor;
         a.next_month_btn.style.backgroundColor = sBtnColor;
         a.next_month_btn.style.borderColor = sBtnBorderColor;
         a.next_year_btn.style.backgroundColor = sBtnColor;
         a.next_year_btn.style.borderColor = sBtnBorderColor;
         a.cal_close_btn.style.backgroundColor = sBtnColor;
         a.cal_close_btn.style.borderColor = sBtnBorderColor;
         a.popup_cal.style.backgroundColor = sBackColor;
         
         sDtCtrlName = ctl_name;
         if (cal.style.display == "") {
            cal.style.display = "none";
         } else {
		    nPiXOffset = 300;   // reset values...
	        nPiYOffset = -5;
			figurePopupOffset(btn);
			
            // var x =event.clientX-event.offsetX-100+document.body.scrollLeft;
            // var y =event.clientY-event.offsetY+17+document.body.scrollTop;     
			
			var x =event.clientX-event.offsetX -100 + nPiXOffset;
            var y =event.clientY-event.offsetY -5 + nPiYOffset;  
			       
				  // alert("x="+x+", y="+y);
				  
            // ** code to make popup ABOVE control if control too far down on page:
            if (y+cal.style.pixelHeight > document.body.clientHeight) {
               y = y - cal.style.pixelHeight - btn.style.pixelHeight - 3;
            } // end if
            
            
            cal.style.pixelLeft = x;
            cal.style.pixelTop = y;
            d = new Date();            
                                 
            // is there a date in the text box?
            if (document.all[ctl_name].value != "") {
               var s = document.all[ctl_name].value;
               d.setMonth(s.substr(0,2)-1);
               d.setDate(s.substr(3,2));
               d.setFullYear(s.substr(6,4));
            } // end if
            
            editDate = d;
            
            initDate.setMonth(editDate.getMonth());
			initDate.setYear(editDate.getYear());
            initDate.setDate(editDate.getDate());
            
            dispPopHdr(editDate);
            dispCal(sCalColor, sCalFontColor, sSelBgColor, sSelFgColor, sHeadColor, sCalBorderColor);
            cal.style.display = "";
            cal.style.zIndex = 10;   // added 9/27/04
         } // end if
      } // end of function pickPopupDate()
      
      function dispPopHdr(d) {
         var sMonth = "";
	     var nYear = d.getFullYear();
	     var nMonth = d.getMonth();
	     
	     switch (nMonth) {
	        case 0:
	           sMonth = "Jan";
	           break;
	        case 1:
	           sMonth = "Feb";
	           break;
	        case 2:
	           sMonth = "Mar";
	           break;
	        case 3:
	           sMonth = "Apr";
	           break;
	        case 4:
	           sMonth = "May";
	           break;
	        case 5:
	           sMonth = "Jun";
	           break;
	        case 6:
	           sMonth = "Jul";
	           break;
	        case 7:
	           sMonth = "Aug";
	           break;
	        case 8:
	           sMonth = "Sep";
	           break;
	        case 9:
	           sMonth = "Oct";
	           break;
	        case 10:
	           sMonth = "Nov";
	           break;
	        case 11:
	           sMonth = "Dec";
	           break;
         } // end switch
	              
	     var sHdr = sMonth + " " + nYear;
	     document.all.disp_month.innerHTML = sHdr;

      } // end of function dispPopHdr(d)
      
      var sGblCalColor;
      var sGblCalFontColor;
      var sGblSelBgColor;
      var sGblSelFgColor;
      var sGblHeadColor;
      var sGblCalBorderColor;
      
      function dispCal(sCalColor, sCalFontColor, sSelBgColor, sSelFgColor, sHeadColor, sCalBorderColor) {
         sGblCalColor = sCalColor;
         sGblCalFontColor = sCalFontColor;
         sGblSelBgColor = sSelBgColor;
         sGblSelFgColor = sSelFgColor;
         sGblHeadColor = sHeadColor;
         sGblCalBorderColor = sCalBorderColor;
         
         var dtStart = new Date();
         var totDays = 1;   // will replace with real total days in month!
         var Q = String.fromCharCode(34);
         
         dtStart.setMonth(editDate.getMonth());
         dtStart.setYear(editDate.getYear());
         dtStart.setDate(1);       

         var nStartDay =dtStart.getDay();
         
         // figure last day of month  - O.Chomer (v1.3)  March 31, 2005
         switch (editDate.getMonth()) {
            case 0:   // January
               totDays = 31;
               break;
            case 1:  // February
               totDays = 29;   // days in a non-leap year.
               // leap year??
               var r = editDate.getFullYear() / 4.0;
               if (r == Math.floor(r)) {
                  totDays = 28;  // yes! its a leap year!
               } else { 
                  var sYear = editDate.getFullYear()+"";
                  if (sYear.substr(2,2) == "00") {
                     var r = editDate.getFullYear() / 400.0;
                     if (r == Math.floor(r)) {
                        totDays = 28;  // yes! its a leap year!
                     } // end if
                  } // end if
               } // end if
               
               break;
            case 2:  // March
               totDays = 31;
               break;            
            case 3:  // April
               totDays = 30;
               break;
            case 4:  // May
               totDays = 31;
               break;                
            case 5:  // June
               totDays = 30;
               break;            
            case 6:  // July
               totDays = 31;
               break;             
            case 7:  // August
               totDays = 31;
               break;                 
            case 8:  // September
               totDays = 30;
               break;                   
            case 9:  // October
               totDays = 31;
               break;               
            case 10: // November
               totDays = 30;
               break;                
            case 11: // December
               totDays = 31;
               break;                     
         } // end switch
         // -------------- end of figuring  last day of month -- (v1.3)
         
         var s = "<table width=" +Q+ "100%" + Q + " bgcolor="+Q +sCalBorderColor+Q+" cellspacing=1>";
         s = s + "<tr>";
         s = s + "<td class="+Q+"cal_fnt"+Q+" align=center bgcolor="+Q+sHeadColor+Q+"><B>S</B></td>";
         s = s + "<td class="+Q+"cal_fnt"+Q+" align=center bgcolor="+Q+sHeadColor+Q+"><B>M</B></td>";
         s = s + "<td class="+Q+"cal_fnt"+Q+" align=center bgcolor="+Q+sHeadColor+Q+"><B>T</B></td>";
         s = s + "<td class="+Q+"cal_fnt"+Q+" align=center bgcolor="+Q+sHeadColor+Q+"><B>W</B></td>";
         s = s + "<td class="+Q+"cal_fnt"+Q+" align=center bgcolor="+Q+sHeadColor+Q+"><B>T</B></td>";
         s = s + "<td class="+Q+"cal_fnt"+Q+" align=center bgcolor="+Q+sHeadColor+Q+"><B>F</B></td>";
         s = s + "<td class="+Q+"cal_fnt"+Q+" align=center bgcolor="+Q+sHeadColor+Q+"><B>S</B></td>";
         s = s + "</tr>";
         s = s + "<tr>";
         
         
         // Show boxes for days before the first day of the month:
         var wkdy =0;
         if (nStartDay > 0) {
            for (n=0; n < nStartDay; n++) {
               s = s + "<td class="+Q+"cal_fnt"+Q+" bgcolor=" + Q+"##DCDCDC"+Q+">&nbsp;</td>";
               wkdy++;
            }  // next n
         } // end if
         
         // Generate actual calendar days:
         var sColor = "";
         for (n=1; n < totDays+1; n++) {
            sBColor = sCalColor;
            sColor = sCalFontColor;
            var bSel = false;
            
            if (n== initDate.getDate() && editDate.getFullYear()== initDate.getFullYear() && editDate.getMonth()== initDate.getMonth()) {
               sBColor=sSelBgColor;
               sColor = sSelFgColor; 
               bSel = true;
            } // end if
            
            s = s + "<td class="+Q+"cal_fnt"+Q+" bgcolor="+sBColor
            s = s + " onclick="+Q;
            s = s + " pckActualDt("+n+");"
            s = s + Q;
            
            if (bSel == false) {
               s = s + " onMouseOver="+Q;
               s = s + "highlightDate(this,'"+sSelBgColor+"','"+sSelFgColor+"');";
               s = s + Q;
               s = s + " onMouseOut="+Q;
               s = s + "highlightDate(this,'"+sCalColor+"','"+sCalFontColor+"');";
               s = s + Q;
            } // end if
            
            s = s + " style="+Q+"color: "+sColor+"; cursor: hand;"+Q+" ";
            s = s +" align=center>"+n+"</td>";
            wkdy++;
            if (wkdy >6) {
               s = s + "</tr>";
               s = s + "<tr>";
               wkdy = 0;
            } // end if
         } // next n
         
         // Generate blank boxs for week days beyond end of month:
         if (wkdy < 7 && wkdy > 0) {
            for (n=1; n < 6-wkdy+2; n++) {
               s = s + "<td class="+Q+"cal_fnt"+Q+" bgcolor=" + Q+"##DCDCDC"+Q+">&nbsp;</td>";
            } // next n
         } //
         
         s = s + "</table>";
         document.all.cal.innerHTML=s;
      } // end of function dispCal()
      
      // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      function hideCalendar() {
         if (bPopupElementCreated == false) {  
            createPopupElement();  // create DIV tag to place popup calendar in (if its not made already)
         } // end if 
         
         document.all.popup_cal.style.display="none";
      } // end of function hideCalendar()
            
      
      function nextMonth() {
         var y = editDate.getYear();
         var m = editDate.getMonth()+1;
         
         if (m > 11) {
            m=0;
            y++;
         } // end if
         
         editDate.setMonth(m);
         editDate.setYear(y);
         dispCal(sGblCalColor, sGblCalFontColor, sGblSelBgColor, sGblSelFgColor, sGblHeadColor, sGblCalBorderColor);
         dispPopHdr(editDate);
      } // end of function nextMonth()
      
      function prevMonth() {
         var y = editDate.getYear();
         var m = editDate.getMonth()-1;
         
         if (m < 0) {
            m=11;
            y--;
         } // end if
         
         editDate.setMonth(m);
         editDate.setYear(y);
         dispCal(sGblCalColor, sGblCalFontColor, sGblSelBgColor, sGblSelFgColor, sGblHeadColor, sGblCalBorderColor);
         dispPopHdr(editDate);
      } // end of function prevMonth()      
      
      function nextYear() {
         var y = editDate.getFullYear()+1;
         editDate.setYear(y);
		 dispCal(sGblCalColor, sGblCalFontColor, sGblSelBgColor, sGblSelFgColor, sGblHeadColor, sGblCalBorderColor);
         dispPopHdr(editDate);
      } // end of function nextYear() 
      
      function prevYear() {
         var y = editDate.getFullYear()-1;
         editDate.setYear(y);
		 dispCal(sGblCalColor, sGblCalFontColor, sGblSelBgColor, sGblSelFgColor, sGblHeadColor, sGblCalBorderColor);
         dispPopHdr(editDate);
      } // end of function prevYear() 
      
      
      //
      function pckActualDt(nDay) {
         var sMonth = (editDate.getMonth()+1-0) + "";
         var sDay = nDay+"";
         var sYear = editDate.getFullYear();
         
         if (sMonth.length==1) {
            sMonth = "0"+sMonth;
         } // end if
         
         if (sDay.length==1) {
            sDay = "0"+sDay;
         } // end if
                  
         document.all[sDtCtrlName].value = sMonth+"/"+sDay+"/"+sYear;
         document.all.popup_cal.style.display="none";
         
         // run any on-change javascript:   --- added: 09/27/04 OC
		 window.execScript(sDtCtrlName+"_onchange();","JScript");
		          

      } // end of function pckActualDt()
      
      // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      function clearDate() {
         document.all[sDtCtrlName].value = "";
         document.all.popup_cal.style.display="none";
         
         // run any on-change javascript:
         window.execScript(sDtCtrlName+"_onchange();","JScript");
      } //
      
      // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      // highlight a date if the mouse is over it:
      function highlightDate(el, hcolor, hcolor2) {
         el.style.backgroundColor = hcolor;
         el.style.color = hcolor2;
      } // end of function highlightDate()
      
      // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      function createPopupElement() {
         
         var elFirst = document.body.firstChild;
         var oDiv=document.createElement("DIV");
         oDiv.id = "popup_cal";
         document.body.insertBefore(oDiv, elFirst);
         var Q = String.fromCharCode(34);
         var s = "<DIV id="+Q+"popup_cal"+Q+" ";
         s = s + "style="+Q;
         s = s + "display: none; position: absolute; width: 120px; border-width : 1px;";
         s = s + "border : 1px outset; height:145px; background-color: #sBackColor#;"+Q;
         s = s + " UNSELECTABLE="+Q+"on"+Q;
         s = s + " class="+Q+"cal_fnt"+Q;
         s = s + ">";
         s = s + "<table cellpadding=0 cellspacing=0><tr>";
         s = s + "<td nowrap class="+Q+"cal_fnt"+Q+">";
         s = s + "<span title="+Q+"prev year"+Q+" ";
         s = s + "id="+Q+"prev_year_btn"+Q+" class="+Q+"cal_btn"+Q+" ";
         s = s + "onclick="+Q+"prevYear()"+Q+" ";
         s = s + "ondblclick="+Q+"prevYear()"+Q+" ";
         s = s + "UNSELECTABLE="+Q+"on"+Q+">&lt;&lt;</span>  ";
         s = s + "<span id="+Q+"prev_month_btn"+Q+" ";
         s = s + "class="+Q+"cal_btn"+Q+" ";
         s = s + "onclick="+Q+"prevMonth()"+Q+" ";
         s = s + "ondblclick="+Q+"prevMonth()"+Q+" ";    
         s = s + "title="+Q+"prev month"+Q+" ";
         s = s + "UNSELECTABLE="+Q+"on"+Q+">&lt;</span>  ";
         s = s + "<b><span id="+Q+"disp_month"+Q+" ";
         s = s + "UNSELECTABLE="+Q+"on"+Q+"></span></b>";
         
         s = s + "<span id="+Q+"next_month_btn"+Q+" ";
         s = s + "class="+Q+"cal_btn"+Q+" ";
         s = s + "onclick="+Q+"nextMonth()"+Q+" ";
         s = s + "ondblclick="+Q+"nextMonth()"+Q+" ";    
         s = s + "title="+Q+"next month"+Q+" ";
         s = s + "UNSELECTABLE="+Q+"on"+Q+">&gt;</span>  ";
         s = s + "<span title="+Q+"next year"+Q+" ";
         s = s + "id="+Q+"next_year_btn"+Q+" class="+Q+"cal_btn"+Q+" ";
         s = s + "onclick="+Q+"nextYear()"+Q+" ";
         s = s + "ondblclick="+Q+"nextYear()"+Q+" ";
         s = s + "UNSELECTABLE="+Q+"on"+Q+">&gt;&gt;</span>  ";  
         s = s + "</td></tr></table>";
         
         s = s + "<span id="+Q+"cal"+Q+"></span>";
         
         s = s + "<table width="+Q+"100%"+Q+"><tr>";
         s = s + "<td class="+Q+"cal_fnt"+Q+"align=center>";
         s = s + "<span class="+Q+"cal_btn"+Q+" ";
         s = s + "id="+Q+"cal_clear_btn"+Q+" ";
         s = s + "onclick="+Q+"clearDate()"+Q+" align=center ";
         s = s + "UNSELECTABLE="+Q+"on"+Q+">&nbsp;Clear&nbsp;</span>&nbsp;";
         s = s + "<span class="+Q+"cal_btn"+Q+" ";
         s = s + "id="+Q+"cal_close_btn"+Q+" ";
         s = s + "onclick="+Q+"document.all.popup_cal.style.display='none';"+Q+" align=center ";
         s = s + "UNSELECTABLE="+Q+"on"+Q+">&nbsp;Close&nbsp;</span>";
         s = s + "</td></tr></table>";
         
         s = s + "</DIV>";
         
         oDiv.outerHTML = s;
         
         bPopupElementCreated = true;
      } // end of function createPopupElement() 
      
   </script>
   <style>
      .cal_fnt { font-family: tahoma; font-size: 8pt; }
      .cal_btn { border : 1px solid #sButtonEdgeColor#; cursor: hand; background-color: #sButtonColor#; }
   </style>
   
</CFIF>

<CFIF IsDefined("ATTRIBUTES.DISABLED")>
   <CFSET sDisabled = " DISABLED ">
</CFIF>


<CFIF IsDefined("ATTRIBUTES.READONLY")>
   <CFSET sDisabled = " DISABLED ">
</CFIF>

<CFIF IsDefined("ATTRIBUTES.LOCKED")>
   <CFIF LCase(ATTRIBUTES.LOCKED) EQ "y" OR Trim(LCase(ATTRIBUTES.LOCKED)) EQ "readonly">
      <CFSET sDisabled = " DISABLED ">
   </CFIF>
</CFIF>

<CFIF  IsDefined("REQUEST.DATE_CTRL_JS_ADDED") EQ False>
  <CFSET REQUEST.DATE_CTRL_JS_ADDED="y">
</CFIF>
<table cellpadding=0 cellspacing=0><tr>
<td><input name="#ATTRIBUTES.NAME#" value="#sValue#" 
 id="#ATTRIBUTES.NAME#_ctl" onclick="hideCalendar()"
READONLY size="10" class="#sClass#" style="#sStyle#"></td>
<td><button title="click to pick date" #sDisabled#
onclick="pickPopupDate(this, '#ATTRIBUTES.NAME#_ctl','#sButtonColor#','#sButtonEdgeColor#','#sBackColor#','#sCalColor#','#sCalFontColor#','#sSelBgColor#','#sSelFgColor#','#sHeadColor#','#sCalBorderColor#');"
ondblclick="pickPopupDate(this, '#ATTRIBUTES.NAME#_ctl','#sButtonColor#','#sButtonEdgeColor#','#sBackColor#','#sCalColor#','#sCalFontColor#','#sSelBgColor#','#sSelFgColor#','#sHeadColor#','#sCalBorderColor#');"
style="height: 21px; background-color: #sButtonColor#;"><img src="#sButtonSrc#" border="0" 
width="16" vspace="0" hspace="0"></button></td></tr></table>
<SCRIPT language="javascript" type="text/javascript">
   function #ATTRIBUTES.NAME#_ctl_onchange() {
      #sOnChange#
   } // end of function #ATTRIBUTES.NAME#_onchange()
</SCRIPT>
</cfoutput>
<CFSETTING ENABLECFOUTPUTONLY="No">