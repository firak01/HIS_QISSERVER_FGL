<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:date="http://exslt.org/dates-and-times" 
	version="1.0">

	<!--#set($templates="publish/pmodul/xslfo/hisinone/cm/app/templates/")
	#parse("${templates}settings_tubaf.txt")-->
	
	<!-- FGL: 20240205 Alternativ/Ergänzend zum Einbinden der Settings Variablen per import, s. layout_tubaf_2: parsen einer Datei mit den Variablen aus der Settings.txt -->
<!-- 	#set($pfad="publish/pmodul/xslfo/hisinone/cm/app/templates/") -->
<!-- 	#parse("${pfad}layoutSettings_tubaf.xsl") -->
	
	<!--neue Variable ab 2022.06 - erstellt sonst kein odf (Anfrage 290106)-->
	<xsl:variable name="language" select="//foreignLanguage/k_language.uniquename" />
	
	<xsl:variable name="heute" select="date:date-time()" />
	
	<!-- So kann man in xsl ein "if layoutTubaf2_bodyMarginTop does not exist, layoutTubaf2_bodyMarginTop='9.0cm'" machen -->
	<!-- ref: https://github.com/stevleibelt/General_Howtos/blob/master/development/xsl-fo/howto/variable_declaration.md#define-variable-if-it-does-not-exist -->
	<xsl:variable name="layoutTubaf2_bodyMarginTop">
		<xsl:choose>
			<xsl:when test="layoutTubaf2_bodyMarginTop != ''">
				<xsl:value-of select="layoutTubaf2_bodyMarginTop" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'9.0cm'" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	
	<xsl:variable name="schrift16">16pt</xsl:variable>
	<xsl:variable name="schrift14">14pt</xsl:variable>
	<xsl:variable name="schrift12">12pt</xsl:variable>
	<xsl:variable name="schrift11">11pt</xsl:variable>
	<xsl:variable name="schrift10">10pt</xsl:variable>
	<xsl:variable name="schrift9">9pt</xsl:variable>
	<xsl:variable name="schrift8">8pt</xsl:variable>
	<xsl:variable name="schrift7">7pt</xsl:variable>
	<xsl:variable name="schrift6">6pt</xsl:variable>
	<xsl:variable name="template-border">0px</xsl:variable>
	<xsl:variable name="fontFamily">LiberationSans</xsl:variable>	
	<xsl:output method="xml" indent="yes"/>

	<xsl:variable name="now" select="date:date-time()" />
	<xsl:variable name="hauptschrift1">$hauptschrift1</xsl:variable>
	<xsl:variable name="hauptschrift2">$hauptschrift2</xsl:variable>
	<xsl:variable name="hauptschrift3">$hauptschrift3</xsl:variable>
	<xsl:variable name="hauptschrift5">$hauptschrift5</xsl:variable>
	<xsl:variable name="ueberschrift">$ueberschriften</xsl:variable>
	<xsl:variable name="ueberschriften">$ueberschriften</xsl:variable>
	<xsl:variable name="ueberschriften1">$ueberschriften1</xsl:variable>
	<xsl:variable name="FontWeight">$FontWeight</xsl:variable>
	<xsl:variable name="FontWeightBold">$FontWeightBold</xsl:variable>
	<xsl:variable name="tableHeader">$tableHeaderFontSize</xsl:variable>
	<xsl:variable name="tableBorderColor">$tableBorderColor</xsl:variable>
	<xsl:variable name="tablePadding">$tablePadding</xsl:variable>
	<xsl:variable name="tablePaddingLinie">$tablePaddingLinie</xsl:variable>
	<xsl:variable name="tableBorderWidth">$tableBorderWidth</xsl:variable>
	<xsl:variable name="tableBorderWidthLinie">$tableBorderWidthLinie</xsl:variable>
	<xsl:variable name="tableHeaderFontWeight">$tableHeaderFontWeight</xsl:variable>
	<xsl:variable name="tableBorderStyle">$tableBorderStyle</xsl:variable>
	<xsl:variable name="lineBetweenTablesStyle">$lineBetweenTablesStyle</xsl:variable>
	<xsl:variable name="lineBetweenTablesWidth">$lineBetweenTablesWidth</xsl:variable>
	<xsl:variable name="tableHeaderPadding">$tableHeaderPadding</xsl:variable>
	<xsl:variable name="spaceBeforeTable">$spaceBeforeTable</xsl:variable>
	<xsl:variable name="tablePaddingStart">$tablePaddingStart</xsl:variable>
	<xsl:variable name="spaceBetweenParagraphs">0.8em</xsl:variable>

	<!-- FGL: Test Einbinden der Variablenwerte über Settings.txt -->
	<xsl:variable name="settingstest">$settingstest</xsl:variable>
	<xsl:variable name="kopfLogoAbstandLinks">$kopfLogoAbstandLinks</xsl:variable>
	<xsl:variable name="kopfLogoAbstandObenSVG">$kopfLogoAbstandObenSVG</xsl:variable>


	<!-- CD KRAM -->
	<!--<xsl:variable name="pageMarginLeft">2.0cm</xsl:variable>
	<xsl:variable name="pageMarginRight">2.0cm</xsl:variable>
	<xsl:variable name="pageMarginTop">1.5cm</xsl:variable>
	<xsl:variable name="pageMarginBottom">1.5cm</xsl:variable>
	<xsl:variable name="bodyMarginTop">0.0cm</xsl:variable>
	<xsl:variable name="bodyMarginBottom">0.0cm</xsl:variable>
	<xsl:variable name="kopfHoehe">7.5cm</xsl:variable>
	<xsl:variable name="kopfLogoAbstandLinks">9.5cm</xsl:variable>
	<xsl:variable name="kopfLogoBreite">7.5cm</xsl:variable>
	<xsl:variable name="kopfLogoHoehe">2.0cm</xsl:variable>
	<xsl:variable name="kopfAdressfeldBreite">8.5cm</xsl:variable>
	<xsl:variable name="kopfAdressfeldHoehe">4.5cm</xsl:variable>
	<xsl:variable name="kopfAdressfeldAbstandOben">3.0cm</xsl:variable>
	<xsl:variable name="kopfAdressfeldMargin">0.3cm</xsl:variable>
	<xsl:variable name="kopfAdressfeldSchriftgroesse">12pt</xsl:variable>
	<xsl:variable name="kopfAdressfeldSchriftfarbe">#000000</xsl:variable>
	<xsl:variable name="kopfAbsenderdatenAbstandOben">2.5cm</xsl:variable>
	<xsl:variable name="kopfAbsenderdatenBreite">5.0cm</xsl:variable>
	<xsl:variable name="kopfAbsenderdatenHoehe">2.0cm</xsl:variable>
	<xsl:variable name="kopfAbsenderdatenAbstandLinks">12.0cm</xsl:variable>
	<xsl:variable name="kopfAbsenderdatenMarginTop">0.3cm</xsl:variable>
	<xsl:variable name="kopfAbsenderdatenSchriftgroesse">7pt</xsl:variable>
	<xsl:variable name="kopfAbsenderdatenSchriftfarbe">#000000</xsl:variable>
	<xsl:variable name="kopfBearbeiterdatenAbstandOben">5.0cm</xsl:variable>
	<xsl:variable name="kopfBearbeiterdatenBreite">5.0cm</xsl:variable>
	<xsl:variable name="kopfBearbeiterdatenHoehe">2.5cm</xsl:variable>
	<xsl:variable name="kopfBearbeiterdatenAbstandLinks">12.0cm</xsl:variable>
	<xsl:variable name="kopfBearbeiterdatenMarginTop">0.0cm</xsl:variable>
	<xsl:variable name="kopfBearbeiterdatenSchriftgroesse">7pt</xsl:variable>
	<xsl:variable name="kopfBearbeiterdatenSchriftfarbe">#000000</xsl:variable>
	<xsl:variable name="kopfBearbeiterdatenPadding">0cm</xsl:variable>
	<xsl:variable name="fussHoehe">1.0cm</xsl:variable>
	<xsl:variable name="hauptschrift1">10</xsl:variable>
	<xsl:variable name="hauptschrift2">12</xsl:variable>
	<xsl:variable name="hauptschrift3">9</xsl:variable>
	<xsl:variable name="hauptschrift4">8</xsl:variable>
	<xsl:variable name="hauptschrift5">7</xsl:variable>
	<xsl:variable name="ueberschriften">16</xsl:variable>
	<xsl:variable name="ueberschriften1">14</xsl:variable>
	<xsl:variable name="FontWeight">normal</xsl:variable>
	<xsl:variable name="FontWeightBold">bold</xsl:variable>
	<xsl:variable name="fontFamily">LiberationSans</xsl:variable>-->




	<xsl:template match="publishDetail">
		
		<fo:root font-family="{$fontFamily}" xmlns:fo="http://www.w3.org/1999/XSL/Format">
			
			<!-- Definition des Layout Masters -->
				<!-- ausgelagert in extra Datei, damit es für alle Dokumente mit einmal bearbeitet werden kann. (/var/lib/tomcat8/webapps/qisserver/WEB-INF/templates/publish/pmodul/xslfo/hisinone/templates/layout-master_tubaf.xsl)-->
			<!--#parse("${templates}layout-master_tubaf.xsl")-->
			<fo:layout-master-set>
				<!-- dachs:
					Wir unterscheiden zwischen verschiedenen Page-Mastern:
					- einer für die erste Seite, da kommt das ganze Kopfzeilengedöns hin (Logo, Anschrift, ...), dann der eigentliche Inhalt und die Fußzeile
					- und einer für alle anderen Seiten, da kommt nur die Fußzeile (Seite x/y, Datum, ...) rein
					
					Die Page-Master werden in dem layout-master-set zusammen definiert, jeder Page-Master ist eine XML-Struktur der Form <fo:simple-page-master> und definiert, wie die Seite aussehen soll (Außenabstände vom Druckbereich bspw.)
				-->
				<fo:simple-page-master master-name="singlePage" page-height="29.7cm" page-width="21.0cm" margin-left="2.0cm" margin-right="2.0cm" margin-top="1.5cm" margin-bottom="1.5cm">
					<fo:region-body text-align="justify" margin-top="9.0cm" margin-bottom="2.0cm" background-color="#FFFFFF" region-name="region-body"/>
					<fo:region-before text-align="justify" extent="7.5cm" background-color="#FFFFFF" region-name="briefkopf" />							
					<fo:region-after text-align="justify" extent="1.0cm" background-color="#FFFFFF" region-name="fusszeile" display-align="after"/>
				</fo:simple-page-master>
				
				<fo:simple-page-master master-name="firstPage" page-height="29.7cm" page-width="21.0cm" margin-left="2.0cm" margin-right="2.0cm" margin-top="1.5cm" margin-bottom="1.5cm">
					<fo:region-body text-align="justify" margin-top="{$layoutTubaf2_bodyMarginTop}" margin-bottom="2.0cm" background-color="#FFFFFF" region-name="region-body"/>
					<fo:region-before text-align="justify" extent="7.5cm" background-color="#FFFFFF" region-name="briefkopf" />
					<fo:region-after text-align="justify" extent="1.0cm" background-color="#FFFFFF" region-name="fusszeile" display-align="after"/>
				</fo:simple-page-master>
				
				<fo:simple-page-master master-name="middlePage" page-height="29.7cm" page-width="21.0cm" margin-left="2.0cm" margin-right="2.0cm" margin-top="1.5cm" margin-bottom="1.5cm">
					<fo:region-body text-align="justify" background-color="#FFFFFF" margin-bottom="2.0cm" region-name="region-body"/>
					<!--<fo:region-before extent="1cm" background-color="#FFFFFF"/>-->
					<fo:region-after text-align="justify" extent="1.0cm" background-color="#FFFFFF" region-name="fusszeile" display-align="after"/>
				</fo:simple-page-master>
				
				<fo:simple-page-master master-name="lastPage" page-height="29.7cm" page-width="21.0cm" margin-left="2.0cm" margin-right="2.0cm" margin-top="1.5cm" margin-bottom="1.5cm">
					<fo:region-body background-color="#FFFFFF" margin-bottom="2.0cm" region-name="region-body"/>
					<!--<fo:region-before extent="1cm" background-color="#FFFFFF"/>-->
					<!--<fo:region-after extent="{$fussHoehe" background-color="#FFAAFF" region-name="fusszeile" display-align="after"/>-->
					<fo:region-after extent="1.0cm" background-color="#FFFFFF" region-name="fusszeile" display-align="after"/>
				</fo:simple-page-master>

				<!-- Sequenz der Abarbeitung, ob ein Master für eine entsprechende Seite gilt: -->
				<!-- Obacht: sobald der erste Treffer da ist, wird dieser Master auch genommen! -->
				<fo:page-sequence-master master-name="allPages">
					<fo:repeatable-page-master-alternatives>
						<!-- <fo:conditional-page-master-reference page-position="only" master-reference="singlePage"/>-->
						<!-- page-postition = "only": nur eine Seite im Druck zu erzeugen. Dann nehmen wir das Layout von "firstPage" -->
						<fo:conditional-page-master-reference page-position="only" master-reference="firstPage"/>
						<!-- page-postition = "first": erste Seite von mehreren -->
						<fo:conditional-page-master-reference page-position="first" master-reference="firstPage" />
						<!-- page-postition = "rest": alle Seiten zwischen "first" und "last" -->
						<fo:conditional-page-master-reference page-position="rest" master-reference="middlePage"/>
						<!-- page-postition = "last": letzte Seite von mehreren -->
						<fo:conditional-page-master-reference page-position="last" master-reference="lastPage"/>
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			
			<xsl:for-each select="Root">
			
				<!-- Inhaltsbereich -->
				<fo:page-sequence master-reference="allPages" initial-page-number="1" force-page-count="no-force">
						<fo:static-content flow-name="briefkopf">
							<fo:block-container position="absolute" left="0.0cm" top="0.0cm">
								<fo:block-container text-align="left" color="#0084D1">
									<!--<xsl:call-template name="header.tubaf"/>-->
									<xsl:call-template name="header.tubaf"/>
								</fo:block-container>
							</fo:block-container>
						</fo:static-content>

						
						<!-- Fußzeile -->
						<fo:static-content flow-name="fusszeile">
							<fo:block-container position="absolute" left="0.0cm"
								top="0.5cm">
								<fo:block role="p" font-size="7pt">
									<fo:inline text-align="left">
										<xsl:text>As of &#160;</xsl:text>
									</fo:inline>
									<fo:inline text-align="left">
										<date:date-format lang="en" />
										<xsl:value-of select="date:format-date($heute,'dd.MM.yyyy')" />
									</fo:inline>
								</fo:block>
							</fo:block-container>
							<fo:block-container position="absolute" left="14.0cm"
								top="0.5cm">
								<fo:block role="p" font-size="8pt"
									text-align="right">
									<fo:inline>
										Page
										<fo:page-number />
										of
										<!-- Letzte Seite wird durch ein Block mit der id "end_of_document" gekennzeichnet -->
										<!--<fo:page-number-citation ref-id="end_of_document" />-->
										<fo:page-number-citation ref-id="lastPage_{generate-id()}"/>
									</fo:inline>
								</fo:block>
							</fo:block-container>
							
						<!-- FGL: 20240206 Labels in die Fußzeile. Stammen aus dem Web: https://drupal1.hrz.tu-freiberg.de/corporate-design-2023/geschaeftsausstattung -->
							<!--                                       Es wurden 140209_fih_logo.fw_.png und gegen_fremdenfeindlichkeit.png in .jpg umgewandelt -->
							<fo:block-container text-align="right" position="absolute" left="9.1cm" top="0.8cm" width="8.0cm" height="1.0cm" background-color="#FFFFFF">
								<!-- Obacht: Transparente Effekte (wie im PNG des TUBAF-Logos) werden von PDF-A nicht unterstützt! Daher stattdessen das JPEG -->
								<!-- Fehlermeldung im Log diesbezueglich
								ERROR [nio-8080-exec-2] (PublishLayoutStep.java:1063) - Fehler bei Ausführung des PublishLayoutSteps
								org.apache.fop.pdf.TransparencyDisallowedException: PDF/A-1a does not allow the use of transparency. (WEB-INF/templates/publish/pmodul/xslfo/hisinone/cm/app/templates/140209_fih_logo.fw_.png)
								-->
								
<!-- 							<xsl:variable name="Label01">url('[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/Logo_BMBF_IH_webRZ.jpg')</xsl:variable> -->
<!-- 							<xsl:variable name="Label02">url('[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/140209_fih_logo.fw_.jpg')</xsl:variable> -->
<!-- 							<xsl:variable name="Label03">url('[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/gegen_fremdenfeindlichkeit.jpg')</xsl:variable> -->
	       
	       					<xsl:variable name="Label01">url('WEB-INF/templates/publish/pmodul/xslfo/hisinone/cm/app/templates/Logo_BMBF_IH_webRZ.jpg')</xsl:variable>
							<xsl:variable name="Label02">url('WEB-INF/templates/publish/pmodul/xslfo/hisinone/cm/app/templates/140209_fih_logo.fw_.jpg')</xsl:variable>
							<xsl:variable name="Label03">url('WEB-INF/templates/publish/pmodul/xslfo/hisinone/cm/app/templates/gegen_fremdenfeindlichkeit.jpg')</xsl:variable>
	       
					
								<!-- Labels unten rechts (CD: 115mm vom Seitenrand) -->								
								<fo:block text-align="end" position="absolute" left="0cm">
									<fo:external-graphic src="{$Label01}" content-width="scale-up-to-fit" scaling="uniform" content-height="0.7cm" />									
									<fo:external-graphic src="{$Label02}" content-width="scale-up-to-fit" scaling="uniform" content-height="0.7cm" />
									<fo:external-graphic src="{$Label03}" content-width="scale-up-to-fit" scaling="uniform" content-height="0.7cm" />				
								</fo:block>
							</fo:block-container>
							
							<!-- FGL: 20240206 Adresse in die Fußzeile. -->
							<fo:block-container text-align="left" position="absolute" left="7.3cm" top="1.5cm" width="10.0cm" height="0.75cm" background-color="#FFFFFF">
					
								<!-- Adresse unten rechts (CD: 115mm vom Seitenrand) -->								
								<fo:block text-align="end" position="absolute" left="0cm" font-size="5pt" margin="0.3cm" background-color="#FFFFFF" color="#0064A8">
				 				TU Bergakademie Freiberg - Akademiestraße 6 - 09599 Freiberg - tu-freiberg.de
								</fo:block>
							</fo:block-container>
						</fo:static-content>
						
						<!-- Flow-Element, fliessender Text, produziert Seitenumbrueche -->
						<!-- Referenz auf das Region-Element mit dem Namen "xsl-region-body" -->
						<fo:flow flow-name="region-body">
							
							<fo:block font-size="{$schrift10}">
							
								<xsl:call-template name="documentContent" />
								<!--<xsl:call-template name="STATIC.common.dumpPubStore"/>-->
								<!-- Ermittlung der Nummer der letzten Seite, s. footer -->
								<fo:block id="lastPage_{generate-id()}"/>
								
							</fo:block>
						</fo:flow>					
				</fo:page-sequence>
			</xsl:for-each>
		</fo:root>
	</xsl:template>
	
	<xsl:template name="STATIC.layout.header">
		<fo:block border-style="{$template-border}">
			<xsl:if test="$debug='true'">
				<fo:block font-size="{$schrift6}">
					<xsl:text>STATIC.layout.header</xsl:text>
				</fo:block>
			</xsl:if>
			<fo:block>
				<fo:block-container height="38mm" margin-top="7mm">
					<fo:block vertical-align="middle">
						<xsl:call-template name="STATIC.layout.header.logo"/>
						<xsl:call-template name="common.header.university"/>
					</fo:block>
				</fo:block-container>
				<fo:block-container height="45mm">
					<fo:block>
						<fo:table table-layout="auto">
							<fo:table-column column-width="100mm" />
							<fo:table-column column-width="75mm" />
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell display-align="after">
										<fo:block><xsl:call-template name="common.header.universityAddress"/></fo:block>
									</fo:table-cell>
									<fo:table-cell display-align="after" number-rows-spanned="2">
										<fo:block><xsl:call-template name="STATIC.common.header.dateOfDoc"/></fo:block>
										<fo:block><xsl:call-template name="common.header.universityContact"/></fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell>
										<fo:block><xsl:call-template name="common.header.recipient"/></fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>		
					</fo:block>
				</fo:block-container>
				<fo:block-container width="165mm" margin-top="8.46mm" margin-bottom="8.46mm">
					<fo:block><xsl:call-template name="common.header.applicantnumber"/></fo:block>
				</fo:block-container>
				
			</fo:block>
		</fo:block>
	</xsl:template>
	
	<!--Logo und Kopfdaten (Linux hat mit dem Backslash beim Logo-Pfad ein Problem. Daher darf kein Backslash benutzt werden)-->
	<xsl:template name="STATIC.layout.header.logo">
		<fo:block border-style="{$template-border}">
			<xsl:if test="$debug='true'">
				<fo:block font-size="{$schrift6}">
					<xsl:text>STATIC.layout.header.logo: GlobalParam 'cm.app.common.reports.logo'</xsl:text>
				</fo:block>
			</xsl:if>
			<xsl:variable name="LogoBrief" select="//globalConfigParams/cm.app.common.reports.logo"/>
			<fo:block>
				<fo:external-graphic src="{$LogoBrief}"/>
			</fo:block>
		</fo:block>
	</xsl:template>
	
	<xsl:template name="STATIC.layout.footer">
		<fo:block border-style="{$template-border}">
			<xsl:if test="$debug='true'">
				<fo:block font-size="{$schrift6}">
					<xsl:text>STATIC.layout.footer</xsl:text>
				</fo:block>
			</xsl:if>
			<fo:block-container width="165mm">
				<fo:block font-size="{$schrift7}" text-align-last="justify">
				<!-- https://wiki.his.de/mediawiki/index.php/Bescheide_mit_Verifikationsnummern_versehen-HISinOne -->
					<xsl:choose>
						<xsl:when test="verificationNumber">
							<fo:inline><xsl:apply-templates select="uitext/cm.app.reports.common.content.verificationNumber"/>&#160;<xsl:value-of select="verificationNumber" /></fo:inline>
						</xsl:when>
						<xsl:otherwise>
							<fo:inline>&#160;</fo:inline>
						</xsl:otherwise>
					</xsl:choose>
					<fo:inline text-align="left">
					</fo:inline>
					<fo:leader leader-pattern="space" />
					<fo:inline>
						<fo:page-number /> / <fo:page-number-citation ref-id="lastPage_{generate-id()}"/>
					</fo:inline>
				</fo:block>
			</fo:block-container>
		</fo:block>
	</xsl:template>
	
</xsl:stylesheet>
