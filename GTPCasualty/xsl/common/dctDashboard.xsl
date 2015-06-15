<?xml version="1.0"?>
<xsl:stylesheet xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xslNsExt="urn:xslExtensions" xmlns:xslNsODExt="urn:xslOnDemandExtensions" xmlns:ext="urn:ext">

	<xsl:template match="module[@id='mruQuote']" mode="content">
		<div id="{@id}" class="x-hidden">
			<div id="mruList">
				<xsl:choose>
					<xsl:when test="not(/page/content/policies/policy)">
						<div class="noItems">
							<xsl:value-of select="xslNsODExt:getDictRes('NoRecentlyAccessedItems_period')"/>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<table id="moduleDisplayTable">
              <tr class="tblItem">
                <B>
                  <td class="itemIcon" valign="top"></td>
                  <td>
                    <xsl:text>Account Name</xsl:text>
                  </td>
                  <td>
                    <xsl:text>Division</xsl:text>
                  </td>
                  <td>
                    <xsl:text>Underwriter Name</xsl:text>
                  </td>
                  <td>
                    <xsl:text>Transaction Type</xsl:text>
                  </td>
                    <!--<td>
                    <xsl:text>LOB</xsl:text>
                  </td>-->
                  <td>
                    <xsl:text>Workfile (GTP) Status</xsl:text>
                  </td>
                  <td>
                    <xsl:text>Effective Date</xsl:text>
                  </td>
                  <td>
                    <xsl:text>Expiration Date</xsl:text>
                  </td>
                  <td>
                    <xsl:text>Last Modified Date</xsl:text>
                  </td>
                  <td>
                    <xsl:text>Last Modified By</xsl:text>
                  </td> 
                  <td>
                    <xsl:text>AIG Workfile ID</xsl:text>
                  </td>
                </B>
              </tr>
              <xsl:for-each select="/page/content/policies/policy">
								<xsl:variable name="clientName">
									<xsl:value-of select="clientName"/>
								</xsl:variable>
								<xsl:variable name="splitClientName">
									<xsl:value-of select="xslNsExt:splitText($clientName,' ','..','17')"/>
								</xsl:variable>
								<xsl:variable name="isSplit">
									<xsl:choose>
										<xsl:when test="contains($splitClientName, '..')">1</xsl:when>
										<xsl:otherwise>0</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<xsl:if test="$isSplit = '1'">
									<script>Ext.QuickTips.init();</script>
								</xsl:if>
								<tr class="tblItem">
									<td class="itemIcon" valign="top"></td>
									<td>
										<!--<a>-->
											<xsl:attribute name="name">mruLoadQuote</xsl:attribute>
											<xsl:attribute name="class">mruLoadQuote</xsl:attribute>
											<xsl:attribute name="href">javascript:;</xsl:attribute>
											<xsl:attribute name="onclick">
												<xsl:text>DCT.Submit.gotoPageForClient('clientInfo','</xsl:text>
												<xsl:value-of select="clientName/@clientID"/>
												<xsl:text>');</xsl:text>
											</xsl:attribute>
											<xsl:if test="$isSplit = '1'">
												<xsl:attribute name="ext:qtitle">
													<xsl:value-of select="xslNsODExt:getDictRes('NameLengthExceedsDisplay_Full')"/>
													<xsl:text> </xsl:text>
												</xsl:attribute>
												<xsl:attribute name="data-title">
													<xsl:value-of select="xslNsODExt:getDictRes('NameLengthExceedsDisplay_Full')"/>
													<xsl:text> </xsl:text>
												</xsl:attribute>
												<xsl:attribute name="ext:qtip">
													<xsl:value-of select="$clientName"/>
												</xsl:attribute>
												<xsl:attribute name="data-tip">
													<xsl:value-of select="$clientName"/>
												</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="$splitClientName"/>
										<!--</a>-->
									</td>
                  <td>
                    <xsl:text>92- Lexington Casualty</xsl:text>
                  </td>
                  <td>
                    <xsl:text>Express Admin</xsl:text>
                  </td>
									<td>
                    <xsl:text>New</xsl:text>
									</td>
                  <td>
                    <xsl:value-of select="status"/>
                  </td>
                  <td>
                    <xsl:value-of select="EffectiveDate"/>
                  </td>
                  <td>
                    <xsl:value-of select="ExpirationDate"/>
                  </td>
                  <td>
                    <xsl:value-of select="lastModified"/>
                  </td>
                  <td>
                    <xsl:text>Express Admin</xsl:text>
                  </td>                                 
                  <td>
										<a>
											<xsl:attribute name="name">mruLoadQuote</xsl:attribute>
											<xsl:attribute name="class">mruLoadQuote</xsl:attribute>
											<xsl:attribute name="href">javascript:;</xsl:attribute>
											<xsl:attribute name="onclick">
												<xsl:text>DCT.Submit.actOnQuote('load','</xsl:text>
												<xsl:value-of select="@policyID"/>
												<xsl:text>','</xsl:text>
												<xsl:value-of select="lob"/>
												<xsl:text>');</xsl:text>
											</xsl:attribute>
											<xsl:choose>
												<xsl:when test="string-length(policyNumber) = 0">
													<xsl:value-of select="xslNsODExt:getDictRes('Quote')"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="policyNumber"/>
												</xsl:otherwise>
											</xsl:choose>
										</a>
									</td>
								</tr>
							</xsl:for-each>
						</table>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>