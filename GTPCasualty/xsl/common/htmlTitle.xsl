
<xsl:stylesheet xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xslNsExt="urn:xslExtensions" xmlns:xslNsODExt="urn:xslOnDemandExtensions" xmlns:ext="urn:ext">
    <!--*************************************************************************************************************
		Build title for html
		************************************************************************************************************* -->
	<xsl:template name="buildHtmlTitle">
		<title>
			<xsl:value-of select="xslNsODExt:getDictRes('AccentureDuckCreek_AIG')" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="/page/content/portals/portal[@active = '1']/@caption"/>
		</title>
	</xsl:template>
</xsl:stylesheet>