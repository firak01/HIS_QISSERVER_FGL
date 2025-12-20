<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:date="http://exslt.org/dates-and-times" 
	version="1.0">


<!--neue Variable ab 2022.06 - erstellt sonst kein pdf (Anfrage 290106)-->
	<xsl:variable name="language" select="//foreignLanguage/k_language.uniquename" />
	
	<xsl:template name="header.tubaf">

		<xsl:variable name="heute" select="date:date-time()" />
		<!-- Im Layout Master ist die Region "briefkopf" definiert. Dieser erscheint nur auf der jeweils ersten Seite. -->
		<!-- Im Briefkopf sind sowohl die Anschrift des Studenten / Bewerbers als auch die Daten des Absenders (Zulassungsbüro) über Variablen einzutragen. -->
		<!-- Die Adresse des Bewerbers soll laut CD dabei nach DIN 5008 erstellt werden. Entsprechendes ist dann im header_tubaf.xml definiert. -->
		<!-- Die Felder für die Absenderdaten und die Bearbeiterdaten sind eher generisch, daher wird hier eine Variable mit allen Daten verwendet. -->

		<!-- Anschrift Bewerber -->
		<!-- FGL 20240109 - Fallunterscheidung auslaendische Adressen -->
		<xsl:variable name="isAdressForeign">
			<xsl:choose>
				<xsl:when test="string(//Root/Antrag/Bewerber/address/country_lid)!='48'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>			
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="adressatName" select="//Root/Antrag/Bewerber/surname" />
		<xsl:variable name="adressatVorname" select="//Root/Antrag/Bewerber/firstname" />
		<xsl:variable name="adressatAkadGrad" select="//Root/Antrag/Bewerber/acgrad/acgrad" />
		<xsl:variable name="adressatTitel" select="//Root/Antrag/Bewerber/title/title" />
		<xsl:variable name="adressatStrasse" select="//Root/Antrag/Bewerber/address/street" />
		<xsl:variable name="adressatPLZ" select="//Root/Antrag/Bewerber/address/postcode" />
		<xsl:variable name="adressatStadt">
			<xsl:choose>
				<xsl:when test="$isAdressForeign='1'">
					<xsl:call-template name="UPPER">
			            <xsl:with-param name="text">
			                <xsl:value-of select="//Root/Antrag/Bewerber/address/city" /> 
			            </xsl:with-param>
			        </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//Root/Antrag/Bewerber/address/city" />		
				</xsl:otherwise>
			</xsl:choose>		 
		 </xsl:variable>
		<xsl:variable name="adressatAdresseZusatz" select="//Root/Antrag/Bewerber/address/addressaddition" />
		<xsl:variable name="adressatStaat">
		<xsl:choose>
				<xsl:when test="$isAdressForeign='1'">
					<xsl:call-template name="UPPER">
			            <xsl:with-param name="text">
			                <xsl:value-of select="//Root/Antrag/Bewerber/address/staat/staat" /> 
			            </xsl:with-param>
			        </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//Root/Antrag/Bewerber/address/staat/staat" />		
				</xsl:otherwise>
			</xsl:choose>					
		</xsl:variable>


		<!-- Sachbearbeiterdaten -->
		<xsl:variable name = "sachbearbeiter_nn"><xsl:value-of select="//outputrequest/anfragender_fn" /></xsl:variable>
		<xsl:variable name = "sachbearbeiter_vn"><xsl:value-of select="//outputrequest/anfragender_vn" /></xsl:variable>
		<xsl:variable name = "sachbearbeiter_geschlecht"><xsl:value-of select="//outputrequest/anfragender_gender_id" /></xsl:variable>
		<xsl:variable name = "sachbearbeiter_email"><xsl:value-of select="//outputrequest/anfragender_email/email" /></xsl:variable>
		<xsl:variable name = "sachbearbeiter_telefon"><xsl:value-of select="//outputrequest/anfragender_telefon/telefon" /></xsl:variable>
		<!-- hat jeder ein eigenes Fax? Das wäre dann im SQL zu trennen: addresstype=Phone mit eaddresstype_id=5 ist Fax, addresstype=Phone mit eaddresstype_id=6 ist Telefon -->
		<xsl:variable name = "sachbearbeiter_fax"><xsl:value-of select="//outputrequest/ausfuehrender_fax/fax" /></xsl:variable>

		<!-- Absenderdaten -->
		<!-- Die Block-Elemente in header_tubaf.xsl für die Absender- und Bearbeiterdaten sind mit linefeed-treatment="preserve"ausgestattet, sodass Zeilenumbrüche hier erhalten werden. -->
		<!-- Sofern Sachbearbeiter-Daten vorliegen werden diese verwendet. Falls nicht (bspw. bei Anforderung des Dokuments durch den Studenten selbst) wird ein generischer Absender verwendet (Zulassungsbüro) -->
<!-- 		<xsl:variable name = "absenderDaten">TU Bergakademie Freiberg -->
<!-- 			Zulassungsbüro -->
<!-- 			Akademiestr. 6 -->
<!-- 			09599 Freiberg					 -->
<!-- 		</xsl:variable> -->
		<xsl:variable name = "absenderDaten">
		
				The chancellor
		
		
		</xsl:variable>
			<!-- Bearbeiterdaten -->
		<xsl:variable name = "bearbeiterDaten">
			<fo:table>
				<fo:table-column column-width="2.0cm" />
				<fo:table-column column-width="3.0cm" />
				<fo:table-body>
					<!-- Wenn Sachbearbeiterdaten vorliegen, dann immer eine entsprechende Zeile einfügen -->
					<!-- Vorname und Nachname gefunden? -->
					<xsl:if test="$sachbearbeiter_nn!='' and $sachbearbeiter_vn!=''">
						<fo:table-row>
							<fo:table-cell text-align="left">
								<!-- Männlein oder Weiblein? -->
								<!-- JB 20221222 - das "in" und das ":" entfernt, macht an der Stelle für die Abfrage nach männlich/weiblich keinen Sinn -->
								<!--<fo:block>Processed by:<xsl:if test="$sachbearbeiter_geschlecht=2">in</xsl:if>:</fo:block> -->
								<fo:block>Processed by:</fo:block> 
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="concat($sachbearbeiter_vn, ' ' ,$sachbearbeiter_nn)" /></fo:block>
							</fo:table-cell>
						</fo:table-row>
						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block>Building/Room:</fo:block> 
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block>Akademiestr. 6/EG 12</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<!-- Telefonnummer gefunden? -->
					<xsl:if test="$sachbearbeiter_telefon!=''">
						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block>Telephone:</fo:block> 
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="$sachbearbeiter_telefon" /></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<!-- Fax gefunden? -->
					<xsl:if test="$sachbearbeiter_fax!=''">
						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block>Fax:</fo:block> 
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="$sachbearbeiter_fax" /></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<!-- Sonst Default: -->
					<xsl:if test="$sachbearbeiter_fax=''">
						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block>Fax:</fo:block> 
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block>+49 3731 39-3741</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>							
					<!-- Email gefunden? -->
					<xsl:if test="$sachbearbeiter_email!=''">
						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block>E-Mail:</fo:block> 
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="$sachbearbeiter_email" /></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>
					<!-- sonst default: -->
					<xsl:if test="$sachbearbeiter_email=''">
						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block>E-Mail:</fo:block> 
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block>zulassungsbuero@zuv.tu-freiberg.de</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</xsl:if>

					<!-- Homepage und Datum kommen immer rein -->
					<fo:table-row>
						<fo:table-cell text-align="left">
							<fo:block>Homepage:</fo:block> 
						</fo:table-cell>
						<fo:table-cell text-align="left">
							<fo:block>www.tu-freiberg.de</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell text-align="left">
							<fo:block>Date:</fo:block> 
						</fo:table-cell>
						<fo:table-cell text-align="left">
							<fo:block><xsl:value-of select="date:format-date($heute,'dd.MM.yyyy')" /></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</xsl:variable>
		
		<fo:block-container text-align="left" position="absolute" top="-0.5cm" width="6.0cm" height="2.0cm" background-color="#FFFFFF">
		<!-- Obacht: Transparente Effekte (wie im PNG des TUBAF-Logos) werden von PDF-A nicht unterstützt! Daher stattdessen das JPEG -->
			<!-- alte datei <xsl:variable name="Logo">url('[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/tubaf_WBM_orig_RGB.png')</xsl:variable> -->
	        <!-- alte datei <xsl:variable name="Logo">url('[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/WBM_orig_RGB_1000.jpg')</xsl:variable> -->
	        
			<!-- FGL: 20240131 - Im Logopaket gibt es kein .jpg - Teste nun andere Formate.-->			
<!-- 			<xsl:variable name="Logo">url('WEB-INF/templates/publish/pmodul/xslfo/hisinone/cm/app/templates/TUBAF_Logo_EN_blau.svg')</xsl:variable>			 -->
<!-- 			<xsl:variable name="Logo">url('[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/TUBAF_Logo_EN_blau.svg')</xsl:variable> -->
			<xsl:variable name="Logo">url('WEB-INF/templates/publish/pmodul/xslfo/hisinone/cm/app/templates/TUBAF_Logo_EN_blau.jpg')</xsl:variable>
<!-- 			<xsl:variable name="Logo">url('[TEMPLATEROOT]publish/pmodul/xslfo/hisinone/cm/app/templates/TUBAF_Logo_EN_blau.jpg')</xsl:variable> -->
					
			<!-- Logo oben rechts, 95mm von links im Druckbereich (CD: 115mm vom Seitenrand) -->
			<!-- FGL: 20240131 alte Logoposition und ohne Groesse des Blocks <fo:block text-align="end" position="absolute" left="9.5cm"> -->
			<!-- <fo:block text-align="start" position="absolute" left="9.5cm" width="15cm" height="8.0cm"> -->
			
			<fo:block text-align="start" position="absolute" left="9.5cm">
				<fo:external-graphic src="{$Logo}" content-height="scale-up-to-fit" scaling="uniform" content-width="5.5cm" />				
			</fo:block>
		</fo:block-container>
		
		
		<fo:block-container text-align="left" color="#0084D1">		
			<fo:block-container text-align="left" position="absolute" top="3.0cm" width="8.5cm" height="4.5cm" font-size="12pt" color="#000000" background-color="#FFFFFF">
				<!-- Entity &middot wird nicht unterstützt (siehe https://www.data2type.de/xml-xslt-xslfo/html-und-xhtml/zeichen-entities/, "nicht standardkonforme Entites"). Daher wird das durch einen Bindestrich ersetzt (nicht so schön aber anders geht's nicht) -->
				<!--<fo:block font-size="7pt" margin="$settings.kopfAdressfeldMargin" background-color="#f00">TU Bergakademie Freiberg &middot; 09599 Freiberg</fo:block> -->
				<fo:block font-size="7pt" margin="0.3cm" background-color="#FFFFFF">TU Bergakademie Freiberg - Akademiestraße 6 - 09599 Freiberg</fo:block>
				<fo:block font-size="12pt" margin="0.3cm" background-color="#FFFFFF">
					<fo:block>
						<xsl:if test="$adressatAkadGrad != ''">
							<xsl:value-of select="$adressatAkadGrad" /><xsl:text> </xsl:text>
						</xsl:if>
						<xsl:if test="$adressatTitel != ''">
							<xsl:value-of select="$adressatTitel" /><xsl:text> </xsl:text>
						</xsl:if>
						<xsl:value-of select="$adressatVorname" /><xsl:text> </xsl:text><xsl:value-of select="$adressatName" />
					</fo:block>
					<!-- FGL: 20240206 - Der Adresszusatz soll nun direkt unterhalb des Namens -->
					<xsl:if test="$adressatAdresseZusatz != ''">
						<fo:block><xsl:value-of select="$adressatAdresseZusatz" /></fo:block>
					</xsl:if>
					<fo:block><xsl:value-of select="$adressatStrasse" /></fo:block>					
					<fo:block><xsl:value-of select="$adressatPLZ" /><xsl:text> </xsl:text><xsl:value-of select="$adressatStadt" /></fo:block>					
					<!-- FGL: 20240109 - nun nicht mehr auf String abpruefen, sondern auf die Variable --><!--<xsl:if test="$adressatStaat != 'Deutschland'">-->
					<xsl:if test="$isAdressForeign != '0'">
						<fo:block><xsl:value-of select="$adressatStaat" /></fo:block>
					</xsl:if>
				</fo:block>
			</fo:block-container>
			
			<fo:block-container text-align="left" position="absolute" top="2.5cm" width="5.0cm" height="2.0cm" left="12.0cm" font-size="12pt" color="#000000" background-color="#FFFFFF">
				<fo:block linefeed-treatment="preserve" margin-top="0.3cm" font-size="10pt" ><xsl:copy-of select="$absenderDaten" /></fo:block>
			</fo:block-container>
			
			<fo:block-container text-align="left" position="absolute" top="5.0cm" width="5.0cm" height="2.5cm" left="12.0cm" padding="0cm" font-size="7pt" color="#000000" background-color="#FFFFFF">
				<fo:block linefeed-treatment="preserve" margin-top="0.0cm"><xsl:copy-of select="$bearbeiterDaten" /></fo:block>
			</fo:block-container>
			<!--
			<fo:block>
				<xsl:value-of select="Root/Hochschuldaten/Hochschulname/hochschulname" />
			</fo:block>
			<fo:block text-align="left" color="#0084D1" font-size="8pt">
						https://tu-freiberg.de
			</fo:block>
			-->
		</fo:block-container>
	</xsl:template>
	
	<!-- FGL 20240109 - Fuer die auslaendischen Adressen notwendige Uppercase - Methode... plus BooleanFormat -->
	<!-- ANSI -->
	<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿžšœ'" />

    <!-- ANSI --> 
    <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸŽŠŒ'" />
    
    <xsl:template name="UPPER">
        <xsl:param name="text"/>
        <xsl:value-of select="translate($text, $smallcase, $uppercase)"/>
    </xsl:template>
    
    <xsl:template name="LOWER">
        <xsl:param name="text"/>
        <xsl:value-of select="translate($text, $uppercase, $smallcase)"/>
    </xsl:template>   		
</xsl:stylesheet>
