<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:sal="http://www.vionta.net/ns/xproc/1.0/salvora"
    version="3.0">

  <p:import href="../template/add-header.xpl" />
  <p:input port="source" primary="true" ><p:inline><documento><otro></otro></documento></p:inline></p:input>
  
  <p:output port="result" primary="true"  />
  <p:option name="code"   select="'eee'"/>    

  <p:load name="load-group-content"  >
    <p:with-option
	name="href" select="concat('../../data/plan-group/', $code , '.xml')" />
  </p:load>

  <p:for-each name="files" >
    <p:with-input select="/*:plan-group/*:plans/*:plan/*:code"  />
    <p:output port="result">
      <p:pipe step="iteration-end" port="result"/>
    </p:output>
    
    <p:load name="load-plan-content"  >
      <p:with-option
	  name="href" select="concat('../../report/plan-evaluation/', ./*:code/text(), '.xml')" />
    </p:load>
    <p:identity name="iteration-end" />
  </p:for-each>
  
  <p:wrap-sequence name="plans-wrap" wrapper="evaluations" />

  <p:identity name="summary" />
  
  <p:insert name="insertion" match="/*/*[last()]" position="after">
    <p:with-input port="source">
      	<p:pipe step="load-group-content" port="result"/>
    </p:with-input>
    <p:with-input port="insertion">
      	<p:pipe step="summary" port="result"/>
    </p:with-input>
  </p:insert>

<!--
  <p:store name="debug-serialization" >
    <p:with-input port="source">
      	<p:pipe step="insertion" port="result"/>
    </p:with-input>
    <p:with-option name="href" select="'../../report/debug-group-report.xml'" />
  </p:store>
-->
  
  <p:xslt name="final-list">
    <p:with-input port="stylesheet" href="./plan-group-view.xsl"/>
  </p:xslt>

  <sal:add-header/>
  
  <p:store name="report-serialization" >
    <p:with-option name="href" select="concat('../../report/plan-group/',$code,'.html')" />
  </p:store>

</p:declare-step>
