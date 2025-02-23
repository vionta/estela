<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="3.0">

  <xsl:output method="xml" encoding="utf-8" indent="yes"/>

  <xsl:template match="/">
    <data xmlns="" >
      <xsl:apply-templates select="/*/*" />
    </data>
  </xsl:template>
  
  <xsl:template match="*:issue">
    <option>
      <value><xsl:value-of select="code/text()" /></value>
      <label><xsl:value-of select="name/text()" /></label>
    </option>
  </xsl:template>
  
  <xsl:template match="text()"></xsl:template>

</xsl:stylesheet>
