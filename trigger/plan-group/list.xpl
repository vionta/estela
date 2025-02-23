<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:sal="http://www.vionta.net/ns/xproc/1.0/salvora"
    version="3.0">

  <p:import href="../template/add-header.xpl" />
  <p:input port="source" primary="true" ><p:inline><documento><otro></otro></documento></p:inline></p:input>
  
  <p:output port="result" primary="true"
	    pipe="result@isses-directory-list" />
  
  <p:directory-list
      name="isses-directory-list"
      include-filter=".xml" >
    <p:with-option name="path" select="'../../data/plan-group'" />
  </p:directory-list>

  <p:for-each name="files" >
    <p:with-input select="//*:file[@*:name]"  />
    
    <p:output port="result">
      <p:pipe step="fin-1" port="result"/>
    </p:output>
    
    <p:load name="load-file-content"  >
      <p:with-option
	  name="href" select="concat('../../data/plan-group/', .//@*:name)" />
    </p:load>

    <p:identity name="plan-group-point" />

    <p:for-each name="plans" >
      <p:with-input select="//*:plan/*:code"  />
      
      <p:load name="load-plan-content"  >
	<p:with-option
	    name="href" select="concat('../../report/plan-evaluation/', code/text() , '.xml')" />
      </p:load>

    </p:for-each>
    <p:wrap-sequence name="stats-list" wrapper="stats" />

    
    <p:insert name="insertion"  position="first-child">
      <p:with-input port="source">
      	<p:pipe step="plan-group-point" port="result"/>
      </p:with-input>
      <p:with-input port="insertion">
      	<p:pipe step="stats-list" port="result"/>
      </p:with-input>
    </p:insert>


    
    <!-- 
    <p:for-each name="plans" >
      <p:with-input select="/*:groups/plan-group/plans/plan"  />

      <p:load name="load-plan-content"  >
	<p:with-option
	    name="href" select="concat('../../data/PerformancePlanOrReport/', *:code/text() , '.xml')" />
      </p:load>
      
      <p:filter select="/PerformancePlanOrReport/*:stats" name="insertion-stats"/>

      <p:insert name="insertion" match="*:stats" position="after">
	<p:with-input port="source">
      	  <p:pipe step="plan-group-point" port="result"/>
	</p:with-input>
	<p:with-input port="insertion">
      	  <p:pipe step="insertion-stats" port="result"/>
	</p:with-input>
      </p:insert>
      
      </p:for-each>
      -->
    <!--
    <p:wrap-sequence name="plan-list" wrapper="plans" />

    <p:insert name="insertion" match="/*/*[last()]" position="after">
      <p:with-input port="source">
      	<p:pipe step="load-group-content" port="result"/>
      </p:with-input>
      <p:with-input port="insertion">
      	<p:pipe step="summary" port="result"/>
      </p:with-input>
    </p:insert>
      -->


    
    <p:identity name="fin-1" />

  </p:for-each>
  
  <p:wrap-sequence name="group-list" wrapper="groups" />
  <!-- Debug, for now it does not have actual plan or evaluation remarks 
  <p:store name="debug-groups" >
    <p:with-option name="href" select="concat('../../report/plan-groups-debug', '.xml')" />
  </p:store>
  -->

  <p:store name="log-plan-group" >
    <p:with-option name="href" select="concat('../../report/plan-groups-log', '.log')" />
  </p:store>

  <p:xslt name="final-list">
    <p:with-input port="stylesheet" href="./plan-groups-view.xsl"/>
  </p:xslt>
  <sal:add-header/>

  <p:store name="report-serialization" >
    <p:with-option name="href" select="concat('../../report/plan-groups', '.html')" />
  </p:store>

</p:declare-step>
