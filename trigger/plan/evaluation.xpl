<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"  version="3.0">

  <p:input port="source" primary="true" ><p:inline><documento><otro></otro></documento></p:inline></p:input>
  
  <p:output port="result" primary="true" />
  <p:option name="code"   select="'default'" />    

  <p:load name="load-file-content"  >
    <p:with-option
	name="href" select="concat('../../data/PerformancePlanOrReport/', $code , '.xml')" />
  </p:load>

  <p:xslt name="reference-indicators">
    <p:with-input port="stylesheet" href="./evaluation-xsl/1-indicators.xsl"/>
  </p:xslt>

  <p:xslt name="rules-evaluation">
    <p:with-input port="stylesheet" href="./evaluation-xsl/1-1-success-criteria.xsl"/>
  </p:xslt>

  <p:xslt name="indicator-stats">
    <p:with-input port="stylesheet" href="./evaluation-xsl/2-indicator-stats.xsl"/>
  </p:xslt>

  <p:xslt name="objective-stats">
    <p:with-input port="stylesheet" href="./evaluation-xsl/3-objective-stats.xsl"/>
  </p:xslt>

  <p:xslt name="goal-stats">
    <p:with-input port="stylesheet" href="./evaluation-xsl/4-goal-stats.xsl"/>
  </p:xslt>

  <p:xslt name="plan-stats">
    <p:with-input port="stylesheet" href="./evaluation-xsl/5-plan-stats.xsl"/>
  </p:xslt>

  <p:store name="report-serialization" >
    <p:with-option name="href" select="concat('../../report/plan-evaluation/',$code,'.xml')" />
  </p:store>

</p:declare-step>
