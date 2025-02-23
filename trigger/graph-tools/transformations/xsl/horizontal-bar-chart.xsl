<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    version="3.0" 
    >

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template
      name="horizontal-bar-chart"
      >
    <xsl:param name="threshold" select="85" />
    <xsl:param name="stats" />
    <svg
   width="200"
   height="20"
   viewBox="0 0 105.83333 30.916667"
   version="1.1"
   id="svg5"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">


      <xsl:comment>
Suc:	<xsl:value-of select="number(rsu:stats/@successes)" ></xsl:value-of>
Fail:	<xsl:value-of select="number(rsu:stats/@failures)" ></xsl:value-of>
Blanks:	<xsl:value-of select="number(rsu:stats/@blanks)" ></xsl:value-of>
Total:	<xsl:value-of select="number(rsu:stats/@total)" ></xsl:value-of>
      </xsl:comment>
        <g
     inkscape:label="Layer 1"
     inkscape:groupmode="layer"
     id="layer1">
    <rect
       style="fill:#f6f6f6;stroke-width:0"
       id="background"
       height="20"
       width="204"
       x="0"
       y="0" />

	  <rect
       style="fill:#000000;stroke-width:1"
       id="half-ruler"
       height="20"
       width="0.6677864"
       x="100"
       y="0" />
    <rect
       style="fill:#000000;stroke-width:1"
       id="threshold-ruler"
       height="20"
       width="0.6677864"
       x="180"
       y="0" />
    
      <xsl:call-template name="horizontal-bar" >
	<xsl:with-param name="value" select="( number(rsu:stats/@successes) div number(rsu:stats/@total) ) * 100" />
	<xsl:with-param name="position" select="104" />
	<xsl:with-param name="total" select="number(rsu:stats/@total)" />
	<xsl:with-param name="color" select="'#129912'" />  
      </xsl:call-template>

      <xsl:call-template name="horizontal-bar" >
	<xsl:with-param name="value" select="((number(rsu:stats/@failures)  div number(rsu:stats/@total)) * 100) " />
	<xsl:with-param name="position" select="102 - ((number(rsu:stats/@failures)  div number(rsu:stats/@total)) * 100)" />
	<xsl:with-param name="total" select="number(rsu:stats/@total)" />
	<xsl:with-param name="color" select="'#991212'" />  
      </xsl:call-template>
      
      <xsl:call-template name="horizontal-bar" >
	<xsl:with-param name="value" select="((number(rsu:stats/@blanks)  div number(rsu:stats/@total)) * 100)" />
	<xsl:with-param name="position" select="100 - (((number(rsu:stats/@failures) + number(rsu:stats/@blanks) ) div number(rsu:stats/@total)) * 100)" />
	<xsl:with-param name="total" select="number(rsu:stats/@total)" />
	<xsl:with-param name="color" select="'#cccccc'" />  
      </xsl:call-template>

      <xsl:call-template name="horizontal-bar" >
	<xsl:with-param name="value" select="(number(rsu:stats/@total) - (number(rsu:stats/@successes) + number(rsu:stats/@failures) + number(rsu:stats/@blanks)) )" />
	<xsl:with-param name="position" select="1" />
	<xsl:with-param name="total" select="number(rsu:stats/@total)" />
	<xsl:with-param name="color" select="'#333333'" />  
      </xsl:call-template>
	</g>
    </svg>
    
  </xsl:template>
  
  <xsl:template
      name="horizontal-bar"
      >
      
    <xsl:param name="value"  />
    <xsl:param name="position"  />
    <xsl:param name="total"  />
    <xsl:param name="color" />
    <!--
    <xsl:variable name="length" select="round(($value div $total) * 30)" />
-->
    <rect xmlns="http://www.w3.org/2000/svg"
       style="fill:{$color};stroke-width:10"
       id="rect29{$position}"
       height="16"
       width="{$value}"
       x="{$position}"
       y="2"
       ry="0" />


  </xsl:template>
  
</xsl:stylesheet>
