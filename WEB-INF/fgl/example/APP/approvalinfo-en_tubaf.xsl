<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:date="http://exslt.org/dates-and-times" 
	version="2.0">

	<!-- FGL: 20240205 -->
	<!-- Diese Variablen stammen aus der settings.txt (Spezialmoduldatei) unter  WEB-INF\templates\publish\pmodul\xslfo\hisinone\templates\settings_tubaf.txt-->
	<!-- An einer zentralen Stelle WEB-INF\templates\publish\pmodul\xslfo\hisinone\cm\app\templates\layout_tubaf_2.xsl verwalten und in Variablen umwandeln -->
	
<!-- 	<xsl:variable name="kopfLogoAbstandObenSVG">$settings.kopfLogoAbstandObenSVG</xsl:variable> -->
<!-- 	 	<xsl:variable name="schrift10">$settings.schrift10</xsl:variable> -->
<!-- 	 	<xsl:variable name="schrift9">$settings.schrift9</xsl:variable> -->
<!-- 	 	<xsl:variable name="schrift8">$settings.schrift8</xsl:variable> -->
<!-- 		<xsl:variable name="kopfLogoAbstandObenSVGtest">$settings.kopfLogoAbstandObenSVGtest</xsl:variable> -->
<!-- 		<xsl:variable name="fontFamily">$settings.fontFamily</xsl:variable> -->
	
	

	<!-- Layout -->
	<xsl:import href="[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/format_tubaf.xsl"/>
    <!-- Allgemeine Templates -->
    <xsl:import href="[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/common-templates.xsl"/>
    <!-- Vorlage mit dem Kopf- und Fußbereich -->
    <!-- FGL: Das layout mit den settings Einstellungen über parse einbinden -->
    <xsl:import href="[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/layout_tubaf_2-en.xsl"/> 
    <xsl:import href="[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/header_tubaf_2-en.xsl"/>
 
    
    <!-- Templates für Info Zulassung -->
    <xsl:import href="[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/approvalinfo-templates_tubaf-en.xsl"/>
    

	
    
    <xsl:template name="documentContent">     	         
    	<!-- Debugging-Infos - alles andere als "true" entfernt Debug-Infos -->
    	<xsl:variable name="debug">false</xsl:variable>
    	<fo:block text-align="justify" border-style="{$template-border}">	
			
			<!-- Sachbearbeiterdaten -->
			<xsl:variable name = "sachbearbeiter_nn"><xsl:value-of select="//outputrequest/anfragender_fn" /></xsl:variable>
			<xsl:variable name = "sachbearbeiter_vn"><xsl:value-of select="//outputrequest/anfragender_vn" /></xsl:variable>

			<!-- FGL: 20240131 Fachsemester - zu waehlendes -->
			<xsl:variable name="FSadmitted">
				<xsl:value-of select="//FSadmitted" />
			</xsl:variable>
			<xsl:variable name="FSused">
				<xsl:choose>
					<xsl:when test="string($FSadmitted)!=''">
						<xsl:value-of select="//FSadmitted" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="//FSrequested" />
					</xsl:otherwise>			
				</xsl:choose>
			</xsl:variable>

			<!-- DEBUGGING -->
			<xsl:if test="$debug='true'">
				<fo:block>DEBUGGING Bewerbungsbestandteile</fo:block>
				
				<fo:block>DEBUGGING VARIABLEN FGL: </fo:block>
				<fo:block>A) Direkter Zugriff auf Variable mit Settings</fo:block>
				<fo:block>settingstest => <xsl:value-of select = "$settings.settingstest" /></fo:block>
				<fo:block>fontFamily => <xsl:value-of select = "$settings.fontFamily" /></fo:block>
				<fo:block>kopfLogoAbstandObenSVG  => <xsl:value-of select = "$settings.kopfLogoAbstandObenSVG" /></fo:block>				
				<fo:block>kopfLogoAbstandLinks  => <xsl:value-of select = "$settings.kopfLogoAbstandLinks" /></fo:block>
				<fo:block>B) Zugriff auf Variable ohne Angabe von 'Dollar'settings</fo:block>
				<fo:block>settingstest => <xsl:value-of select = "$settingstest" /></fo:block>
				<fo:block>fontFamily => <xsl:value-of select = "$fontFamily" /></fo:block>
				<fo:block>kopfLogoAbstandObenSVG  => <xsl:value-of select = "$kopfLogoAbstandObenSVG" /></fo:block>
				<fo:block>kopfLogoAbstandLinks  => <xsl:value-of select = "$kopfLogoAbstandLinks" /></fo:block>				
								
				
												
			</xsl:if>

			<!-- ENDE DEBUGGING -->

			
			<fo:table font-size="{$schrift10}" space-before="0.3cm">
				<fo:table-column column-width="5.0cm" />
				<fo:table-column column-width="9.0cm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold">Application to study for:</fo:block> 
						</fo:table-cell>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold"><xsl:value-of select="concat(//Antrag/semesterart, ' ' ,//Antrag/term_year)" /></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold">Course of study:</fo:block> 
						</fo:table-cell>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold"><xsl:value-of select="//stud_gang_txt" /></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold">Qualification:</fo:block> 
						</fo:table-cell>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold"><xsl:value-of select="//abschluss/text" /></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<!--FGL 20240102 - Fachsemester ergaenzt, jetzt auch das eingestufte Fachsemster -->
					<fo:table-row>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold">Course Semester:</fo:block> 
						</fo:table-cell>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold"><xsl:value-of select="$FSused" /></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold">Applicant no.:</fo:block>  
						</fo:table-cell>
						<fo:table-cell text-align="left">
							<fo:block font-weight="bold"><xsl:value-of select="//Antrag/Bewerber/BewerberNr" /></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>

			<fo:block space-before="0.3cm" font-size="{$schrift8}">(Please always quote in correspondence.)</fo:block>

			<!--<fo:block>
				<xsl:call-template name="approvaldoc.content.Kopfbereich"/>
			</fo:block>-->

			<fo:table space-before="1.3cm">
				<fo:table-column column-width="15.5cm" />
				<fo:table-column column-width="2.0cm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell text-align="center">
							<fo:block font-weight="bold" font-size="{$schrift14}" font-family="{$fontFamily}">
								INFORMATION FOR ADMISSION
							</fo:block>							
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			
			
			<fo:block>
				<xsl:call-template name="approvaldoc.content.HinweisfeldMGEXGRE"/>
			</fo:block>
			

			<!-- DEBUG: DUMP ALLER VARIABLEN -->
			<xsl:if test="$debug='true'">
				<fo:block border-style="solid" page-break-before="always">
					<fo:block font-size="8pt" linefeed-treatment="preserve">
						<xsl:call-template name="STATIC.common.dumpPubStore"/>
					</fo:block>
				</fo:block>
			</xsl:if>
			<!-- /DEBUG -->


		</fo:block>
    </xsl:template>
    
</xsl:stylesheet>
