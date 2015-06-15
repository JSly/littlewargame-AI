
<xsl:stylesheet xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xslNsExt="urn:xslExtensions" xmlns:xslNsODExt="urn:xslOnDemandExtensions" xmlns:ext="urn:ext">

	<xsl:template name="buildQuickSearch">
		<!--<xsl:choose>
			<xsl:when test="/page/content/portals/portal[@active = '1']/@portalType = 'pas'">
				<div id="quickSearch">
					<div id="quickSearchLabel">
						<xsl:value-of select="xslNsODExt:getDictRes('QuickSearch')"/>
						<xsl:text> </xsl:text>
					</div>
					<xsl:call-template name="buildSystemControl">
						<xsl:with-param name="id">quickSearchModeId</xsl:with-param>
						<xsl:with-param name="name">quickSearchMode</xsl:with-param>
						<xsl:with-param name="type">select</xsl:with-param>
						<xsl:with-param name="class">autoFocusOff</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="/page/content/search/@quickSearchMode"/>
						</xsl:with-param>				
						<xsl:with-param name="optionlist">
							<option value="policy">
								<xsl:value-of select="xslNsODExt:getDictRes('PolicyQuoteNumber')"/>
							</option>
							<option value="clientname">
								<xsl:value-of select="xslNsODExt:getDictRes('ClientName')"/>
							</option>
							<option value="phone">
								<xsl:value-of select="xslNsODExt:getDictRes('PhoneNumber')"/>
							</option>
						</xsl:with-param>
					</xsl:call-template>
					<div id="searchIsLabel">
						<xsl:text> </xsl:text>
						<xsl:value-of select="xslNsODExt:getDictRes('Is')"/>
						<xsl:text> </xsl:text>
					</div>
					<xsl:call-template name="buildSystemControl">
						<xsl:with-param name="id">quickSearchTextId</xsl:with-param>
						<xsl:with-param name="name">quickSearchText</xsl:with-param>
						<xsl:with-param name="controlClass">policyQuickSearchTextField</xsl:with-param>
						<xsl:with-param name="class">autoFocusOff</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="/page/content/search/keys/key/@value"/>
						</xsl:with-param>
					</xsl:call-template>
					<a href="javascript:;" onclick="DCT.Submit.setActiveParent('search');DCT.Submit.runQuickSearch();" name="name_quickSearch" id="id_quickSearch">
						<img src="{$imageDir}icons/magnifier.png" alt="{xslNsODExt:getDictRes('RunQuickSearch')}"/>
					</a>
				</div>
			</xsl:when>
			<xsl:when test="/page/content/portals/portal[@active = '1']/@name = 'Billing' and /page/content/@page!= 'BillHome'">
				<div id="quickSearch">
					<div id="searchLabel">
						<xsl:value-of select="xslNsODExt:getDictRes('SearchBy_colon')"/>
						<xsl:text> </xsl:text>
					</div>
					<xsl:call-template name="buildSystemControl">
						<xsl:with-param name="id">quickSearchModeId</xsl:with-param>
						<xsl:with-param name="name">quickSearchMode</xsl:with-param>
						<xsl:with-param name="type">select</xsl:with-param>
						<xsl:with-param name="optionlist">
							<option value="account">
								<xsl:value-of select="xslNsODExt:getDictRes('AccountNumber')"/>
							</option>
							<option value="policy">
								<xsl:value-of select="xslNsODExt:getDictRes('PolicyNumber')"/>
							</option>
							<option value="party">
								<xsl:value-of select="xslNsODExt:getDictRes('PartyInformation')"/>
							</option>
              <option value="invoice">
                <xsl:value-of select="xslNsODExt:getDictRes('InvoiceReference')"/>
              </option>
						</xsl:with-param>
						<xsl:with-param name="controlClass">quicksearchComboField</xsl:with-param>
					</xsl:call-template>
					<div id="searchUsingLabel">
						<xsl:text> </xsl:text>
						<xsl:value-of select="xslNsODExt:getDictRes('Using')"/>
						<xsl:text> </xsl:text>
					</div>
					<xsl:call-template name="buildSystemControl">
						<xsl:with-param name="id">quickSearchTextId</xsl:with-param>
						<xsl:with-param name="name">quickSearchText</xsl:with-param>
						<xsl:with-param name="controlClass">billingQuickSearchTextField</xsl:with-param>
					</xsl:call-template>
					<a href="javascript:;" onclick="DCT.Submit.billingQuickSearch(Ext.getCmp('quickSearchTextId').getValue(), Ext.getCmp('quickSearchModeId').getValue(), 'accountSearch');" name="name_quickSearch" id="id_quickSearch">
						<img src="{$imageDir}icons/magnifier.png" alt="{xslNsODExt:getDictRes('RunQuickSearch')}"/>
					</a>
				</div>
			</xsl:when>
		</xsl:choose>-->
	</xsl:template>
	<xsl:template name="buildProductNavigation">
		<!--<xsl:if test="/page/content/portals/portal[@active = '1']/@portalType = 'pas' or /page/content/portals/portal[@active = '1']/@name = 'Billing' or /page/content/portals/portal[@active = '1']/@name = 'Party'">
			<div id="productNavigationDiv">
				<xsl:for-each select="/page/content/portals/portal[@portalType = 'pas'][1]">
					<a>
						<xsl:attribute name="name">
							<xsl:value-of select="@name"/>
						</xsl:attribute>
						<xsl:attribute name="id">
							<xsl:value-of select="@name"/>
						</xsl:attribute>
						<xsl:attribute name="class">pasLink</xsl:attribute>
						<xsl:attribute name="href">javascript:;</xsl:attribute>
						<xsl:attribute name="onclick">
							<xsl:text>DCT.Submit.setPortal('</xsl:text>
							<xsl:value-of select="@name"/>
							<xsl:text>','</xsl:text>
							<xsl:value-of select="xslNsExt:replaceText(@xsltDir,'\','\\')"/>
							<xsl:text>');</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="xslNsODExt:getDictRes(@caption)"/>
						<xsl:text></xsl:text>
					</a>
				</xsl:for-each>
                <xsl:for-each select="/page/content/portals/portal[@name = 'Billing'][1]">
                    <a>
                      <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                      </xsl:attribute>
                      <xsl:attribute name="id">
                        <xsl:value-of select="@name"/>
                      </xsl:attribute>
                      <xsl:attribute name="href">javascript:;</xsl:attribute>
                      <xsl:attribute name="onclick">
                        <xsl:text>DCT.Submit.setPortal('</xsl:text>
                        <xsl:value-of select="@name"/>
                        <xsl:text>','</xsl:text>
                        <xsl:value-of select="xslNsExt:replaceText(@xsltDir,'\','\\')"/>
                        <xsl:text>');</xsl:text>
                      </xsl:attribute>
                      <xsl:value-of select="xslNsODExt:getDictRes(@caption)"/>
                    </a>
                </xsl:for-each>
                <xsl:for-each select="/page/content/portals/portal[@name = 'Party'][1]">
                    <a>
                      <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                      </xsl:attribute>
                      <xsl:attribute name="id">
                        <xsl:value-of select="@name"/>
                      </xsl:attribute>
                      <xsl:attribute name="href">javascript:;</xsl:attribute>
                      <xsl:attribute name="onclick">
                        <xsl:text>DCT.Submit.setPortal('</xsl:text>
                        <xsl:value-of select="@name"/>
                        <xsl:text>','</xsl:text>
                        <xsl:value-of select="xslNsExt:replaceText(@xsltDir,'\','\\')"/>
                        <xsl:text>');</xsl:text>
                      </xsl:attribute>
                      <xsl:value-of select="xslNsODExt:getDictRes(@caption)"/>
                    </a>
                </xsl:for-each>
				<xsl:for-each select="/page/actions/action[@location='product']">
					<xsl:variable name="href">
						<xsl:choose>
							<xsl:when test="@command != 'submitAction'">
								<xsl:choose>
									<xsl:when test="starts-with(@command, 'DCT.Submit.')"></xsl:when>
									<xsl:otherwise>
										<xsl:text>DCT.Submit.</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="@command"/>
								<xsl:text>('</xsl:text>
								<xsl:value-of select="@page"/>
								<xsl:text>'</xsl:text>
								<xsl:if test="@post">
									<xsl:text>,'</xsl:text>
									<xsl:value-of select="@post"/>
									<xsl:text>'</xsl:text>
								</xsl:if>
								<xsl:text>);</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="starts-with(@command, 'DCT.Submit.')"></xsl:when>
									<xsl:otherwise>
										<xsl:text>DCT.Submit.</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:value-of select="@command"/>
								<xsl:text>('</xsl:text>
								<xsl:value-of select="@post"/>
								<xsl:text>');</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<a href="javascript:;">
						<xsl:attribute name="name">
							<xsl:text>name_</xsl:text>
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<xsl:attribute name="id">
							<xsl:text>id_</xsl:text>
							<xsl:value-of select="@id"/>
						</xsl:attribute>
						<xsl:attribute name="onclick">
							<xsl:value-of select="$href"/>
						</xsl:attribute>
						<xsl:value-of select="xslNsODExt:getDictRes(@caption)"/>
					</a>
				</xsl:for-each>
			</div>
		</xsl:if>-->
	</xsl:template>
	
</xsl:stylesheet>