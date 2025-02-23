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
      name="pie-chart-normal"
      >

    <xsl:param name="threshold" select="85" />
    <xsl:param name="stats" />

    <svg width="110px" height="110px"
	 viewBox="0.00 0.00 420.00 220.00"
	 xmlns="http://www.w3.org/2000/svg"
	 xmlns:xlink="http://www.w3.org/1999/xlink"> 

      <!--
	  {$pie}{$leg}{$cols}
      -->

      <xsl:comment> ......... <xsl:value-of select="string($stats/@*:successes)" />
      - <xsl:value-of select="string($stats/@*:failures)" />
      - <xsl:value-of select="string($stats/@*:blanks)" /> ..............    </xsl:comment>

      <xsl:copy-of select="*:stats" ></xsl:copy-of>
      <xsl:variable name="centerX" select="110"  />
      <xsl:variable name="centerY" select="110"  />
      <xsl:variable name="radius" select="100"  />

      <!-- .......... Successes ........... -->
      <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="pre" select="0" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10 " />
	<xsl:with-param name="color" select="'#129912'" />  
      </xsl:call-template>

      <!-- .......... Failures ........... -->
      <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@failures) * 10" />
	<xsl:with-param name="pre" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#991212'" />  
      </xsl:call-template>
      
      <!-- .......... Blanks ........... -->
      <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@blanks) * 10" />
	<xsl:with-param name="pre" select="(number(rsu:stats/@successes) + number(rsu:stats/@failures)) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#555555'" />  
      </xsl:call-template>

    </svg>

  </xsl:template>


  <xsl:template
      name="pie-chart"
      >
    <xsl:param name="threshold" select="85" />
    <xsl:param name="stats" />
    <div  >

  <svg width="110px" height="110px"
	 viewBox="0.00 0.00 420.00 220.00"
	 xmlns="http://www.w3.org/2000/svg"
	 xmlns:xlink="http://www.w3.org/1999/xlink"> 

      <!--
	  {$pie}{$leg}{$cols}
      -->

      <xsl:comment> ......... <xsl:value-of select="string($stats/@*:successes)" />
      - <xsl:value-of select="string($stats/@*:failures)" />
      - <xsl:value-of select="string($stats/@*:blanks)" /> ..............    </xsl:comment>

      <xsl:copy-of select="*:stats" ></xsl:copy-of>
      <xsl:variable name="centerX" select="110"  />
      <xsl:variable name="centerY" select="110"  />
      <xsl:variable name="radius" select="100"  />

      <!-- .......... Successes ........... 
      <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="pre" select="0" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10 " />
	<xsl:with-param name="color" select="'#129912'" />  
      </xsl:call-template>
      -->
      
      <!-- .......... Failures ........... 
      <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@failures) * 10" />
	<xsl:with-param name="pre" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#991212'" />  
	</xsl:call-template>
	-->
      
      <!-- .......... Blanks ........... -->
   <!--   <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@blanks) * 10" />
	<xsl:with-param name="pre" select="(number(rsu:stats/@successes) + number(rsu:stats/@failures)) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#555555'" />  
      </xsl:call-template>
-->
    </svg>

    <!--
    <div>
      <textarea>      

      <xsl:call-template name="pie-part-log" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="pre" select="0" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10 " />
	<xsl:with-param name="color" select="'#129912'" />  
      </xsl:call-template>
      </textarea>
      <textarea>

      <xsl:call-template name="pie-part-log" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@failures) * 10" />
	<xsl:with-param name="pre" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#991212'" />  
      </xsl:call-template>
      </textarea>
      <textarea>
      <xsl:call-template name="pie-part-log" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@blanks) * 10" />
	<xsl:with-param name="pre" select="(number(rsu:stats/@successes) + number(rsu:stats/@failures)) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#555555'" />  
      </xsl:call-template>
      </textarea>
      -->

    </div>

  </xsl:template>


  
  <xsl:template
      name="pie-part"
      >

    <xsl:param name="centerX"  />
    <xsl:param name="centerY"  />
    <xsl:param name="radius"  />
    <xsl:param name="value"  />
    <xsl:param name="pre"  />
    <xsl:param name="total"  />
    <xsl:param name="color" />
    
    <xsl:variable name="startAngle" select="round(($pre div $total) * 360)" />
    <xsl:variable name="endAngle" select="round( (($pre + $value) div $total) * 360)"  />

    <xsl:variable name="startAngleRadians" select="(xsd:double($startAngle) * math:pi() ) div 180.0" />
    <xsl:variable name="endAngleRadians" select=" (xsd:double($endAngle) * math:pi() ) div 180.0" />
    
    <xsl:variable name="inArc"  >
      <xsl:choose>
	<xsl:when test="($endAngle - $startAngle ) >= 180" >0</xsl:when>
	<xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:comment>
      centerX: <xsl:value-of select="$centerX" ></xsl:value-of>
      radius: <xsl:value-of select="$radius" ></xsl:value-of>
      value: -<xsl:value-of select="$value" ></xsl:value-of>-
      pre: -<xsl:value-of select="$pre" ></xsl:value-of>-
      total: -<xsl:value-of select="$total" ></xsl:value-of>-
      Start Ang Radiuns: <xsl:value-of select="$startAngleRadians " ></xsl:value-of>
      Calculation: <xsl:value-of select="$radius * math:cos($startAngleRadians) " ></xsl:value-of>
    </xsl:comment>

    <path xmlns="http://www.w3.org/2000/svg"
	  d=" M 0,0  {$radius * math:cos($startAngleRadians)},{$radius * math:sin($startAngleRadians)} A 100 100 0 0 {$inArc}  {$radius * math:cos($endAngleRadians)} {$radius * math:sin($endAngleRadians)} l   {$radius * math:cos($endAngleRadians)},{$radius * math:sin($endAngleRadians)} z " 
	  transform="scale(1 1) rotate(1) translate({$centerX} {$centerY})"		
	  style="color:#0000ff;fill:{$color};fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
	  
	  />

  </xsl:template>
  
</xsl:stylesheet>
