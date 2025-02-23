<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="3.0">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:param name="param-test" select="'not-set'" />
  <xsl:param name="query-param" select="'not-set'" />
  
  <xsl:template match="/">
    <data xmlns="" >
      <u><xsl:value-of select="$param-test" /></u>
      <u><xsl:value-of select="$query-param" /></u>
      <xsl:for-each select="./*/*" >
	<xsl:element name="{local-name()}" >
	  <xsl:apply-templates select="*:option" />
	</xsl:element>
      </xsl:for-each>

    </data>


           


    


  </xsl:template>
  
  <xsl:template match="*:option">
    <o><xsl:value-of select="./*:label/text()" />
    </o>
  </xsl:template>
  
  <xsl:template match="text()"></xsl:template>

</xsl:stylesheet>



