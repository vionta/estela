<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:sal="http://www.vionta.net/ns/xproc/1.0/salvora"
    version="3.0">

  <p:import href="../template/add-header.xpl" />
  <p:input port="source" primary="true" ><p:inline><documento><otro></otro></documento></p:inline></p:input>
  
  <p:output port="result" primary="true"  />
  <p:option name="code"   select="'eee'"/>    

  <p:load name="load-file-content"  >
    <p:with-option
	name="href" select="concat('../../report/plan-evaluation/',$code,'.xml')" />
  </p:load>

  <p:xslt name="final-list">
    <p:with-input port="stylesheet" href="./plan-view.xsl"/>
  </p:xslt>

  <sal:add-header/>

  <p:store name="report-serialization" >
    <p:with-option name="href" select="concat('../../report/plan/',$code,'.html')" />
  </p:store>

</p:declare-step>
