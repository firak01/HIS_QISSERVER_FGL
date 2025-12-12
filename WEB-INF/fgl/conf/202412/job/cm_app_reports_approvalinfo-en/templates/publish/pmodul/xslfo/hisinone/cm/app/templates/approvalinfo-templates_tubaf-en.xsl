<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:date="http://exslt.org/dates-and-times" 
	version="1.0">
	
	<xsl:variable name="oberflaechenschluessel">false</xsl:variable>

	<xsl:template name="approvaldoc.content.Kopfbereich">
		<fo:block border-style="{$template-border}" margin-top="{$spaceBetweenParagraphs}">
			<xsl:if test="$oberflaechenschluessel='true'">
				<xsl:call-template name="renderTemplateName">
					<xsl:with-param name="templateName">cm.app.reports.approvaldoc.content.Kopfbereich</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<fo:block>
				<xsl:apply-templates select="uitext/cm.app.reports.approvaldoc.content.Kopfbereich"/>
			</fo:block>
		</fo:block>
	</xsl:template>	

	<!-- FGL: 20251210 Neuer Abschnitt für den Hinweis -->
	<xsl:template name="approvaldoc.content.HinweisfeldMGEXGRE">
		<fo:block border-style="{$template-border}" margin-top="{$spaceBetweenParagraphs}">
			<xsl:if test="$oberflaechenschluessel='true'">
				<xsl:call-template name="renderTemplateName">
					<xsl:with-param name="templateName">cm.app.reports.approvalinfo.content.Hinweisfeld</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<fo:block>
				<xsl:apply-templates select="uitext/cm.app.reports.approvalinfo.content.Hinweisfeld"/>
			</fo:block>
		</fo:block>
	</xsl:template>	
</xsl:stylesheet>