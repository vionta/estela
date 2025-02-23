<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
    version="3.0" 
    >
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <!-- Bigger ............................................ -->

  <xsl:template
      match="PerformanceIndicator"
      >
    <xsl:copy>
      <xsl:copy-of select="@*[not(rsu:result)]" />

      <xsl:variable name="success-criteria-failure" select="boolean(string(./*:success-criteria/@rsu:success) = 'false')" />
      <xsl:variable name="success-criteria-success" select="boolean(string(./*:success-criteria/@rsu:success) = 'true')" />

      <xsl:choose>
	<xsl:when
	    test="boolean($success-criteria-failure)" >
	  <rsu:stats success="false" >
	    <xsl:apply-templates select="." mode="stats" />
	  </rsu:stats>
	</xsl:when>
	<xsl:when
	    test="boolean($success-criteria-success)" >
	  <rsu:stats success="true" >
	    <xsl:apply-templates select="." mode="stats" />
	  </rsu:stats>
	</xsl:when>

	<xsl:when test="not($success-criteria-failure)
			and boolean(@rsu:result-level) " >

	  <xsl:variable
	      name="success-criteria-failure"
	      select=" string(@rsu:result-level) = 'remarkable' or string(@rsu:result-level) = 'expected' " />
	  <rsu:stats success="{$success-criteria-failure}" >
	    <xsl:apply-templates select="." mode="stats" />

	  </rsu:stats>
	</xsl:when>
	<xsl:otherwise>
	  <rsu:stats success="" >
	    <xsl:apply-templates select="." mode="stats" />
	  </rsu:stats>
	</xsl:otherwise>
      </xsl:choose>

      <xsl:apply-templates select="element()|text()"/>

    </xsl:copy>

  </xsl:template>

  <xsl:template
      match="PerformanceIndicator"
      mode="stats" >
    <rsu:reference-levels count="{count(reference)}" />
    <rsu:success-criteria count="{count(success-criteria)}" />
    <rsu:plan-elements
	actualResults="{count(.//ActualResult)}"
	targetResults="{count(.//TargetResult)}" />
  </xsl:template>

  <xsl:template match="element()|@*|text()" >
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
