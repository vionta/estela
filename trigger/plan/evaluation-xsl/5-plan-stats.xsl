<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
    version="3.0" 
    >
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template
      match="PerformancePlanOrReport"
      >
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:variable name="successes" select="count(Goal[rsu:stats/@success='true'])"  />
      <xsl:variable name="failures" select="count(Goal[rsu:stats/@success='false'])"  />
      <xsl:variable name="blanks" select="count(Goal[rsu:stats/@success=''])"  />
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
      <!--
      <rsu:average>
	<xsl:variable name="av-successes" select="100 * count(.//PerformanceIndicator[rsu:stats/@success='true'])"  />
      <xsl:variable name="av-failures" select="100 * count(.//PerformanceIndicator[rsu:stats/@success='false'])"  />
      <xsl:variable name="av-blanks" select="100 * count(.//PerformanceIndicator[rsu:stats/@success=''])"  />
      <xsl:variable name="av-total" select="$av-successes + $av-failures +  $av-blanks"  />

      <xsl:choose>
	<xsl:when
	    test="$av-total = 0" >
	  <rsu:stats success="" indicators="0" />
	</xsl:when>
	<xsl:otherwise >
	  <rsu:stats success="{($av-successes div $av-total) > 0.85}" total="{$av-total}"
		     successes="{$av-successes}" failures="{$av-failures}" blanks="{$av-blanks}" >
	  </rsu:stats>
	</xsl:otherwise>
      </xsl:choose>
      </rsu:average>
-->
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
