
<xsl:stylesheet xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xslNsODExt="urn:xslOnDemandExtensions" xmlns:ext="urn:ext">
	<xsl:template name="buildPageContent">
    <!-- added wording to login page -->
    <div id="logoWording" class="blueText">Global Technical Pricing</div>
    <div id="Logon">
      <!-- added wording to login page -->
      <div id="signInWording" class="blueText">System Login</div>
      <div id="logonFields">
				<div class="logonTextFieldGroup">
					<label id="username_captionText" for="username">
						<xsl:value-of select="xslNsODExt:getDictRes('Username_colon')"/>
					</label>
					<xsl:call-template name="buildSystemControl">
						<xsl:with-param name="id">username</xsl:with-param>
						<xsl:with-param name="name">_username</xsl:with-param>
						<xsl:with-param name="size">15</xsl:with-param>
						<xsl:with-param name="maxlength">50</xsl:with-param>
						<xsl:with-param name="controlClass">loginTextField</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="/page/state/user/name"/>
						</xsl:with-param>
						<xsl:with-param name="extraConfigItems">
							<xsl:call-template name="addConfigProperty">
								<xsl:with-param name="name">dctSecure</xsl:with-param>
								<xsl:with-param name="type">boolean</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:choose>
										<xsl:when test="/page/state/@secure='1'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</div>
				<div class="logonTextFieldGroup">
					<label id="password_captionText" for="password">
						<xsl:value-of select="xslNsODExt:getDictRes('Password_colon')"/>
					</label>
					<xsl:call-template name="buildSystemControl">
						<xsl:with-param name="id">password</xsl:with-param>
						<xsl:with-param name="name">_password</xsl:with-param>
						<xsl:with-param name="size">15</xsl:with-param>
						<xsl:with-param name="maxlength">50</xsl:with-param>
						<xsl:with-param name="controlClass">loginTextField</xsl:with-param>
						<xsl:with-param name="extraConfigItems">
							<xsl:call-template name="addConfigProperty">
								<xsl:with-param name="name">dctSecure</xsl:with-param>
								<xsl:with-param name="type">boolean</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:choose>
										<xsl:when test="/page/state/@secure='1'">
											<xsl:text>true</xsl:text>
										</xsl:when>
										<xsl:otherwise>
											<xsl:text>false</xsl:text>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
						<xsl:with-param name="type">password</xsl:with-param>
					</xsl:call-template>
				</div>
				<div id="rememberGroup">
					<xsl:call-template name="buildSystemControl">
						<xsl:with-param name="type">checkbox</xsl:with-param>
						<xsl:with-param name="id">rememberCheckBoxGroup</xsl:with-param>
						<xsl:with-param name="class">boldText</xsl:with-param>
						<xsl:with-param name="checkbox">
							<xsl:call-template name="buildCheckBoxObject">
								<xsl:with-param name="elementClass">boldText</xsl:with-param>
								<xsl:with-param name="fieldID">remember</xsl:with-param>
								<xsl:with-param name="name">_remember</xsl:with-param>
								<xsl:with-param name="inputValue">yes</xsl:with-param>
								<xsl:with-param name="dctClassName">DCT.LoginRememberCheckBox</xsl:with-param>
								<xsl:with-param name="boxLabel">
									<xsl:value-of select="xslNsODExt:getDictRes('RememberMe')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</div>
					<xsl:variable name="href">
						<xsl:choose>
							<xsl:when test="/page/state/@secure='1'">
								<xsl:text>DCT.Submit.submitPageAction('welcome','login');</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>DCT.Submit.submitAction('login');</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:call-template name="makeButton">
						<xsl:with-param name="name">home</xsl:with-param>
						<xsl:with-param name="id">home</xsl:with-param>
						<xsl:with-param name="onclick" select="$href"/>
						<xsl:with-param name="caption">
							<xsl:value-of select="xslNsODExt:getDictRes('Login')"/>
						</xsl:with-param>
					</xsl:call-template>
		</div>
		</div>
	</xsl:template>

</xsl:stylesheet>