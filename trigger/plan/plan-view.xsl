<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
    version="3.0">

  <xsl:import href="chart/stat-bar-chart.xsl" />
  <xsl:import href="../graph-tools/transformations/xsl/basic-charts.xsl" />
  <xsl:import href="../graph-tools/transformations/xsl/horizontal-bar-chart.xsl" />
  <xsl:import href="../graph-tools/transformations/xsl/colors.xsl" />

  <xsl:param   name="entity" select="/PerformancePlanOrReport/Name" />
  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:template match="/"><html><head>
    <link rel="stylesheet" type="text/css" href="/resources/css/follow-up-plan.css" />
    <!--
	<link rel="stylesheet" type="text/css" href="/resources/css/entity-list.css" />
    -->
    <script src="/resources/js/document-functions.js" />
  </head>
  <body>
    <main>
      <div class="vertical-block" >
	<div class="title-line" >
	  <h3><xsl:value-of select="/PerformancePlanOrReport/Name" /></h3>
	  <a href="{concat('/form/PerformancePlanOrReport/' ,  /PerformancePlanOrReport/code/text(), '.xml')}"> <img src="/resources/img/edit-blue-icon.svg" alt="Edit" /> </a>
	  <a href="{concat('/form/plan-evaluation/' ,  /PerformancePlanOrReport/code/text(), '.xml')}"><img src="/resources/img/configuration.svg" alt="Adjust evaluation" title="Adjust evaluation" /></a>
	  <a href="{concat('/read/PerformancePlanOrReport/' ,  /PerformancePlanOrReport/code/text(), '.xml')}"> <img src="/resources/img/lupa2.png" alt="View" /> </a>
	</div>
	<xsl:apply-templates select="PerformancePlanOrReport"  />
      </div>
    </main>
  </body>
</html>
  </xsl:template>

  <xsl:template match="PerformancePlanOrReport" >
    <div class="diagram-line" >
      <xsl:variable name="finalized-stats" >
	<data>
	  <entry key="Ended" value="{count(//TargetResult[@EndDate > current-date()])}" />
	  <entry key="Ongoing" value="{count(//TargetResult[current-date() > @EndDate])}" />
	  <entry key="No Date" value="{count(//TargetResult[not(@EndDate)])}" />
	</data>
      </xsl:variable>
      
      <!--
	  <div>
	  <n3> Ended: <xsl:value-of select="count(//TargetResult[@EndDate > current-date()])" /></n3>
	  <h3>Ongoing <xsl:value-of select="count(//TargetResult[current-date() > @EndDate])" /></h3>
	  <h3>No Date <xsl:value-of select="count(//TargetResult[not(@EndDate)])" /></h3>
	  </div>
      -->
      
      <xsl:call-template name="svg-pie-chart" >
	<xsl:with-param name="data" select="$finalized-stats"  />
	<xsl:with-param name="color" select="'1'" />
	<xsl:with-param name="title" select="'Finalized'" />
	<xsl:with-param name="radius" select="30" />
      </xsl:call-template>
      
      <xsl:variable name="informed-indicators"
		    select="count(//PerformanceIndicator[*:evaluation-critera or *:success-criteria])"
		    />
      <!--  <evaluation-criteria <success-criteria  -->
      <xsl:variable name="informed-stats" >
	<data>
	  <entry key="Informed" value="{$informed-indicators}" />
	  <entry key="Not Informed" value="{count(//PerformanceIndicator) - $informed-indicators}" />
	  <entry key="No Indicator" value="{count(//Objective[not(PerformanceIndicator)])}" />
	</data>
      </xsl:variable>

      <xsl:call-template name="svg-pie-chart" >
	<xsl:with-param name="data" select="$informed-stats"  />
	<xsl:with-param name="color" select="'1'" />
	<xsl:with-param name="title" select="'Informed'" />
	<xsl:with-param name="radius" select="30" />
      </xsl:call-template>
      <xsl:call-template name="pie-chart">
	<xsl:with-param name="stats" select="rsu:stats" />
	<xsl:with-param name="title" select="'Plan results'" />
	<xsl:with-param name="radius" select="60" />
      </xsl:call-template>
    </div>


    <br/>
    
    <table class="evaluation-view" >
      <!--
	  <tr>
	  <th>Goal</th>
	  <th>Objective</th>
	  <th>Indicator</th>
	  <th colspan="2" ></th>
	  </tr>

<xsl:copy-of select="rsu:average/rsu:stats" />

<xsl:call-template name="pie-chart">
<xsl:with-param name="stats" select="rsu:average/rsu:stats" />
</xsl:call-template>
      -->
      <xsl:if test="boolean(Goal)" >
	<xsl:apply-templates select="Goal"/>
      </xsl:if>
    </table>
  </xsl:template>

  <xsl:template match="Goal" >
    <tr>
      <td colspan="3" rowspan="{count(./Objective) + count(./Indicator)}"  style="vertical-align:top;">
	<div class="vertical-block" >
	  <div class="inline">
	  <img src="/resources/img/success-{string(rsu:stats/@success)}-blue-icon.svg" class="hint-icon-result"/>
	  <xsl:value-of select="Name/text()" />
	  </div>
	  <div class="centered-block" >
	    <xsl:call-template name="stats-bar-chart">
	      <xsl:with-param name="stats" select="rsu:stats" />
	    </xsl:call-template>
	  </div>
	</div>
      </td>
      <td>
	<table class="objective">
	<xsl:apply-templates select="Objective"/>


	<!--
	    <xsl:call-template name="pie-chart">
	    <xsl:with-param name="stats" select="rsu:stats" />
	    <xsl:with-param name="title" select="Name/text()" />
	    <xsl:with-param name="radius" select="30" />
	    </xsl:call-template>	
	-->
	</table>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="Objective" >

      <tr>
	<td class="objective-name" >
	  <div class="inline">
	    <img
		src="/resources/img/success-{string(rsu:stats/@success)}-blue-icon.svg"
		class="hint-icon-result" />
	      <xsl:value-of select="Name/text()" />
	  </div>
	</td>
	<td>
	    <xsl:call-template name="horizontal-bar-chart">
	      <xsl:with-param name="stats" select="rsu:stats" />
	    </xsl:call-template>
	    
	  </td>
      </tr>
      <xsl:apply-templates select="PerformanceIndicator"/>

  </xsl:template>

  <xsl:template match="PerformanceIndicator" >
    <tr>
      <td colspan="2" style="padding-left:3em;" class="left">
	<img src="/resources/img/success-{string(rsu:stats/@success)}-blue-icon.svg" class="hint-icon-result" />
	<xsl:value-of select="MeasurementDimension/text()" />
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="text()"></xsl:template>



  <!-- Template Pie Chart -->
  <xsl:template name="pie-chart">
    <xsl:param name="stats" />
    <xsl:param name="title" />
    <xsl:param name="radius" />
    <!--
	<rsu:stats success="false"
        total="1"
        successes="0"
        failures="1"
        blanks="0"
        xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
        xmlns:xsd="http://www.w3.org/2001/XMLSchema"/>

<xsl:message>
<data>
<item key="success" value="$stats/rsu:stats/@success" />
<item key="fail"    value="$stats/rsu:stats/@fail" />
<item key="blank" value="$stats/rsu:stats/@blanks" />
</data>
</xsl:message>
    -->
    <xsl:variable name="chart-data" >
      <data>
	<item key="success" value="{$stats/@successes}" />
	<item key="fail"    value="{$stats/@failures}" />
	<item key="blank" value="{$stats/@blanks}" />
      </data>
    </xsl:variable>

    <xsl:comment>
      item key="success" <xsl:value-of select="$stats/@successes" />
      item key="fail"    <xsl:value-of select="$stats/@failures" />
      item key="blank"  <xsl:value-of select="$stats/@blanks" /> 
    </xsl:comment>
    
    <!--
	</xsl:variable>
    -->

    <xsl:call-template name="svg-pie-chart" >
      <xsl:with-param name="data" select="$chart-data"  />
      <xsl:with-param name="color" select="'yes-no-neutral'" />
      <xsl:with-param name="title" select="$title" />
      <xsl:with-param name="radius" select="$radius" />
    </xsl:call-template>

  </xsl:template>









  
</xsl:stylesheet>
