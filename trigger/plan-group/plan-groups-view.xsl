<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rsu="http://www.vionta.net/xsd/stratml-results/1.0"
    version="3.0">

  <xsl:import href="../graph-tools/transformations/xsl/basic-charts.xsl" />
  <xsl:import href="../graph-tools/transformations/xsl/colors.xsl" />

  <xsl:param  name="entity" select="''" />
  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:template match="/"><html><head>
    <link rel="stylesheet" type="text/css" href="/resources/css/follow-up.css" />

    <script src="/resources/js/document-functions.js" />
  </head>
  <body>

    <!--
      <groups>
	<plan-group>
	  <code>123</code>
	  <name>eeost</name>
	  <description/>
	  <remarks>osoeu</remarks>
	  <plans>
	    <plan>
	      <code>AEOU-O-oeeou</code>
	      <name/>
	      </plan><plan>
	      <code/>
	      <name/>
	    </plan>
	  </plans>
	</plan-group>
    </groups> -->

    <br/>
    <main>
      <table class="summary entity-list" >
	<tr class="plan-group" >
	  <th>
	    <a href="/index/plan-group.html"><img src="/resources/img/configuration.svg" alt="Manage Plan Groups" title="Manage Plan Groups"  />
	    Plan Group</a>
	  </th>
	  <th >
	    <a href="/index/plan-group.html"><img src="/resources/img/plan.png" alt="Manage Plans" title="Manage Plans"  />	    Plans
</a>
	  </th>
	  <th>
<a href="/index/plan-group.html"><img src="/resources/img/indicator.png"   />Indicators</a>	    
	  </th>
	</tr>
	<xsl:apply-templates  />
      </table>

      <br/>
      
      <xsl:if test="not(.//plan-group)" >
	<div class="message" >
	  <a href="/new/plan-group.xml?entity=plan-group" >
	    <h4>There are no plan groups to follow up.</h4>
	    <p>Follow up is based on plan groups, in order to follow up a plan, create a
	    plan group and add the plans to it. </p>
	  </a>
	</div>
      </xsl:if>
      
    </main>
  </body>
</html>
  </xsl:template>

  <xsl:template match="plan-group" >
    <tr class="plan-group entity-list" >
      <td class="plan-group-title-td" >
	<a href="/view/plan-group/{code}.html" ><xsl:value-of select="name/text()" > </xsl:value-of></a>
	<a href="{concat('/form/plan-group/' ,  code/text(), '.xml')}">  <img src="/resources/img/edit-blue-icon.svg" alt="Edit" /> </a>
	<!--
	    <xsl:value-of select="remarks/text()" ></xsl:value-of>
	    -->
      </td>
      <td class="plan-list" >
	<xsl:if test="boolean(./plans/plan)" >
	    <xsl:apply-templates select="plans/plan"/>
	</xsl:if>
      </td>
      <td>
	<xsl:variable name="plan-results" >
	  <data>
	    <item key="Success" value="{count(.//PerformancePlanOrReport[rsu:stats/@success = 'true'])}" />
	    <item key="Fail"    value="{count(.//PerformancePlanOrReport[rsu:stats/@success = 'false'])}" />
	  </data>
	</xsl:variable>
	<xsl:call-template name="svg-pie-chart" >
	  <xsl:with-param name="data" select="$plan-results"  />
	  <xsl:with-param name="color" select="'yes-no-neutral'" />
	  <xsl:with-param name="title" select="'Group results'" />
	  <xsl:with-param name="radius" select="40" />
	</xsl:call-template>
    
	<!-- group statistics should go here -->
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="plan" >

    <div class="plan-block" >
    <a href="/view/plan/{code}.html" class="plan-label"> <xsl:value-of select="Name" ></xsl:value-of>    <xsl:value-of select="code/text()" ></xsl:value-of></a>
    <div class="plan-controls">
    	<a href="{concat('/form/PerformancePlanOrReport/' ,  code/text(), '.xml')}"> <img src="/resources/img/edit-blue-icon.svg" alt="Edit" /> </a>
    	<a href="{concat('/form/plan-evaluation/' ,  code/text(), '.xml')}"><img src="/resources/img/configuration.svg" alt="Adjust evaluation" title="Adjust evaluation" /></a>
    	<a href="{concat('/read/PerformancePlanOrReport/' ,  code/text(), '.xml')}"> <img src="/resources/img/view-blue-icon.svg" alt="View" /> </a>
    </div>
    </div>
  </xsl:template>

  <xsl:template match="text()"></xsl:template>

</xsl:stylesheet>
