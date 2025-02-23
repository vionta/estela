<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

  <xsl:output method="html" encoding="utf-8" indent="yes"/>

  <xsl:template match="/"><html><head>
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css" ></link>
    <script src="/resources/js/document-functions.js" />
  </head>
  <body>
    <header>
      <h3>Entity Report</h3>
      <breadcrumb>
	<a href="home.html" > &gt; Home </a>
      </breadcrumb>
    </header>
    
    <main>

      <table>
	<xsl:for-each select="./*/element()" >

	  <tr>
	    <td><xsl:value-of select="local-name()" /></td>
	    <td>

	      <xsl:for-each select="element()" >

		<td>
		<table><tr><td><xsl:value-of select="local-name()" /></td>
		</tr><tr><td><xsl:value-of select="text()" /></td>
</tr></table>
		</td>
	      </xsl:for-each>
	    </td>
	    
	  </tr>
	</xsl:for-each>
      </table>
      <a href="javascript:history.back()" > <img src="/resources/img/prev-page-icon.svg" alt="back" /> Back </a>
    </main>
  </body>
</html>
  </xsl:template>
  <xsl:template match="text()"></xsl:template>

</xsl:stylesheet>
