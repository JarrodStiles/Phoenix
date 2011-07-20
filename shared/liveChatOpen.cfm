
<cfset liveChatOpen = false />
<cftry>
    <cfhttp url="http://image.providesupport.com/online-presense/pongosoftware" method="get" result="chatOpen" timeout="20" />
    <cfset chatOpen = ListToArray(chatOpen.fileContent,chr(13)) />
    <!--- loop from end since this is usually the last item --->
    <cfloop from="#arrayLen(chatOpen)#" to="1" step="-1" index="i">
        <cfif listFirst(chatOpen[i],":") contains "Customer Support" and listLast(chatOpen[i],":") contains "ONLINE">
            <cfset liveChatOpen = true />
            <cfbreak />
        </cfif>
    </cfloop>
    <cfcatch type="any">
        <!--- do nothing...leave chat/call closed --->
    </cfcatch>
</cftry>