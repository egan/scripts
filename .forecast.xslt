<!-- XSLT to translate XML reponse from www.google.com/ig/ XML weather API.
     Extracts forecast data. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" > 
	<xsl:output method="text" disable-output-escaping="yes"/>
	<xsl:template match="xml_api_reply">
		<xsl:apply-templates select="weather"/>
	</xsl:template>
	
	<xsl:template match="weather">
		<xsl:variable name="unit_system" select="forecast_information/unit_system/@data"/>
		<xsl:variable name="newline"><xsl:text>&#10;</xsl:text></xsl:variable>
		<xsl:text>Location: </xsl:text><xsl:value-of select="forecast_information/city/@data"/>
		
		<xsl:for-each select="forecast_conditions">
			<xsl:value-of select="$newline"/>
			<xsl:value-of select="day_of_week/@data"/><xsl:text>: </xsl:text>
			<xsl:value-of select="$newline"/>
			<xsl:choose>
				<xsl:when test="$unit_system != 'SI'">
					<xsl:text>    Conditions: </xsl:text>
					<xsl:value-of select="condition/@data"/>
					<xsl:value-of select="$newline"/>
					<xsl:text>    Temperature: </xsl:text>
					<xsl:value-of select="round(((number(low/@data)-32)*5)div9)"/><xsl:text>°C</xsl:text>
					<xsl:text> (</xsl:text><xsl:value-of select="low/@data"/><xsl:text>°F)</xsl:text>
					<xsl:value-of select="$newline"/>
					<xsl:text>                 </xsl:text>
					<xsl:value-of select="round(((number(high/@data)-32)*5)div9)"/><xsl:text>°C</xsl:text>
					<xsl:text> (</xsl:text><xsl:value-of select="high/@data"/><xsl:text>°F)</xsl:text>
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>    Conditions: </xsl:text>
					<xsl:value-of select="condition/@data"/>
					<xsl:value-of select="$newline"/>
					<xsl:text>    Temperature: </xsl:text>
					<xsl:value-of select="low/@data"/><xsl:text>°C</xsl:text>
					<xsl:text> (</xsl:text><xsl:value-of select="round(((number(low/@data)*9)div5)+32)"/><xsl:text>°F)</xsl:text>
					<xsl:value-of select="$newline"/>
					<xsl:text>                 </xsl:text>
					<xsl:value-of select="high/@data"/><xsl:text>°C</xsl:text>
					<xsl:text> (</xsl:text><xsl:value-of select="round(((number(high/@data)*9)div5)+32)"/><xsl:text>°F)</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:value-of select="$newline"/>
	</xsl:template>
</xsl:stylesheet>
