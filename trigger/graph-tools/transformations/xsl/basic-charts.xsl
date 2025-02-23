<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    version="3.0" 
    >

  <!--  import module namespace math="http://exslt.org/math";
  -->
  <xsl:import href="color-functions.xsl" />  

  <!--  import module namespace math="http://exslt.org/math";  -->
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  
  <xsl:template name="svg-pie-chart" >
    <!-- A basic structure with elements with
	 key and value attributes --> 
    <xsl:param name="data" />
    <!-- A name for the color pallete -->
    <xsl:param name="color" />
    <!-- The chart title/legend -->
    <xsl:param name="title" />
    <!-- The size of the pie chart -->
    <xsl:param name="radius" />
    <svg width="{2 * $radius + 130}px" height="{2 * $radius + 30}px"
	 viewBox="0.00 0.00 {2 * $radius + 130}.00 {2 * $radius + 30}.00"
	 xmlns="http://www.w3.org/2000/svg"
	 xmlns:xlink="http://www.w3.org/1999/xlink">
      <xsl:comment>
	DATA
	<xsl:for-each select="$data/data/*" >
	  <xsl:value-of select="concat('\n' , @key)" ></xsl:value-of> 	  <xsl:value-of select="concat(' ' , @value)" ></xsl:value-of>
	</xsl:for-each>
	
	Elementos <xsl:value-of select="count($data/data/*)" />
	
      </xsl:comment>
      <xsl:call-template name="pieTitledChart" >
	<xsl:with-param name="dataSrc" select="$data" />
	<xsl:with-param name="color" select="$color" />
	<xsl:with-param name="title" select="$title" />
	<xsl:with-param name="radius" select="$radius" />
      </xsl:call-template>
    </svg>
  </xsl:template>


  
  <xsl:template name="pieTitledChart" >
    <!-- A basic structure with elements with
	 key and value attributes --> 
    <xsl:param name="dataSrc" />
    <!-- A name for the color pallete -->
    <xsl:param name="color" />
    <!-- The chart title/legend -->
    <xsl:param name="title" />
    <!-- The size of the pie chart -->
    <xsl:param name="radius" />

    <xsl:variable name="data" >
      <xsl:call-template name="getItemPositions" >
	<xsl:with-param name="dataSrc" select="$dataSrc" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="total" select="sum($data/data/entry/@value)"  />
 
    <xsl:variable name="pie" >
      <xsl:for-each select="$data/data/*" >
	<xsl:variable name="value" select="./@value" />
	<xsl:variable name="i" select="." />
	<xsl:variable name="pre" select="sum($data/data/*[$i/@position > @position]/@value)" />
	<xsl:variable name="startAngle" select="round(($pre div $total) * 360)" />
	<xsl:variable name="endAngle" select="round( (($pre + $value) div $total) * 360)" />

	<!--
	<xsl:variable name="inArc" >
	  <xsl:choose>
	    <xsl:when test="($endAngle - $startAngle ) >= 180 " >0
	    </xsl:when>
	    <xsl:otherwise>1</xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	-->

	<!--
	<xsl:variable name="startAngleRadians" select="( number($startAngle) * math:pi() ) div 180.0" />
	<xsl:variable name="endAngleRadians" select="(number($endAngle) * math:pi() ) div 180.0" />
	-->
	<xsl:variable name="graphcolorVariable" >
	  <xsl:call-template name="graphcolor" >
	    <xsl:with-param name="type" select="$color" />
	    <xsl:with-param name="position" select="number($i/@position)" />
	  </xsl:call-template>
	</xsl:variable>

	<xsl:comment>Debug
	  Color: <xsl:value-of select="$color" />
	  Position: <xsl:value-of select="number($i/@position) " />
	  Variable: <xsl:value-of select="graphcolorVariable" />
	</xsl:comment>
	    
	<xsl:call-template name="piePart" >
	  <xsl:with-param name="centerX" select="($radius + 10)" />
	  <xsl:with-param name="centerY" select="($radius + 10)" />
	  <xsl:with-param name="radius" select="$radius" />
	  <xsl:with-param name="startAngle" select="$startAngle" />
	  <xsl:with-param name="endAngle" select="$endAngle" />
	  <xsl:with-param name="color" select="$graphcolorVariable" />
	</xsl:call-template>
      </xsl:for-each>


      <circle cx="{$radius + 10}" cy="{$radius + 30}" r="{round ( $radius * 0.7) }" style="color:#ffffff;fill:#ffffff;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
		xmlns="http://www.w3.org/2000/svg" />

    </xsl:variable>

    <xsl:variable name="leg" >
      <xsl:for-each select="$data/data/*">
	<xsl:variable name="t" select="." />
	<text xmlns="http://www.w3.org/2000/svg"
	      x="{(2 * $radius) + 45 }"
	      y="{50+10 *$t /@position}"
	      style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Helvetica;-inkscape-font-specification:Franklin Gothic Medium Cond"
	      >
	  <xsl:value-of select="string($t/@key)" />
	</text> 
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="cols" >
      <xsl:for-each select="$data/data/*">
	<xsl:variable name="q" select="." />
	<xsl:variable name="graphColorVar" >
	  <xsl:call-template name="graphcolor" >
	    <xsl:with-param name="type" select="$color" />
	    <xsl:with-param name="position" select="number($q/@position)" />
	  </xsl:call-template>
	</xsl:variable>
	<path  xmlns="http://www.w3.org/2000/svg" d=" M 0,0  10,0 10,10 0,10 z "
	       transform="scale(1 1) rotate(1) translate({(2 * $radius) + 30 } , {(40+10 * $q/@position)})"
	       style="color:#0000ff;fill:{$graphColorVar};fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate" />
      </xsl:for-each>
    </xsl:variable>

    <xsl:copy-of select="$pie" />
    <xsl:copy-of select="$leg" />
    <xsl:copy-of select="$cols" />
    
    <text xmlns="http://www.w3.org/2000/svg"
	  x="20"
	  y="20"
	  style="font-size:12px;font-style:bold;font-variant:normal;font-weight:bold;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Arial;-inkscape-font-specification:Franklin Gothic Medium Cond"
	  >
      <xsl:value-of select="$title" />
    </text>


  </xsl:template>

  <xsl:template name="pieChart" >
    <xsl:param name="dataSrc" />
    <xsl:param name="color" />
    <xsl:variable name="data" >
      <xsl:call-template name="getItemPositions" >
	<xsl:with-param name="dataSrc" select="$dataSrc" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="total" select="sum($data/data/*/@value)" >
    </xsl:variable>
    <xsl:variable name="pie" >
      <xsl:for-each select="$data/data/*">
	<xsl:variable name="value" select="./@value" >
	</xsl:variable>
      <!-- Este i hay que revisarlo -->
	<xsl:variable name="i" select="." >
	</xsl:variable>
      <xsl:variable name="pre" select="sum($data/data/*[   $i/@position > @position  ]/@value)" />
      <xsl:variable name="startAngle" select="round(($pre div $total) * 360)"  />
      <xsl:variable name="endAngle" select="round( (($pre + $value) div $total) * 360)" />
<!--
      <xsl:variable name="inArc" >
	<xsl:choose>
	  <xsl:when test="(($endAngle - $startAngle ) >= 180 )" >0
	  </xsl:when>
	  <xsl:otherwise>1
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:variable>
      <xsl:variable name="startAngleRadians" select="( number($startAngle) * math:pi() ) div 180.0" />
      <xsl:variable name="endAngleRadians" select="(number($endAngle) * math:pi() ) div 180.0 " />
      -->
      <xsl:variable name="graphColor" >
	<xsl:call-template name="graphcolor" >
	  <xsl:with-param name="type" select="$color" />
	  <xsl:with-param name="position" select="number(./@position) -1 " />
	</xsl:call-template>
      </xsl:variable>
      <xsl:call-template name="piePart" >
	<xsl:with-param name="centerX" select="110" />
	<xsl:with-param name="centerY" select="110" />
	<xsl:with-param name="radius" select="100" />
	<xsl:with-param name="startAngle" select="$startAngle" />
	<xsl:with-param name="endAngle" select="$endAngle" />
	<xsl:with-param name="color" select="$graphColor" />
      </xsl:call-template>  
      </xsl:for-each>
    </xsl:variable>

	<xsl:variable name="leg" >
	  <xsl:for-each select="$data/*">
      <text xmlns="http://www.w3.org/2000/svg"
	    x="250"
	    y="{30+10 * ./@position}"
	    style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Franklin Gothic Medium Cond;-inkscape-font-specification:Franklin Gothic Medium Cond"
	    >
	<xsl:value-of select="string(./@key)" >
	</xsl:value-of>
      </text>
	  </xsl:for-each>
	</xsl:variable>

	<xsl:variable name="cols" >
	  <xsl:for-each select="$data/data/*">
	<xsl:variable name="q" select="." />
	<xsl:variable name="graphcolorVari" >
	  <xsl:call-template name="graphcolor" >
	    <xsl:with-param name="type" select="$color" />
	    <xsl:with-param name="position" select="number($q/@position) -1 " />
	  </xsl:call-template>
	</xsl:variable>
	<path  xmlns="http://www.w3.org/2000/svg"
	       d=" M 0,0  10,0 10,10 0,10 z "
	       transform="scale(1 1) rotate(1) translate(230, {20+10 *$q/@position})"
	       style="color:#0000ff;fill:{$graphcolorVari};fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
	       />
	  </xsl:for-each>
	</xsl:variable>		

	<join>
	  <xsl:copy-of select="$pie" />
	  <xsl:copy-of select="$leg" />
	  <xsl:copy-of select="$cols" />
	</join>    
  </xsl:template>


  <!-- Pie Part -->
  <xsl:template name="piePart" >
    <xsl:param name="centerX"  />
    <xsl:param name="centerY" />
    <xsl:param name="radius"  />
    <xsl:param name="startAngle"  />
    <xsl:param name="endAngle"  />
    <xsl:param name="color"  />
    <xsl:comment>Debug
    Start Angle: <xsl:value-of select="$startAngle" />
    End: <xsl:value-of select="$endAngle" />
    Diff: <xsl:value-of select="$endAngle - $startAngle" />
    </xsl:comment>
    <xsl:variable name="inArc" >
      <xsl:choose>
	<xsl:when test="(($endAngle - $startAngle ) >= 180 )" >1</xsl:when>
	<xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!--
    <xsl:variable name="shortArc" >
      <xsl:choose>
	<xsl:when test="(($endAngle - $startAngle ) >= 180 )" >1</xsl:when>
	<xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    -->
    
    <xsl:variable name="endAngleRadians" select="( number($startAngle -90) * math:pi() ) div 180.0" />
    <xsl:variable name="startAngleRadians" select="((number($endAngle) -90) * math:pi() ) div 180.0" />   


    <xsl:choose>
      <xsl:when test="($startAngle = 0) and ( $endAngle = 360)" >
	<circle cx="{$centerX}" cy="{$centerY + 20}" r="{$radius}" style="color:#0000ff;fill:{$color};fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
		xmlns="http://www.w3.org/2000/svg" />
      </xsl:when>
      <xsl:otherwise>
	<path xmlns="http://www.w3.org/2000/svg"
	      d=" M {$centerX},{$centerY + 20} {$centerX + round($radius * math:cos($endAngleRadians))},{$centerY + 20 + round($radius * math:sin($endAngleRadians))}
		 A {$radius} {$radius} 0 {$inArc} 1
		 {$centerX + round($radius * math:cos($startAngleRadians))},{$centerY + 20 + round($radius * math:sin($startAngleRadians))} z "

	  style="color:#0000ff;fill:{$color};fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate" />
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <!-- Polar to cartesian -->
  <xsl:template name="polarToCartesian" >
    <xsl:param name="centerX"  />
    <xsl:param name="centerY"  />
    <xsl:param name="radius"  />
    <xsl:param name="angleInDegrees"  />
    <xsl:variable name="angleInRadians" select="($angleInDegrees - 90) * 3.14 div 180.0" >
    </xsl:variable>
    <xsl:variable name="coords" >
      <coords    x="{$centerX + ($radius * math:cos(3.12))}" y="{$centerY + ($radius * math:sin(1.92))}"  >
	<x>
	  <xsl:value-of select="$centerX + ($radius * math:cos(3.12))" />
	</x>
	<y>
	  <xsl:value-of select="$centerY + ($radius * math:sin(1.92))" />
	</y>
      </coords>
    </xsl:variable>
    <xsl:copy-of select="$coords" />
  </xsl:template>

  <!-- Describe Arc -->
  <xsl:template name="describeArc" >
    <xsl:param name="x" />
  <xsl:param name="y"  />
  <xsl:param name="radius"  />
  <xsl:param name="startAngle"  />
  <xsl:param name="endAngle"  />
  <xsl:variable name="start" >
    <xsl:call-template name="polarToCartesian" >
      <xsl:with-param name="centerX" select="$x" /> 
      <xsl:with-param name="centerY" select="$y" /> 
      <xsl:with-param name="radius" select="$radius" /> 
      <xsl:with-param name="angleInDegrees" select="$endAngle" /> 
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="end" >
    <xsl:call-template name="polarToCartesian" >
    <xsl:with-param name="centerX" select="$x" /> 
    <xsl:with-param name="centerY" select="$y" /> 
    <xsl:with-param name="radius" select="$radius" /> 
    <xsl:with-param name="angleInDegrees" select="$startAngle" /> 
  </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="largeArcFlag" >
    <xsl:choose>
      <xsl:when test="(180 >= ($endAngle - $startAngle))" >0
      </xsl:when>
      <xsl:otherwise>1
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
<xsl:value-of select="concat('m ', string($start/@x), ',' ,string($start/@y),  ' a ' ,$radius, ',' ,$radius ,' 0 0 ', 1 ,' ' ,string($start/@x), ',' ,string($start/@y ), ' l ' ,string($end/@x), ',' ,string($end/@y ), ' z')" />
  </xsl:template>





  <xsl:template name="getItemPositions" >
    <xsl:param name="dataSrc"  />
    <data>
      <xsl:for-each select="$dataSrc/data/*">
	<xsl:variable name="item" select="." />
      <xsl:variable name="pos" select="index-of($dataSrc/data/*/@*:key, $item/@*:key)" />
	<entry position="{$pos}" value="{$item/@*:value}" key="{$item/@*:key}" />
    </xsl:for-each>
    </data>
  </xsl:template>
    
</xsl:stylesheet>
