<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
    version="3.0" 
    >
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <!--
      <success-criteria>
      <option><value>bigger</value><label>Bigger Than</label></option>
      <option><value>smaller</value><label>Smaller Than</label></option>
      <option><value>equals-or-bigger</value><label>Equals or Bigger Than</label></option>
      <option><value>equals-or-smaller</value><label>Equals or Smaller Than</label></option>
      <option additional-reference="true" ><value>closer-than</value><label>Closer than</label></option>
      <option><value>sooner</value><label>Sooner Than</label></option>
      <option><value>later</value><label>Later Than</label></option>
      </success-criteria>
  -->
  
  <!-- Reference ......................................... -->


  <!-- Bigger ............................................ -->
  <xsl:template
      match="*:success-criteria[@type = 'bigger']"
      >
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:choose>
	<xsl:when
	    test="number(../MeasurementInstance/TargetResult/NumberOfUnits) > number(../MeasurementInstance/ActualResult/NumberOfUnits)" >
	    <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" >false</xsl:attribute>
	</xsl:when>
	<xsl:when
	    test="boolean(../MeasurementInstance/TargetResult/NumberOfUnits) and boolean(../MeasurementInstance/ActualResult/NumberOfUnits)" >
	    <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" >true</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" ></xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>


      <xsl:apply-templates select="element()|text()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Equals or Bigger ............................................ -->    
  <xsl:template
      match="*:success-criteria[@type = 'equals-or-bigger']"
      >
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:choose>
	<xsl:when
	    test="number(../MeasurementInstance/TargetResult/NumberOfUnits) >= number(../MeasurementInstance/ActualResult/NumberOfUnits)" >
	    <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" >false</xsl:attribute>
	</xsl:when>
	<xsl:when
	    test="boolean(../MeasurementInstance/TargetResult/NumberOfUnits) and boolean(../MeasurementInstance/ActualResult/NumberOfUnits)" >
	    <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" >true</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" ></xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>


      <xsl:apply-templates select="element()|text()"/>
    </xsl:copy>
  </xsl:template>


  <!-- Smaller  ............................................ -->
  <xsl:template
      match="*:success-criteria[@type = 'smaller']"
      >
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:choose>
	<xsl:when
	    test="number(../MeasurementInstance/ActualResult/NumberOfUnits) > number(../MeasurementInstance/TargetResult/NumberOfUnits) " >
	    <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" >false</xsl:attribute>
	</xsl:when>
	<xsl:when
	    test="boolean(../MeasurementInstance/TargetResult/NumberOfUnits) and boolean(../MeasurementInstance/ActualResult/NumberOfUnits)" >
	    <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" >true</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" ></xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>


      <xsl:apply-templates select="element()|text()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Equals or Smaller  ............................................ -->
  <xsl:template
      match="*:success-criteria[@type = 'equals-or-smaller']"
      >
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:choose>
	<xsl:when
	    test="number(../MeasurementInstance/TargetResult/NumberOfUnits) >= number(../MeasurementInstance/ActualResult/NumberOfUnits)" >
	    <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" >false</xsl:attribute>
	</xsl:when>
	<xsl:when
	    test="boolean(../MeasurementInstance/TargetResult/NumberOfUnits) and boolean(../MeasurementInstance/ActualResult/NumberOfUnits)" >
	    <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" >true</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="success" namespace="http://www.vionta.net/xsd/stratml-results/1.0" ></xsl:attribute>
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
