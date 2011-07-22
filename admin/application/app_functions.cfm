
<CFSCRIPT>
/**
 * Removes HTML from the string.
 * 
 * @param string 	 String to be modified. 
 * @return Returns a string. 
 * @author Raymond Camden (ray@camdenfamily.com) 
 * @version 1, July 16, 2001 
 */
function StripHTML(str) {
	return REReplaceNoCase(str,"<[^>]*>","","ALL");
}
</CFSCRIPT>

<CFSCRIPT>
/**
 * Removes HTML from the string.
 * 
 * @param string 	 String to be modified. 
 * @return Returns a string. 
 * @author Raymond Camden (ray@camdenfamily.com) 
 * @version 1, July 16, 2001 
 */
function StripStyle(str) {
	str = REReplaceNoCase(str,"(<[^>]+) style=\""[^\""]*\""([^>]*>)","\1\2","ALL");
	str = REReplaceNoCase(str,"(<[^>]+) class=[^ |^>]*([^>]*>)","\1\2","ALL");
	str = REReplaceNoCase(str,"(<[^>]+) face=\""[^\""]*\""([^>]*>)","\1\2","ALL");
	str = REReplaceNoCase(str,"(<[^>]+)(size=\"")([^\""]*)(\"")([^>]*>)","\1style='font-size: \3pt'\5","ALL");
	str = REReplaceNoCase(str,"<li></li>","<p></p>","ALL");
	str = REReplaceNoCase(str,"</p><p>","<br>","ALL");
	str = REReplaceNoCase(str,"</p><li>","</p><ul><li>","ALL");
	str = REReplaceNoCase(str,"</li><p>","</li></ul><p>","ALL");
	//str = REReplaceNoCase(str,"</?font[^>]*>","","ALL");
	return str;
}
</CFSCRIPT>

<!--- Email validation --->
<CFSCRIPT>
/**
 * Tests passed value to see if it is a valid e-mail address (supports subdomain nesting and new top-level domains).
 * 
 * @param str 	 The string to check. 
 * @return Returns a boolean. 
 * @author Jeff Guillaume (jguillaume@stoneage.com) 
 * @version 2, October 2, 2001 
 */
function IsEmail(str) {
        //supports new top level tlds
	if (REFindNoCase("^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name))$",str)) return TRUE;
	else return FALSE;

}
</CFSCRIPT>

<CFSCRIPT>
/**
 * Returns elements in list1 that are found in list2.
 * Based on ListCompare by Rob Brooks-Bilson (rbils@amkor.com)
 * 
 * @param List1 	 Full list of delimited values.  
 * @param List2 	 Delimited list of values you want to compare to List1.  
 * @param Delim1 	 Delimiter used for List1.  Default is the comma.  
 * @param Delim2 	 Delimiter used for List2.  Default is the comma.  
 * @param Delim3 	 Delimiter to use for the list returned by the function.  Default is the comma.  
 * @return Returns a delimited list of values. 
 * @author Michael Slatoff (michael@slatoff.com) 
 * @version 1, August 20, 2001 
 */
function ListInCommon(List1, List2)
{
  var TempList = "";
  var Delim1 = ",";
  var Delim2 = ",";
  var Delim3 = ",";
  var i = 0;
  // Handle optional arguments
  switch(ArrayLen(arguments)) {
    case 3:
      {
        Delim1 = Arguments[3];
        break;
      }
    case 4:
      {
        Delim1 = Arguments[3];
        Delim2 = Arguments[4];
        break;
      }
    case 5:
      {
        Delim1 = Arguments[3];
        Delim2 = Arguments[4];          
        Delim3 = Arguments[5];
        break;
      }        
  } 
   /* Loop through the second list, checking for the values from the first list.
    * Add any elements from the second list that are found in the first list to the
    * temporary list
    */  
  for (i=1; i LTE ListLen(List2, "#Delim2#"); i=i+1) {
    if (ListFindNoCase(List1, ListGetAt(List2, i, "#Delim2#"), "#Delim1#")){
     TempList = ListAppend(TempList, ListGetAt(List2, i, "#Delim2#"), "#Delim3#");
    }
  }
  Return TempList;
}
</CFSCRIPT>

<CFSCRIPT>
/**
 * Compares one list against another to find the elements in the first list that don't exist in the second list.
 * 
 * @param List1 	 Full list of delimited values. 
 * @param List2 	 Delimited list of values you want to compare to List1. 
 * @param Delim1 	 Delimiter used for List1.  Default is the comma. 
 * @param Delim2 	 Delimiter used for List2.  Default is the comma. 
 * @param Delim3 	 Delimiter to use for the list returned by the function.  Default is the comma. 
 * @return Returns a delimited list of values. 
 * @author Rob Brooks-Bilson (rbils@amkor.com) 
 * @version 1, August 27, 2001 
 */
function ListCompare(List1, List2)
{
  var TempList = "";
  var Delim1 = ",";
  var Delim2 = ",";
  var Delim3 = ",";
  var i = 0;
  // Handle optional arguments
  switch(ArrayLen(arguments)) {
    case 3:
      {
        Delim1 = Arguments[3];
        break;
      }
    case 4:
      {
        Delim1 = Arguments[3];
        Delim2 = Arguments[4];
        break;
      }
    case 5:
      {
        Delim1 = Arguments[3];
        Delim2 = Arguments[4];          
        Delim3 = Arguments[5];
        break;
      }        
  } 
   /* Loop through the full list, checking for the values from the partial list.
    * Add any elements from the full list not found in the partial list to the
    * temporary list
    */  
  for (i=1; i LTE ListLen(List1, "#Delim1#"); i=i+1) {
    if (ListFindNoCase(List2, ListGetAt(List1, i, "#Delim1#"), "#Delim2#") IS "No"){
     TempList = ListAppend(TempList, ListGetAt(List1, i, "#Delim1#"), "#Delim3#");
    }
  }
  Return TempList;
}
</CFSCRIPT>
<CFSCRIPT>
/**
 * Returns List from a given start and end position in a list.
 * 
 * @param list 	 Original List. 
 * @param from 	 Start position in the list. 
 * @param to 	 End position in the List. 
 * @return Returns a List. 
 * @author Sumit Verma (sverma@synthenet.com) 
 * @version 1, September 26, 2001
 */
function ListGetFrom(list,from,to,delim) {
	var newlist = list;
	var i = ListLen(newlist,delim);
	while (to LT i)
	{
		newlist = ListDeleteAt(newlist,i,delim);
		i = i - 1;
	}
	
	i = 1;
	while (i LT from)
	{
		newlist = ListDeleteAt(newlist,i,delim);
		i = i + 1;
	}
	return newlist;
}
</CFSCRIPT>

<cfscript>
/**
 * Takes a string and scrambles the characters.
 * 
 * @param str 	 String you want to jumble. 
 * @return Returns a string. 
 * @author Brad Roberts (broberts@nxs.net) 
 * @version 1, December 16, 2001 
 */
function jumble(str) {
  var tempstring=""; 
  var temp=0;
  while (len(str) gt 0) {
    temp = randrange(1, len(str));
    tempstring = tempstring & mid(str, temp, 1);
    str = removechars(str, temp, 1);
  }
  return tempstring;
}
</cfscript>
<cfscript>
/**
 * Reverses a list.
 * Modified by RCamden to use var scope
 * 
 * @param list 	 List to be modified. 
 * @param delimiter 	 Delimiter for the list. Defaults to a comma. 
 * @return Returns a list. 
 * @author Stephen Milligan (spike@spike.org.uk) 
 * @version 2, July 17, 2001 
 */
function ListReverse(list) {

	var newlist = "";
	var i = 0;
	var delims = "";
	var thisindex = "";
	var thisitem = "";
	
	var argc = ArrayLen(arguments);
	if (argc EQ 1) {
		ArrayAppend(arguments,',');
	}
	delims = arguments[2];
	while (i LT listlen(list,delims))
	{	
	thisindex = listlen(list,delims)-i;
	thisitem = listgetat(list,thisindex,delims);
    newlist = listappend(newlist,thisitem,delims);
    i = i +1;
	}
 return newlist;
}
</cfscript>
<cfscript>
/**
 * Replaces a huge amount of unnecessary whitespace from your HTML code.
 * 
 * @param sInput 	 HTML you wish to compress. (Required)
 * @return Returns a string. 
 * @author Jordan Clark (JordanClark@Telus.net) 
 * @version 1, November 19, 2002 
 */
function HtmlCompressFormat(sInput)
{
   var level = 2;
   if( arrayLen( arguments ) GTE 2 AND isNumeric(arguments[2]))
   {
      level = arguments[2];
   }
   // just take off the useless stuff
   sInput = trim(sInput);
   switch(level)
   {
      case "3":
      {
         //   extra compression can screw up a few little pieces of HTML, doh         
         sInput = reReplace( sInput, "[[:space:]]{2,}", " ", "all" );
         sInput = replace( sInput, "> <", "><", "all" );
         sInput = reReplace( sInput, "<!--[^>]+>", "", "all" );
         break;
      }
      case "2":
      {
         sInput = reReplace( sInput, "[[:space:]]{2,}", chr( 13 ), "all" );
         break;
      }
      case "1":
      {
         // only compresses after a line break
         sInput = reReplace( sInput, "(" & chr( 10 ) & "|" & chr( 13 ) & ")+[[:space:]]{2,}", chr( 13 ), "all" );
         break;
      }
   }
   return sInput;
}
</cfscript>
<cfscript>
/**
 * Basic padding function that allows user to decide which side of the submitted string that the characters should be added to (via L or R).
 * 
 * @param string 	 String to pad. (Required)
 * @param char 	 Character to use as pad. (Required)
 * @param number 	 Number of characters to pad. (Required)
 * @param charD 	 Direction to pad. Should be "L" (left) or "R" (right). Defaults to R. (Optional)
 * @return Returns a string. 
 * @author Ron Gambill (rgambill@hotmail.com) 
 * @version 1, May 9, 2003 
 */
function padstring(string,char,number) {
   // set up variables
   var strLen = len(string);
   var padLen = number - strLen;
   var returnValue = string;
   var charD = "R";

   if(arrayLen(arguments) gte 4) charD = arguments[4]; 
   if (strLen gte number) return string;
   
   if (charD eq "R") return string & RepeatString(char, padLen);
   else return RepeatString(char, padLen) & string;
}
</cfscript>
<cfscript>
/**
 * Case-sensitive function for removing duplicate entries in a list.
 * Based on dedupe by Raymond Camden
 * 
 * @param list 	 The list to be modified. 
 * @return Returns a list. 
 * @author Jeff Howden (jeff@members.evolt.org) 
 * @version 1, March 21, 2002 
 */
function ListDeleteDuplicates(list) {
  var i = 1;
  var delimiter = ',';
  var returnValue = '';
  if(ArrayLen(arguments) GTE 2)
    delimiter = arguments[2];
  list = ListToArray(list, delimiter);
  for(i = 1; i LTE ArrayLen(list); i = i + 1)
    if(NOT ListFind(returnValue, list[i], delimiter))
      returnValue = ListAppend(returnValue, list[i], delimiter);
  return returnValue;
}
</cfscript>
<cfscript>
/**
 * Returns specified number of random records.
 * 
 * @param theQuery 	 The query to return random records from. (Required)
 * @param NumberOfRows 	 The number of random records to return. (Required)
 * @return Returns a query. 
 * @author Shawn Seley and John King (shawnse@aol.com) 
 * @version 1, July 10, 2002 
 */
function QueryRandomRows(theQuery, NumberOfRows) {
	var FinalQuery      = QueryNew(theQuery.ColumnList);
	var x				= 0;
	var y               = 0;
	var i               = 0;
	var random_element  = 0;
	var random_row      = 0;
	var row_list        = "";

	if(NumberOfRows GT theQuery.recordcount) NumberOfRows = theQuery.recordcount;

	QueryAddRow(FinalQuery, NumberOfRows);

	// build a list of rows from which we will "scratch off" the randomly selected values in order to avoid repeats
	for (i=1; i LTE theQuery.RecordCount; i=i+1) row_list = row_list & i & ",";

	// Build the new query
	for(x=1; x LTE NumberOfRows; x=x+1){
		// pick a random_row from row_list and delete that element from row_list (to prevent duplicates)
		random_element  = RandRange(1, ListLen(row_list));          // pick a random list element
		random_row      = ListGetAt(row_list, random_element);      // get the corresponding query row number
		row_list        = ListDeleteAt(row_list, random_element);   // delete the used element from the list
		for(y=1; y LTE ListLen(theQuery.ColumnList); y=y+1) {
			QuerySetCell(FinalQuery, ListGetAt(theQuery.ColumnList, y), theQuery[ListGetAt(theQuery.ColumnList, y)][random_row],x);
		}
	}

	return FinalQuery;
}
</cfscript>


