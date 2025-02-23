<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
    version="3.0" 
    >
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>


  <xsl:template
      match="Objective"
      >
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:variable name="successes" select="count(PerformanceIndicator[rsu:stats/@success='true'])"  />

      <xsl:variable name="failures" select="count(PerformanceIndicator[rsu:stats/@success='false'])"  />
      <xsl:variable name="blanks" select="count(PerformanceIndicator[rsu:stats/@success=''])"  />
      <xsl:variable name="total" select="$successes + $failures +  $blanks"  />

      <xsl:choose>
	<xsl:when
	    test="$total = 0" >
	  <rsu:stats success="" indicators="0" />
	</xsl:when>
	<xsl:otherwise >
	  <rsu:stats success="{($successes div $total) > 0.85}" total="{$total}"
		     successes="{$successes}" failures="{$failures}" blanks="{$blanks}" >
	  </rsu:stats>
	</xsl:otherwise>
      </xsl:choose>

      <xsl:apply-templates select="element()|text()"/>

    </xsl:copy>
  </xsl:template>

  <xsl:template match="element()|@*|text()" >
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
