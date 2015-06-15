
<xsl:stylesheet xmlns:msxsl="urn:schemas-microsoft-com:xslt" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xslNsExt="urn:xslExtensions" xmlns:xslNsODExt="urn:xslOnDemandExtensions" xmlns:ext="urn:ext">

  <xsl:template name="processPageHeader">
    <xsl:call-template name="buidPageHeader">
      <xsl:with-param name="pageTitle">
        <!--<xsl:value-of select="xslNsODExt:getDictRes('PASDashboardTitle')" />-->
        <xsl:value-of select="xslNsODExt:getDictRes('PASDashboardTitle_AIG')" />
      </xsl:with-param>
      <xsl:with-param name="pageInstruction">
        <xsl:text></xsl:text>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="buildMainAreaContent">

    <div id="pageInstruction">
      <!--<xsl:value-of select="xslNsExt:FormatString1(xslNsODExt:getDictRes('WelcomeToPASDashboard_Phrasing_AIG'), /page/state/user/fullName)" />-->
    </div>
    <xsl:call-template name="dashboardWidget"/>
  </xsl:template>
</xsl:stylesheet>
