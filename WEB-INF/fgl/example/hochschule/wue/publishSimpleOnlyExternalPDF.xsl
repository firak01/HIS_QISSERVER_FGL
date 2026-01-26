<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
    xmlns:fox="http://xmlgraphics.apache.org/fop/extensions"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:date="http://exslt.org/dates-and-times"
    version="1.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="now" select="date:date-time()" />
	<xsl:variable name="hauptschrift">11pt</xsl:variable>
	<xsl:variable name="hauptschrift1">$settings.hauptschrift1</xsl:variable>
	<xsl:variable name="hauptschrift2">$settings.hauptschrift2</xsl:variable>
	<xsl:variable name="hauptschrift3">$settings.hauptschrift3</xsl:variable>
	<xsl:variable name="hauptschrift4">$settings.hauptschrift4</xsl:variable>
	<xsl:variable name="hauptschrift5">$settings.hauptschrift5</xsl:variable>
	<xsl:variable name="ueberschriften">$settings.ueberschriften</xsl:variable>
	<xsl:variable name="ueberschriften1">$settings.ueberschriften1</xsl:variable>
	<xsl:variable name="fontFamily">Arial,Helvetica</xsl:variable>
	<xsl:variable name="FontWeight">$settings.FontWeight</xsl:variable>
	<xsl:variable name="schrifte">6.5pt</xsl:variable>
	<xsl:variable name="FontWeightBold">$settings.FontWeightBold</xsl:variable>
	<xsl:variable name="tableBorderStyle">$settings.tableBorderStyle</xsl:variable>
	<xsl:variable name="tableBorderWidthLinie">$settings.tableBorderWidthLinie</xsl:variable>
	#set($pfad="publish/pmodul/xslfo/hisinone/appcontrolpage/settings/")
    
	<xsl:template match="publishDetail">
	
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
		<fo:layout-master-set>
			<fo:simple-page-master	master-name="mainPart" 
				page-height="29.7cm" 
				page-width="21.0cm" 
				margin-left="2.0cm" 
				margin-right="1.5cm" 
				margin-top="1.0cm" 
				margin-bottom="1.5cm">
			  <fo:region-body margin-top="0.5cm" margin-bottom="0.5cm"  />
<!-- 			  <fo:region-before region-name="regionBefore1" extent="0.5cm" /> -->
<!-- 			  <fo:region-after region-name="regionAfter1" extent="0.01cm" /> -->
			</fo:simple-page-master>
    	</fo:layout-master-set>
    	
    	<!-- Auszug aus der Doku: -->
    	<!-- https://xmlgraphics.apache.org/fop/1.0/extensions.html -->
    	<!-- Funktioniert nur für 1 Seite und funktioniert statt page-sequence -->
<!--     	 <fox:external-document xmlns:fox="http://xmlgraphics.apache.org/fop/extensions" src="WEB-INF/templates/publish/pmodul/xslfo/hisinone/enrollment/Einfaches_PDF_ohne_Schriftarten.pdf"/> -->    	 
    	 <fox:external-document xmlns:fox="http://xmlgraphics.apache.org/fop/extensions" src="WEB-INF/templates/publish/pmodul/xslfo/hisinone/enrollment/EFLAlumniInformation.pdf"/>

    	</fo:root>
	</xsl:template>
</xsl:stylesheet>
