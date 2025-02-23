<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    version="3.0" 
    >
  
  <xsl:output 
      method="xml" 
      encoding="UTF-8"
      indent="yes"/>

  <!-- Sample color combination that should
       be available
  <xsl:variable name="pallete" >
    <types>
      <colors id="1">
	<color>#333366</color>
	<color>#666699</color>
	<color>#9999af</color>
	<color>#afafbf</color>
	<color>#bfbfcf</color>
	<color>#cfcfdf</color>
	<color>#dfdfef</color>
	<color>#efefff</color>
	
	
	<color>#660000</color>
	<color>#aa3333</color>
	<color>#cc6666</color>
	<color>#dd9999</color>
	<color>#eeaaaa</color>
	<color>#ccbbbb</color>
	<color>#ddcccc</color>
	<color>#ffdddd</color>
	<color>#ffeeee</color>
	<color>#ffffff</color>
      </colors>
      <colors id="2">
	<color>#660000</color>
	<color>#aa3333</color>
	<color>#cc6666</color>
	<color>#dd9999</color>
	<color>#eeaaaa</color>
	<color>#ccbbbb</color>
	<color>#ddcccc</color>
	<color>#ffdddd</color>
	<color>#ffeeee</color>
	<color>#ffffff</color>
	<color>#660000</color>
	<color>#aa3333</color>
	<color>#cc6666</color>
	<color>#dd9999</color>
	<color>#eeaaaa</color>
	<color>#ccbbbb</color>
	<color>#ddcccc</color>
	<color>#ffdddd</color>
	<color>#ffeeee</color>
	<color>#ffffff</color>
      </colors>
      <colors id="3">
	<color>#660000</color>
	<color>#aa3333</color>
	<color>#cc6666</color>
	<color>#dd9999</color>
	<color>#eeaaaa</color>
	<color>#ccbbbb</color>
	<color>#ddcccc</color>
	<color>#ffdddd</color>
	<color>#ffeeee</color>
	<color>#ffffff</color>
	<color>#660000</color>
	<color>#a03333</color>
	<color>#c06666</color>
	<color>#d09999</color>
	<color>#ffaaaa</color>
      </colors>
    </types>
  </xsl:variable>
  -->
  
  <xsl:template name="graphcolors" >
    <xsl:param name="type" select="'1'"  />
    <xsl:copy-of select="$pallete//colors[@*:id=$type]" />
  </xsl:template>

  <!-- Graph Color -->
  <xsl:template name="graphcolor" >
    <xsl:param name="type" />
    <xsl:param name="position"  />

    <xsl:variable name="temp" ><xsl:call-template name="graphcolors" >
      <xsl:with-param name="type" select="$type" />
    </xsl:call-template>
    </xsl:variable>
  <xsl:value-of select="$temp/*/*[$position]/text()" /></xsl:template>

  
</xsl:stylesheet>
	       

