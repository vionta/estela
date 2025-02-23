<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
    version="1.0">

  <xsl:import href="../plan/chart/stat-bar-chart.xsl" />
  <xsl:import href="../graph-tools/transformations/xsl/basic-charts.xsl" />
  <xsl:import href="../graph-tools/transformations/xsl/colors.xsl" />
  
  <xsl:param   name="entity" select="'issue'" />
  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:template match="/"><html><head>
    
    <link rel="stylesheet" type="text/css" href="/resources/css/plan-group.css" />
    <script src="/resources/js/document-functions.js" />
  </head>
  <body>
    <main>
      <xsl:apply-templates  />
    </main>
  </body>
</html>
  </xsl:template>

  <xsl:template match="plan-group" >

    <div class="plan-group">

      <div class="inline" >
      <h3><a href="/view/plan-group/{code}.html" ><xsl:value-of select="name/text()" ></xsl:value-of> </a></h3>
      <a href="{concat('/form/plan-group/' ,  code/text(), '.xml')}"> <img src="/resources/img/edit-blue-icon.svg" alt="Edit" /> </a>
    </div>
    <p><xsl:value-of select="remarks/text()" ></xsl:value-of></p>
    <div class="tableset" >
      <table  class="plan-group-result">
	<tr>
	  <td>
	    <xsl:variable name="plan-results" >
	      <data>
		<item key="Success" value="{count(.//PerformancePlanOrReport[rsu:stats/@success = 'true'])}" />
		<item key="Fail"    value="{count(.//PerformancePlanOrReport[rsu:stats/@success = 'false'])}" />
o	      </data>
	    </xsl:variable>
	    <xsl:call-template name="svg-pie-chart" >
	      <xsl:with-param name="data" select="$plan-results"  />
	      <xsl:with-param name="color" select="'yes-no-neutral'" />
	      <xsl:with-param name="title" select="'Plans'" />
	      <xsl:with-param name="radius" select="40" />
	    </xsl:call-template>
	  </td>
	  <td>
	    <xsl:if test="boolean(./plans/plan)" >
	      <table class="results-grey-table" >
		<xsl:apply-templates select="evaluations/PerformancePlanOrReport"/>
	      </table>
	    </xsl:if>

	  </td>
	</tr>
      </table>
    </div>
    </div>
  </xsl:template>
<!--
  <xsl:template match="plan" >
    <li>
      <div class="inline">
	<h4><a href="/view/plan/{code}.html"> [<xsl:value-of select="code" ></xsl:value-of>]    <xsl:value-of select="name/text()" ></xsl:value-of></a></h4>
	<a href="{concat('/form/PerformancePlanOrReport/' ,  code/text(), '.xml')}"> <img src="/resources/img/edit-blue-icon.svg" alt="Edit" /> </a>
	<a href="{concat('/form/plan-evaluation/' ,  code/text(), '.xml')}"><img src="/resources/img/configuration.svg" alt="Adjust evaluation" title="Adjust evaluation" /></a>
	<a href="{concat('/read/PerformancePlanOrReport/' ,  code/text(), '.xml')}"> <img src="/resources/img/view-blue-icon.svg" alt="View" /> </a>
	</div>e
    </li>
  </xsl:template>
-->
  <xsl:template match="PerformancePlanOrReport" >
    <tr>
      <td>
	<img src="/resources/img/success-{string(rsu:stats/@success)}-blue-icon.svg" class="hint-icon-result"/>
	<!-- <xsl:value-of select="rsu:stats/@successes" /> / <xsl:value-of select="rsu:stats/@failures" /> / <xsl:value-of select="rsu:stats/@blanks" /> -->
	<!--   <rsu:stats success="false" total="1" successes="0" failures="1" blanks="0" xmlns:rsu="http://w-->
	<a href="/view/plan/{code}.html"> <xsl:value-of select="Name/text()" ></xsl:value-of></a>
      </td>
      <td>
	<a href="{concat('/form/PerformancePlanOrReport/' ,  code/text(), '.xml')}"> <img src="/resources/img/edit-blue-icon.svg" alt="Edit" /> </a>
      </td>
      <td>
	<a href="{concat('/form/plan-evaluation/' ,  code/text(), '.xml')}"><img src="/resources/img/configuration.svg" alt="Adjust evaluation" title="Adjust evaluation" /></a>
      </td>
      <td>
	<a href="{concat('/read/PerformancePlanOrReport/' ,  code/text(), '.xml')}"> <img src="/resources/img/view-blue-icon.svg" alt="View" /> </a>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="text()"></xsl:template>

</xsl:stylesheet>
