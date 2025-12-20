<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:date="http://exslt.org/dates-and-times" 
	version="1.0">
	
	<xsl:variable name="debug">
		<xsl:choose>
			<xsl:when test="//globalConfigParams/operationModeCust = 'true'">
				<xsl:value-of select="//globalConfigParams/cm.app.common.reports.debug"/>
			</xsl:when>
			<xsl:otherwise>
				false
			</xsl:otherwise>
		</xsl:choose>
    </xsl:variable>
	
	<xsl:variable name="pageSequenceMaster">
		<xsl:choose>
			<xsl:when test="normalize-space(substring-before(//reporttype,'_')) = 'CONTROLSHEET'">A4-controlsheet</xsl:when>
			<xsl:otherwise>A4</xsl:otherwise>
		</xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="language">
    	<xsl:value-of select="//foreignLanguage/k_language.uniquename"/>
    </xsl:variable>
    
    
    <xsl:variable name="template-border">
    	<xsl:if test="$debug = 'true'">
    		solid
    	</xsl:if>
    	<xsl:if test="$debug != 'true'">
    		none
    	</xsl:if>
    </xsl:variable>
	
	<xsl:template name="callTemplates">
		<xsl:param name="line" />
		<xsl:if test="$line != ''">
			<xsl:variable name="param"
				select="normalize-space(substring-before($line,','))" />
			<xsl:apply-templates
				select="document('')/*/xsl:template[@name=$param]"/>
			
			<xsl:variable name="rest"
				select="normalize-space(substring-after($line,','))" />
			<xsl:call-template name="callTemplates">
				<xsl:with-param name="line" select="$rest" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="renderTemplateName">
		<xsl:param name="templateName" />
		<xsl:if test="$templateName != ''">
			<xsl:if test="$debug='true'">
				<fo:block font-size="{$schrift6}">
					<xsl:variable name="link" select="concat(//contextUrl, '/pages/portal/search.xhtml?_flowId=sucheUitext-flow&amp;key=', $templateName)"/>
					<fo:basic-link color="blue" text-decoration="underline">
						<xsl:attribute name="external-destination">url('<xsl:value-of select="$link"/>')</xsl:attribute>
						<xsl:value-of select="$templateName"/>
					</fo:basic-link>
				</fo:block>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="common.content.salutation">
		<fo:block id="common.content.salutation" border-style="{$template-border}"  margin-top="{$spaceBetweenParagraphs}" text-align="start" font-size="{$schrift10}">
			<xsl:call-template name="renderTemplateName">
				<xsl:with-param name="templateName">cm.app.reports.common.content.salutation</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="uitext/cm.app.reports.common.content.salutation"/>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="STATIC.common.bookmarks">
		<fo:bookmark internal-destination="common.header.university">
			<fo:bookmark-title>
				<xsl:value-of select="uitext/cm.app.reports.common.header.university.bookmarktitle"/>
			</fo:bookmark-title>
		</fo:bookmark>
		<fo:bookmark internal-destination="common.header.universityAddress">
			<fo:bookmark-title>
				<xsl:value-of select="uitext/cm.app.reports.common.header.universityAddress.bookmarktitle"/>
			</fo:bookmark-title>
		</fo:bookmark>
		<fo:bookmark internal-destination="common.header.recipient">
			<fo:bookmark-title>
				<xsl:value-of select="uitext/cm.app.reports.common.header.recipient.bookmarktitle"/>
			</fo:bookmark-title>
		</fo:bookmark>
		<fo:bookmark internal-destination="STATIC.common.header.dateOfDoc">
			<fo:bookmark-title>
				<xsl:value-of select="uitext/cm.app.reports.common.header.dateOfDoc.bookmarktitle"/>
			</fo:bookmark-title>
		</fo:bookmark>
		<fo:bookmark internal-destination="common.header.universityContact">
			<fo:bookmark-title>
				<xsl:value-of select="uitext/cm.app.reports.common.header.universityContact.bookmarktitle"/>
			</fo:bookmark-title>
		</fo:bookmark>
		<fo:bookmark internal-destination="common.header.applicantnumber">
			<fo:bookmark-title>
				<xsl:value-of select="uitext/cm.app.reports.common.header.applicantnumber.bookmarktitle"/>
			</fo:bookmark-title>
		</fo:bookmark>
	</xsl:template>
	
	<xsl:template name="STATIC.common.addressHeader">
		<fo:block-container>
				<fo:block-container position="absolute" top="0" left="0" width="49%">
					<xsl:call-template name="common.header.recipient"/>
				</fo:block-container>
				<fo:block-container position="absolute" top="0" left="50%">
					<xsl:call-template name="common.header.universityAddress"/>
					<xsl:call-template name="common.header.universityContact"/>
					<xsl:call-template name="STATIC.common.header.dateOfDoc"/>
				</fo:block-container>
		</fo:block-container>
	</xsl:template>
	
	<xsl:template name="common.header.university">
		<fo:block id="common.header.university" border-style="{$template-border}" text-align="right">
			<xsl:call-template name="renderTemplateName">
				<xsl:with-param name="templateName">cm.app.reports.common.header.university</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="uitext/cm.app.reports.common.header.university"/>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="common.header.universityAddress">
		<fo:block-container margin-bottom="5mm">
			<fo:block id="common.header.universityAddress" border-style="{$template-border}">
				<xsl:call-template name="renderTemplateName">
					<xsl:with-param name="templateName">cm.app.reports.common.header.universityAddress</xsl:with-param>
				</xsl:call-template>
				<xsl:apply-templates select="uitext/cm.app.reports.common.header.universityAddress"/>
			</fo:block>
		</fo:block-container>
	</xsl:template>
	
	<xsl:template name="common.header.recipient">
		<fo:block-container height="27.3mm">
			<fo:block id="common.header.recipient" border-style="{$template-border}" vertical-align="bottom">
				<xsl:call-template name="renderTemplateName">
					<xsl:with-param name="templateName">cm.app.reports.common.header.recipient</xsl:with-param>
				</xsl:call-template>
				<xsl:apply-templates select="uitext/cm.app.reports.common.header.recipient"/>
			</fo:block>
		</fo:block-container>
	</xsl:template>
	
	<xsl:template name="common.header.universityContact">
		<fo:block id="common.header.universityContact" border-style="{$template-border}" margin-bottom="5mm">
			<xsl:call-template name="renderTemplateName">
				<xsl:with-param name="templateName">cm.app.reports.common.header.universityContact</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="uitext/cm.app.reports.common.header.universityContact"/>
		</fo:block>
	</xsl:template>
	
	<!--Bewerbernummer -->
	<xsl:template name="common.header.applicantnumber">
		<fo:block id="common.header.applicantnumber" border-style="{$template-border}" margin-bottom="2em" margin-top="0.5em">
			<xsl:call-template name="renderTemplateName">
				<xsl:with-param name="templateName">cm.app.reports.common.header.applicantnumber</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="uitext/cm.app.reports.common.header.applicantnumber"/>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="STATIC.common.header.dateOfDoc">
		<fo:block id="STATIC.common.header.dateOfDoc" border-style="{$template-border}"  text-align="right" margin-bottom="5mm">
			<xsl:if test="$debug='true'">
				<fo:block font-size="{$schrift6}">
					<xsl:text>STATIC.common.header.dateOfDoc</xsl:text>
				</fo:block>
			</xsl:if>			
			<!--Datum-->
			<fo:inline font-size="{$schrift8}">
				<xsl:value-of select="Hochschuldaten/Adresse/city" />
				<xsl:text>, </xsl:text>
				<date:date-format lang="{$language}" />
				<xsl:choose>
					<xsl:when test="$language='en'">
						<xsl:value-of select="date:format-date($now,'MM/dd/yyyy')" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="date:format-date($now,'dd.MM.yyyy')" />
					</xsl:otherwise>
				</xsl:choose>
			</fo:inline>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="STATIC.common.dumpPubStore">
		<xsl:if test="$debug='true'">
			<fo:block id="STATIC.common.dumpPubStore" border-style="solid" page-break-before="always" font-size="{$schrift6}">
				<xsl:text>STATIC.common.dumpPubStore</xsl:text>
				<xsl:apply-templates select="pubStore"/>
			</fo:block>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="STATIC.common.content.applicantSignature">
		<fo:block id="STATIC.common.content.applicantSignature" border-style="{$template-border}" margin-top="{$spaceBetweenParagraphs}">
			<xsl:if test="$debug='true'">
				<fo:block font-size="{$schrift6}">
					<xsl:text>STATIC.common.content.applicantSignature</xsl:text>
				</fo:block>
			</xsl:if>
			<fo:table table-layout="auto">
				<fo:table-column column-width="45%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="45%" />
				<fo:table-body>
					<fo:table-row >
						<fo:table-cell padding-top="2.0pt">
							<fo:block font-size="{$schrift8}" font-weight="bold" border-top-style="solid" border-top-width="0.6pt">
								<fo:inline padding-left="5pt">Ort, Datum</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell padding-top="2.0pt" >
							<fo:block />
						</fo:table-cell>
						<fo:table-cell padding-top="2.0pt">
							<fo:block font-size="{$schrift8}" font-weight="bold" border-top-style="solid" border-top-width="0.6pt">
								<fo:inline padding-left="5pt">Unterschrift</fo:inline>	
							</fo:block>
						</fo:table-cell>
					</fo:table-row >
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="STATIC.common.content.partingLine">
		<fo:block id="STATIC.common.content.partingLine" border-style="{$template-border}" margin-top="{$spaceBetweenParagraphs}">
			<xsl:if test="$debug='true'">
				<fo:block font-size="{$schrift6}">
					<xsl:text>STATIC.common.partingLine</xsl:text>
				</fo:block>
				<fo:leader leader-pattern="dots" rule-thickness="0.5pt" leader-length="100%" color="black" />
			</xsl:if>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="STATIC.common.content.statusRemark">
		<xsl:if test="string-length(normalize-space(requestSubject/requestsubject.status_remark)) != 0 or count(requestSubject/predefinedStatusRemarks) > 0">
			<fo:block id="STATIC.common.content.statusRemark" border-style="{$template-border}" margin-top="{$spaceBetweenParagraphs}">
				<xsl:if test="$debug='true'">
					<fo:block font-size="{$schrift6}">
						<xsl:text>STATIC.common.content.statusRemark</xsl:text>
					</fo:block>
				</xsl:if>
				<fo:list-block>
					<xsl:for-each select="requestSubject/predefinedStatusRemarks">
						<fo:list-item>
							<fo:list-item-label end-indent="label-end()">
								<fo:block>-</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="15pt">
								<fo:block linefeed-treatment="preserve">
									<xsl:value-of select="k_predefined_status_remark.longtext"/>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:for-each>
					<xsl:if test="string-length(normalize-space(requestSubject/requestsubject.status_remark)) != 0">
						<!-- freier Grund -->
						<fo:list-item>
							<fo:list-item-label end-indent="label-end()">
								<fo:block>-</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="15pt">
								<fo:block linefeed-treatment="preserve">
									<xsl:value-of select="requestSubject/requestsubject.status_remark" />
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</xsl:if>
				</fo:list-block>
			</fo:block>
		</xsl:if>
	</xsl:template>
	
	<!--Verifikationsnummer -->
	<xsl:template name="common.content.verificationNumberUrl">
		<fo:block id="common.content.verificationNumberUrl" border-style="{$template-border}" margin-top="{$spaceBetweenParagraphs}">
			<xsl:call-template name="renderTemplateName">
				<xsl:with-param name="templateName">cm.app.reports.common.content.verificationNumberUrl</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="uitext/cm.app.reports.common.content.verificationNumberUrl"/>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="common.content.verificationNumber">
		<fo:block id="common.content.verificationNumber" border-style="{$template-border}" margin-top="{$spaceBetweenParagraphs}">
			<xsl:call-template name="renderTemplateName">
				<xsl:with-param name="templateName">cm.app.reports.common.content.verificationNumber</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="uitext/cm.app.reports.common.content.verificationNumber"/><xsl:text> </xsl:text><xsl:value-of select="verificationNumber" />
		</fo:block>
	</xsl:template>

</xsl:stylesheet>