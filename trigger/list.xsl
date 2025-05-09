<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

  <xsl:param   name="entity" select="'issue'" />
  <xsl:output method="html" encoding="utf-8" indent="yes"/>


  <xsl:template match="/"><html><head>
    <link rel="stylesheet" type="text/css" href="/resources/css/list-style.css" />
    <script src="/resources/js/document-functions.js" />
  </head>
  <body>
    <div class="main-content" >
    <header>
      <h3><xsl:choose>
	  <xsl:when test="$entity = 'plan-group'" >Plan Groups</xsl:when>
	  <xsl:when test="$entity = 'PerformancePlanOrReport'" ></xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$entity" />
	  </xsl:otherwise>
	</xsl:choose></h3>
    </header>
    
    <main>

      <div class="tableset">

	<xsl:choose >
	  
	  <xsl:when test="$entity = 'PerformancePlanOrReport' ">
	    <table class="entity-list">
	      <tr><th>Plan</th><th>Organization</th><th>Submitter</th><th/></tr>
	      <xsl:apply-templates select="//issues/*" />
	    </table>
	  </xsl:when>
	  <xsl:when test="$entity = 'plan-group' ">
	    <table class="entity-list">
	      <tr><th>Plan Group</th><th>DESC</th><th/><th/></tr>
	      <xsl:apply-templates select="//issues/*" />
	    </table>
	  </xsl:when>
	  <xsl:otherwise>
	    <table class="entity-list">
	      <tr><th>CODE</th><th>NAME</th><th>DESC</th><th/><th/></tr>
	      <xsl:apply-templates select="//issues/*" />
	    </table>
	  </xsl:otherwise>
	</xsl:choose>

	<div class="line">
	  <div class="linkset final-button-set" >
	    <a href="{concat('/new/', $entity, '.xml?entity=', $entity)}"> New <xsl:choose>
	  <xsl:when test="$entity = 'plan-group'" >Plan Group</xsl:when>
	  <xsl:when test="$entity = 'PerformancePlanOrReport'" >Strategic Plan</xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$entity" />
	  </xsl:otherwise>
	</xsl:choose>

	    </a>
	  </div>
	</div>
	<br/>
	<br/>
	<br/>
	
      </div>
    </main>
    </div>
  </body>
</html>
  </xsl:template>
  
  <xsl:template match="*[($entity != 'PerformancePlanOrReport')	and (local-name() eq $entity)]">
    <tr>
      <td>
	<a href="{concat('/form/',$entity, '/' ,  code/text(), '.xml')}"> <xsl:value-of select="name/text()" /></a>
      </td>
      <td>
	<xsl:value-of select="description/text()" />
      </td>
      <td>
	<a name="borrar-{code/text()}" onclick="deleteDocument('{code/text()}','{$entity}')" >
	<img src="/resources/img/delete-blue-icon.svg" alt="Delete" />
	</a>
      </td>
      
      <td>
	<a href="{concat('/form/',$entity, '/' ,  code/text(), '.xml')}"> <img src="/resources/img/edit-blue-icon.svg" alt="Edit" /> </a>
      </td>
    </tr>
  </xsl:template>


  <xsl:template match="*[local-name() eq 'PerformancePlanOrReport']">
    <tr>
      <td>
	<a href="{concat('/form/',$entity, '/' ,  code/text(), '.xml')}"><xsl:value-of select="Name/text()" /> </a>
	
      </td>
      <td>
	<xsl:value-of select="Organization[1]/Name/text()" />
      </td>
      <td>
	<xsl:value-of select="Submitter/GivenName/text()" />
	<xsl:value-of select="Submitter/Surname/text()" />
      </td>
      <td class="icon-buttons-cell" >
	<a name="borrar-{code/text()}" onclick="deleteDocument('{code/text()}','{$entity}')" ><img src="/resources/img/delete-blue-icon.svg" alt="Delete" /></a>

	
	
	<a href="{concat('/form/',$entity, '/' ,  code/text(), '.xml')}"><img src="/resources/img/edit-blue-icon.svg" alt="Edit" /></a>

	<a href="{concat('/form/plan-evaluation/' ,  code/text(), '.xml')}"><img src="/resources/img/configuration.svg" alt="Adjust evaluation" title="Adjust evaluation" /></a>
	
	 
	<a href="{concat('/read/',$entity, '/' ,  code/text(), '.xml')}"> <img src="/resources/img/view-blue-icon.svg" alt="View" /> </a>


      </td>      	
    </tr>
  </xsl:template>

  
  <xsl:template match="text()"></xsl:template>

</xsl:stylesheet>
