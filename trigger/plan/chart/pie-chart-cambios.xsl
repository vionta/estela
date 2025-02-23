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
      name="pie-chart"
      >
    <xsl:param name="threshold" select="85" />
    <xsl:param name="stats" />
    <h3>
      ......... <xsl:value-of select="string($stats/@*:successes)" />
      - <xsl:value-of select="string($stats/@*:failures)" />
      - <xsl:value-of select="string($stats/@*:blanks)" />-- <xsl:value-of select="string($stats/@*:total)" /> ..............
    </h3>

    <!--
    <table>
      <tr>
	<td></td>
	<td>Value</td>
	<td>Pre</td>
	<td>Total</td>

      </tr>



      <tr>
	<td>Success</td>


	<td>   <xsl:value-of select="number(rsu:stats/@successes) * 10" /> </td>
	<td>    <xsl:value-of select="0" /></td>
	<td>    <xsl:value-of select="number(rsu:stats/@total) * 10 " /></td>
      </tr>
      <tr>
	<td>Failures</td>
	<td>  <xsl:value-of select="number(rsu:stats/@failures) * 10" /></td>
	<td>  <xsl:value-of select="number(rsu:stats/@successes) * 10" /></td>
	<td>  <xsl:value-of select="number(rsu:stats/@total) * 10" /></td>
      </tr>
      <tr>
	<td>Blanks</td>
	<td>  <xsl:value-of select="number(rsu:stats/@blanks) * 10" /></td>
	<td>  <xsl:value-of select="(number(rsu:stats/@successes) + number(rsu:stats/@failures)) * 10" /></td>
	<td>  <xsl:value-of select="number(rsu:stats/@total) * 10" /></td>
      </tr>

      <tr>
	<td>Rest</td>
	<td>    <xsl:value-of select="(number(rsu:stats/@total) - (number(rsu:stats/@successes) + number(rsu:stats/@failures) + number(rsu:stats/@blanks)) ) * 10" /></td>
	<td>  <xsl:value-of select=" (number(rsu:stats/@successes) + number(rsu:stats/@failures) + number(rsu:stats/@blanks) ) * 10" /></td>
	<td>  <xsl:value-of select="number(rsu:stats/@total) * 10" /></td>
      </tr>
      </table>
      -->
    <br/>

    <br/>
    <svg width="110px" height="110px"
	 viewBox="0.00 0.00 420.00 220.00"
	 xmlns="http://www.w3.org/2000/svg"
	 xmlns:xlink="http://www.w3.org/1999/xlink"> 

      <!--
	  {$pie}{$leg}{$cols}
      -->

      <xsl:comment>
	......... <xsl:value-of select="string($stats/@*:successes)" />
	- <xsl:value-of select="string($stats/@*:failures)" />
      - <xsl:value-of select="string($stats/@*:blanks)" /> ..............    </xsl:comment>

      <xsl:copy-of select="*:stats" ></xsl:copy-of>
      <xsl:variable name="centerX" select="110"  />
      <xsl:variable name="centerY" select="110"  />
      <xsl:variable name="radius" select="100"  />

      <!--
	  <xsl:call-template name="pie-part" >
	  <xsl:with-param name="centerX" select="$centerX" />
	  <xsl:with-param name="centerY" select="$centerY" />
	  <xsl:with-param name="radius" select="$radius" />
	  <xsl:with-param name="value" select="3" />
	  <xsl:with-param name="pre" select="2" />
	  b      <xsl:with-param name="total" select="7" />

<xsl:with-param name="color" select="'#129912'" />

</xsl:call-template>
      -->


      <!--	  <rsu:stats success="{($successes div $total) > 0.85}" total="{$total}"
	  successes="{$successes}" failures="{$failures}" blanks="{$blanks}" >
      -->
      <!-- .......... Successes ........... -->
      <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="pre" select="0" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10 " />
	<xsl:with-param name="color" select="'#12ff12'" />  
      </xsl:call-template>


      <!-- .......... Failures ........... -->
      <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@failures) * 10" />
	<xsl:with-param name="pre" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#ff1212'" />  
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



      <xsl:call-template name="pie-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="(number(rsu:stats/@total) - (number(rsu:stats/@successes) + number(rsu:stats/@failures) + number(rsu:stats/@blanks)) ) * 10" />
	<xsl:with-param name="pre" select=" (number(rsu:stats/@successes) + number(rsu:stats/@failures) + number(rsu:stats/@blanks) ) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#333333'" />  
      </xsl:call-template>

      <!--
	  let $data := svg-circle:getItemPositions($dataSrc) 
	  let $total := sum($data/*/@value)
	  let $pie := for $i in $data/*
	  let $value := $i/@value
	  let $pre := sum($data/*[@position < $i/@position]/@value)
	  let $startAngle := round(($pre div $total) * 360) 
	  let $endAngle := round( (($pre + $value) div $total) * 360)
	  let $inArc := if(($endAngle - $startAngle ) >= 180 ) then "0" else "1"
	  let $startAngleRadians := ( xs:double($startAngle) * math:pi() ) div 180.0
	  let $endAngleRadians := (xs:double($endAngle) * math:pi() ) div 180.0
	  return  svg-circle:piePart(110, 110, 100, $startAngle, $endAngle,
	  svg-circle:graphcolor($color, number($i/@position))
	  )

let $leg := for $t in $data/*
return <text xmlns="http://www.w3.org/2000/svg"
x="220"
y="{30+10 *$t /@position}"
style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Franklin Gothic Medium Cond;-inkscape-font-specification:Franklin Gothic Medium Cond"
>{string($t/@key)}</text> 

let $leg := for $t in $data/*
return <text xmlns="http://www.w3.org/2000/svg"
x="250"
y="{30+10 *$t /@position}"
style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Franklin Gothic Medium Cond;-inkscape-font-specification:Franklin Gothic Medium Cond"
>{string($t/@key)}</text> 

let $cols := for $q in $data/*
return 
<path  xmlns="http://www.w3.org/2000/svg" d=" M 0,0  10,0 10,10 0,10 z "
transform="scale(1 1) rotate(1) translate(230, {20+10 *$q/@position})"
style="color:#0000ff;fill:{svg-circle:graphcolor($color, number($q/@position)) };fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
/>

let $join := <join>{$pie}{$leg}{$cols}</join>
return $join/* 
      -->

    </svg>
    
    <!--
      <xsl:call-template name="log-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="pre" select="0" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10 " />
	<xsl:with-param name="color" select="'#129912'" />  
      </xsl:call-template>


      <xsl:call-template name="log-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@failures) * 10" />
	<xsl:with-param name="pre" select="number(rsu:stats/@successes) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#991212'" />  
      </xsl:call-template>
      

      <xsl:call-template name="log-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="number(rsu:stats/@blanks) * 10" />
	<xsl:with-param name="pre" select="(number(rsu:stats/@successes) + number(rsu:stats/@failures)) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#555555'" />  
      </xsl:call-template>



      <xsl:call-template name="log-part" >
	<xsl:with-param name="centerX" select="$centerX" />
	<xsl:with-param name="centerY" select="$centerY" />
	<xsl:with-param name="radius" select="$radius" />
	<xsl:with-param name="value" select="(number(rsu:stats/@total) - (number(rsu:stats/@successes) + number(rsu:stats/@failures) + number(rsu:stats/@blanks)) ) * 10" />
	<xsl:with-param name="pre" select=" (number(rsu:stats/@successes) + number(rsu:stats/@failures) + number(rsu:stats/@blanks) ) * 10" />
	<xsl:with-param name="total" select="number(rsu:stats/@total) * 10" />
	<xsl:with-param name="color" select="'#333333'" />  
      </xsl:call-template>


-->
    
  </xsl:template>


  <!--


declare function svg-circle:piePart($centerX, $centerY, $radius, $startAngle, $endAngle, $color) {

let $inArc := if(($endAngle - $startAngle ) >= 180 ) then "0" else "1"
let $startAngleRadians := ( xs:double($startAngle) * math:pi() ) div 180.0
let $endAngleRadians := (xs:double($endAngle) * math:pi() ) div 180.0 


return 
<path xmlns="http://www.w3.org/2000/svg"
d=" M 0,0  {$radius * math:cos($startAngleRadians)},{$radius * math:sin($startAngleRadians)} A 100 100 0 0 {$inArc}  {$radius * math:cos($endAngleRadians)} {$radius * math:sin($endAngleRadians)} l   {$radius * math:cos($endAngleRadians)},{$radius * math:sin($endAngleRadians)} z " 
transform="scale(1 1) rotate(1) translate({$centerX} {$centerY})"

style="color:#0000ff;fill:{$color};fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"

/>


};
  -->

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
  
    <xsl:variable name="startAngle" select="($pre div $total) * 360" />
    <xsl:variable name="endAngle" select=" (($pre + $value) div $total) * 360"  />

    <xsl:variable name="startAngleRadians" select="(xsd:double($startAngle) * math:pi() ) div 180.0" />
    <xsl:variable name="endAngleRadians" select="(xsd:double($endAngle) * math:pi() ) div 180.0" />
    
    <xsl:variable name="inArc"  >
      <xsl:choose>
	<xsl:when test="($endAngle - $startAngle ) >= 100" >0</xsl:when>
	<xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <!--
	<path d=" M 0,0  , A 100 100 0 0 1    l   , z "
        transform="scale(1 1) rotate(1) translate(110 110)"
        style="color:#0000ff;fill:#129912;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate">
        </path>
    -->
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
	  d=" M 0,0  {round($radius * math:cos($startAngleRadians))},{round($radius * math:sin($startAngleRadians))} A 100 100 0 0 {$inArc}  {round($radius * math:cos($endAngleRadians))} {round($radius * math:sin($endAngleRadians))} l   {round($radius * math:cos($endAngleRadians))},{round($radius * math:sin($endAngleRadians))} z " 
	  transform="scale(1 1)  translate({$centerX} {$centerY})"		
	  style="color:#0000ff;fill:{$color};fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
	  
	  />

  </xsl:template>






  <xsl:template
      name="log-part"
      >
    <xsl:param name="centerX"  />
    <xsl:param name="centerY"  />
    <xsl:param name="radius"  /> 
    <xsl:param name="value"  />
    <xsl:param name="pre"  />
    <xsl:param name="total"  />
    <xsl:param name="color" />

    <!--
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
    
    <p><xsl:value-of 
	  select="concat('M 0,0 ', ($radius * math:cos($startAngleRadians)),($radius * math:sin($startAngleRadians)),' A 100 100 0 0', ($inArc), ' ' ,($radius * math:cos($endAngleRadians)), ' ',($radius * math:sin($endAngleRadians)), ' l  ', ($radius * math:cos($endAngleRadians)), ' ,' ($radius * math:sin($endAngleRadians)), '  z') " 
	  /></p>-->
<h1>aaaaaaaaaaa</h1>
  </xsl:template>

  
</xsl:stylesheet>
