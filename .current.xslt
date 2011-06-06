<!-- XSLT to translate XML reponse from www.google.com/ig/ XML weather API.
     Extracts current conditions data. -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" > 
	<xsl:output method="text" disable-output-escaping="yes"/>
	<xsl:template match="xml_api_reply">
		<xsl:apply-templates select="problem_cause"/>
		<xsl:apply-templates select="weather"/>
	</xsl:template>

	<xsl:template match="weather">
		<xsl:variable name="newline"><xsl:text>&#10;</xsl:text></xsl:variable>
		<xsl:text>Location: </xsl:text><xsl:value-of select ="forecast_information/city/@data"/>
		<xsl:value-of select="$newline" />
		<xsl:text>Temperature: </xsl:text><xsl:value-of select="current_conditions/temp_c/@data"/> <xsl:text>°C</xsl:text>
		<xsl:text> (</xsl:text><xsl:value-of select="current_conditions/temp_f/@data"/><xsl:text>°F)</xsl:text>
		<xsl:value-of select="$newline"/>
		<xsl:text>Conditions: </xsl:text><xsl:value-of select="current_conditions/condition/@data"/>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="current_conditions/humidity/@data"/>
		<xsl:value-of select="$newline"/>
		<xsl:value-of select="current_conditions/wind_condition/@data"/>
		<xsl:value-of select="$newline"/>
	</xsl:template>
</xsl:stylesheet>
