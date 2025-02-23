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
      name="stats-bar-chart"
      >
    <xsl:param name="threshold" select="85" />
    <xsl:param name="stats" />
    <svg
   width="100"
   height="50"
   viewBox="0 0 105.83333 52.916667"
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
       style="fill:#103265;stroke-width:0.5"
       id="rect234"
       width="91.374275"
       height="0.4677864"
       x="6.5490093"
       y="40.0737" />
    <rect
       style="fill:#808080;stroke-width:0.5"
       id="rect236"
       width="90.282768"
       height="0.15592879"
       x="7.640511"
       y="13.409877" />
    
      <xsl:call-template name="bar" >
	<xsl:with-param name="value" select="number(rsu:stats/@successes)" />
	<xsl:with-param name="position" select="4" />
	<xsl:with-param name="total" select="number(rsu:stats/@total)" />
	<xsl:with-param name="color" select="'#129912'" />  
      </xsl:call-template>

      <xsl:call-template name="bar" >
	<xsl:with-param name="value" select="number(rsu:stats/@failures)" />
	<xsl:with-param name="position" select="3" />
	<xsl:with-param name="total" select="number(rsu:stats/@total)" />
	<xsl:with-param name="color" select="'#991212'" />  
      </xsl:call-template>
      
      <xsl:call-template name="bar" >
	<xsl:with-param name="value" select="number(rsu:stats/@blanks)" />
	<xsl:with-param name="position" select="2" />
	<xsl:with-param name="total" select="number(rsu:stats/@total)" />
	<xsl:with-param name="color" select="'#555555'" />  
      </xsl:call-template>

      <xsl:call-template name="bar" >
	<xsl:with-param name="value" select="(number(rsu:stats/@total) - (number(rsu:stats/@successes) + number(rsu:stats/@failures) + number(rsu:stats/@blanks)) )" />
	<xsl:with-param name="position" select="1" />
	<xsl:with-param name="total" select="number(rsu:stats/@total)" />
	<xsl:with-param name="color" select="'#333333'" />  
      </xsl:call-template>
	</g>
    </svg>
    
  </xsl:template>
  
  <xsl:template
      name="bar"
      >
      
    <xsl:param name="value"  />
    <xsl:param name="position"  />
    <xsl:param name="total"  />
    <xsl:param name="color" />
    
    <xsl:variable name="length" select="round(($value div $total) * 30)" />

    <rect
       style="fill:{$color};stroke-width:0"
       id="rect29{$position}"
       width="10"
       height="{$length}"
       x="{20 * $position}"
       y="{40 - $length}"
       ry="0" />


  </xsl:template>
  
</xsl:stylesheet>
