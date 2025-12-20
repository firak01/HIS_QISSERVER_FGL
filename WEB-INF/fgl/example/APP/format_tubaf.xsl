<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
	<!-- Formatierungsabschnitt -->
	<xsl:template match="b">
		<fo:inline font-weight="bold">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>
	<xsl:template match="strong">
		<fo:inline font-weight="bold">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>
	<xsl:template match="i">
		<fo:inline font-style="italic">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>
	<xsl:template match="em">
		<fo:inline font-style="italic">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>
	<xsl:template match="u">
		<fo:inline text-decoration="underline">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>
	<xsl:template match="strike">
		<fo:inline text-decoration="line-through">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>

	<xsl:template match="span">
		<xsl:choose>
			<xsl:when test="@style='text-decoration: line-through;'">
				<fo:inline text-decoration="line-through">
					<xsl:apply-templates />
				</fo:inline>
			</xsl:when>
			<xsl:when test="@style='text-decoration: underline;'">
				<fo:inline text-decoration="underline">
					<xsl:apply-templates />
				</fo:inline>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="br">
		<fo:block>
			<xsl:apply-templates />
		</fo:block>
	</xsl:template>
	<xsl:template match="p">
		<xsl:choose>
			<xsl:when test="@class='hidden'" />
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="@align='left'">
						<fo:block space-before="10pt" space-after="10pt"
							text-align="left">
							<xsl:apply-templates />
						</fo:block>
					</xsl:when>
					<xsl:when test="@style='text-align: left;'">
						<fo:block space-before="10pt" space-after="10pt"
							text-align="left">
							<xsl:apply-templates />
						</fo:block>
					</xsl:when>
					<xsl:when test="@align='right'">
						<fo:block space-before="10pt" space-after="10pt"
							text-align="right">
							<xsl:apply-templates />
						</fo:block>
					</xsl:when>
					<xsl:when test="@style='text-align: right;'">
						<fo:block space-before="10pt" space-after="10pt"
							text-align="right">
							<xsl:apply-templates />
						</fo:block>
					</xsl:when>
					<xsl:when test="@align='center'">
						<fo:block space-before="10pt" space-after="10pt"
							text-align="center">
							<xsl:apply-templates />
						</fo:block>
					</xsl:when>
					<xsl:when test="@style='text-align: center;'">
						<fo:block space-before="0pt" space-after="0pt"
							text-align="center">
							<xsl:apply-templates />
						</fo:block>
					</xsl:when>
					<xsl:when test="@align='justify'">
						<fo:block space-before="10pt" space-after="10pt"
							text-align="justify">
							<xsl:apply-templates />
						</fo:block>
					</xsl:when>
					<xsl:when test="@style='text-align: justify;'">
						<fo:block space-before="10pt" space-after="10pt"
							text-align="justify">
							<xsl:apply-templates />
						</fo:block>
					</xsl:when>
					<xsl:otherwise>
						<fo:block space-before="10pt" space-after="10pt">
							<xsl:apply-templates />
						</fo:block>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="ul">
		<xsl:if test="li">
			<fo:list-block provisional-distance-between-starts="0.5cm"
				provisional-label-separation="0.5cm">
				<xsl:attribute name="space-after">
					<xsl:choose>
						<xsl:when test="ancestor::ul or ancestor::ol">
							<xsl:text>0pt</xsl:text>
						</xsl:when>
						<xsl:otherwise>
						<xsl:text>12pt</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:apply-templates select="*" />
				
				<fo:list-item>
					<fo:list-item-label end-indent="label-end()"><fo:block /></fo:list-item-label>
					<fo:list-item-body start-indent="body-start()"><fo:block /></fo:list-item-body>
				</fo:list-item>
			</fo:list-block>
		</xsl:if>
	</xsl:template>

	<xsl:template match="ul/li">
		<fo:list-item>
			<fo:list-item-label end-indent="label-end()">
				<fo:block>&#x2022;</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="body-start()">
				<fo:block>
					<xsl:apply-templates select="*|text()" />
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>

	<xsl:template match="ol">
		<xsl:if test="li">
			<fo:list-block provisional-distance-between-starts="0.5cm"
				provisional-label-separation="0.5cm">
				<xsl:attribute name="space-after">
			      <xsl:choose>
			        <xsl:when test="ancestor::ul or ancestor::ol">
			          <xsl:text>0pt</xsl:text>
			        </xsl:when>
			        <xsl:otherwise>
			          <xsl:text>12pt</xsl:text>
			          </xsl:otherwise>
			      </xsl:choose>
			    </xsl:attribute>
				<xsl:apply-templates select="*" />
				<fo:list-item>
					<fo:list-item-label end-indent="label-end()"><fo:block /></fo:list-item-label>
					<fo:list-item-body start-indent="body-start()"><fo:block /></fo:list-item-body>
				</fo:list-item>
			</fo:list-block>
		</xsl:if>
	</xsl:template>

	<xsl:template match="ol/li">
		<fo:list-item>
			<fo:list-item-label end-indent="label-end()">
				<fo:block>
					<xsl:variable name="value-attr">
						<xsl:choose>
							<xsl:when test="../@start">
								<xsl:number value="position() + ../@start - 1" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:number value="position()" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="../@type='i'">
							<xsl:number value="$value-attr" format="i. " />
						</xsl:when>
						<xsl:when test="../@type='I'">
							<xsl:number value="$value-attr" format="I. " />
						</xsl:when>
						<xsl:when test="../@type='a'">
							<xsl:number value="$value-attr" format="a. " />
						</xsl:when>
						<xsl:when test="../@type='A'">
							<xsl:number value="$value-attr" format="A. " />
						</xsl:when>
						<xsl:otherwise>
							<xsl:number value="$value-attr" format="1. " />
						</xsl:otherwise>
					</xsl:choose>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body start-indent="body-start()">
				<fo:block>
					<xsl:apply-templates select="*|text()" />
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>
	<!-- tiefgestellt -->
	<xsl:template match="sub">
		<fo:inline baseline-shift="sub" font-size="60%">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>

	<!-- hochgestellt -->
	<xsl:template match="sup">
		<fo:inline baseline-shift="super" font-size="60%">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>

	<!-- Durchstreichen -->
	<xsl:template match="s">
		<fo:inline text-decoration="line-through">
			<xsl:apply-templates />
		</fo:inline>
	</xsl:template>

	<!-- Link -->
	<xsl:template match="a">
		<fo:inline text-decoration="underline" color="#0000FF">
			<xsl:variable name="linkUrl" select="@href" />
			<xsl:choose>
				<xsl:when test="$linkUrl != ''">
					<fo:basic-link external-destination="{$linkUrl}" show-destination="new">
						<xsl:apply-templates />
		      		</fo:basic-link>
		      	</xsl:when>
		      	<xsl:otherwise>
		      		<xsl:apply-templates />
		      	</xsl:otherwise>
			</xsl:choose>
		</fo:inline>
	</xsl:template>

	<!-- div mit text_align -->
	<xsl:template match="div">
		<xsl:variable name="style">
			<xsl:value-of select="@style" />
		</xsl:variable>
		<xsl:variable name="text_align">
			<xsl:choose>
				<xsl:when test="starts-with($style,'text-align:')">
					<xsl:value-of
						select="substring-before(substring-after($style,'text-align: '),';')" />
				</xsl:when>
				<xsl:otherwise>
					left
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<fo:block text-align="{$text_align}">
			<xsl:if test="@style != ''">
				<xsl:call-template name="parse-style">
					<xsl:with-param name="line" select="@style" />
				</xsl:call-template>
			</xsl:if>
			<xsl:apply-templates />
		</fo:block>
	</xsl:template>

	<!-- Tabelle -->
	<!-- TODO: parse css-style attribute -->
	<xsl:template match="table">
		<xsl:if test="caption != ''">
			<fo:block>
				<xsl:value-of select="caption" />
			</fo:block>
		</xsl:if>
		<fo:table border-collapse="collapse" border="0">
			<xsl:if test="@style != ''">
				<xsl:call-template name="parse-style">
					<xsl:with-param name="line" select="@style" />
				</xsl:call-template>
			</xsl:if>
			<!-- <xsl:if test="@bgcolor != ''"> <xsl:attribute name="background-color"> 
				<xsl:value-of select="@bgcolor" /> </xsl:attribute> </xsl:if> -->
			<xsl:apply-templates />
		</fo:table>
	</xsl:template>

	<!-- Captions in verwendeter FOP Version nicht unterstützt -->
	<!-- <xsl:template match="table"> <fo:table-and-caption> <xsl:if test="caption 
		!= ''"> <fo:caption> <xsl:apply-templates select="caption"/> </fo:caption> 
		</xsl:if> <fo:table table-layout="fixed" width="185mm"> <xsl:if test="thead 
		!= ''"> <xsl:apply-templates select="thead"/> </xsl:if> <xsl:if test="tfoot 
		!= ''"> <xsl:apply-templates select="tfoot"/> </xsl:if> <xsl:apply-templates 
		select="tbody"/> </fo:table> </fo:table-and-caption> </xsl:template> -->

	<xsl:template match="thead">
		<fo:table-header>
			<xsl:apply-templates />
		</fo:table-header>
	</xsl:template>

	<xsl:template match="tbody">
		<fo:table-body>
			<xsl:apply-templates />
		</fo:table-body>
	</xsl:template>

	<xsl:template match="tfoot">
		<fo:table-footer>
			<xsl:apply-templates />
		</fo:table-footer>
	</xsl:template>

	<xsl:template match="tr">
		<fo:table-row>
			<xsl:apply-templates />
		</fo:table-row>
	</xsl:template>

	<xsl:template match="td|th">
		<fo:table-cell margin="0" padding="0">
			<!--<xsl:call-template name="addStandardTableCellAttr"/>-->
			<xsl:call-template name="parse-style">
				<xsl:with-param name="line" select="@style" />
			</xsl:call-template>
			<xsl:if test="@colspan != ''">
				<xsl:attribute name="number-columns-spanned">
					<xsl:value-of select="@colspan" />
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@rowspan != ''">
				<xsl:attribute name="number-rows-spanned">
					<xsl:value-of select="@rowspan" />
				</xsl:attribute>
			</xsl:if>
			<fo:block>
				<xsl:apply-templates />
			</fo:block>
		</fo:table-cell>
	</xsl:template>
	
	<xsl:template name="addStandardTableCellAttr">
		<!-- border="1pt solid black" padding-left="4"
			padding-right="4" padding-top="2" padding-bottom="2" -->
		<xsl:attribute name="border">1pt solid black</xsl:attribute>
		<xsl:attribute name="padding-left">4</xsl:attribute>
		<xsl:attribute name="padding-right">4</xsl:attribute>
		<xsl:attribute name="padding-top">2</xsl:attribute>
		<xsl:attribute name="padding-bottom">2</xsl:attribute>
	</xsl:template>

	<!-- <xsl:template name="parse-style"> <xsl:param name=""> <xsl:for-each 
		select="str:tokenize(@style, ';')"> <xsl:variable name="param" select="normalize-space(.)" 
		/> <xsl:value-of select="$param" /> <xsl:variable name="part" select="tokenize(@param, 
		':')" /> <xsl:if test="matches($part[1], 'background-color')"> <xsl:attribute 
		name="background-color"> <xsl:value-of select="$part[2]"/> </xsl:attribute> 
		</xsl:if> </xsl:for-each> </xsl:template> -->

	<xsl:template name="parse-style">
		<xsl:param name="line" />
		<xsl:if test="$line != ''">
			<xsl:variable name="param"
				select="normalize-space(substring-before($line,';'))" />
			<xsl:call-template name="parse-param">
				<xsl:with-param name="param" select="$param" />
			</xsl:call-template>
			<xsl:variable name="rest"
				select="normalize-space(substring-after($line,';'))" />
			<xsl:call-template name="parse-style">
				<xsl:with-param name="line" select="$rest" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="parse-param">
		<xsl:param name="param" />
		<xsl:variable name="name"
			select="normalize-space(substring-before($param,':'))" />
		<xsl:variable name="value"
			select="normalize-space(substring-after($param,':'))" />
		<xsl:choose>
			<!-- ignore any px -->
			<xsl:when test="contains($value,'px') and $name = 'width'" />

			<xsl:when test="$name = 'background-color'">
				<xsl:attribute name="background-color">
					<xsl:value-of select="$value" />
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="$name = 'width'">
				<xsl:attribute name="width">
					<xsl:value-of select="$value" />
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="$name = 'height'">
				<xsl:attribute name="height">
					<xsl:value-of select="$value" />
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="$name = 'text-align'">
				<xsl:attribute name="text-align">
					<xsl:value-of select="$value" />
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="$name = 'font-size'">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$value" />
				</xsl:attribute>
			</xsl:when>
			<xsl:when test="$name = 'color'">
				<xsl:attribute name="color">
					<xsl:value-of select="$value" />
				</xsl:attribute>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="hr">
		<fo:block>
			<fo:leader leader-pattern="rule" leader-length.optimum="100%"
				rule-style="double" leader-length="5cm" rule-thickness="1pt" />
		</fo:block>
	</xsl:template>

</xsl:stylesheet>
