<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:sal="http://www.vionta.net/ns/xproc/1.0/salvora"
    version="3.0">

  <p:import href="template/add-header.xpl" />
  <p:input port="source" primary="true" ><p:inline><documento><otro></otro></documento></p:inline></p:input>

  <p:option name="entity" />
  
  <p:output port="result" primary="true"
	    pipe="result@isses-directory-list" />

  <p:directory-list
    name="isses-directory-list"
        include-filter=".xml" >
          <p:with-option name="path" select="concat('../data/', $entity)" />
  </p:directory-list>

  <p:for-each name="files" >
    <p:with-input select="//*:file[@*:name]"  />

    <p:output port="result">
      <p:pipe step="fin-1" port="result"/>
    </p:output>

    <p:load name="load-file-content"  >
      <p:with-option
      name="href" select="concat('../data/', $entity, '/', .//@*:name)" />
    </p:load>
    <p:identity name="fin-1" />
  </p:for-each>
  
  <p:wrap-sequence name="lista-issues-2" wrapper="issues" />


<p:xslt name="final-list">
    <p:with-input port="stylesheet" href="./list.xsl"/>
    <p:with-option name="parameters" select="map {'entity': $entity }"/>
  </p:xslt>

  <p:xslt name="issue-report">
    <p:with-input port="stylesheet" href="./generic-entity-report.xsl"/>
    <p:with-input port="source" pipe="result@lista-issues-2" />
  </p:xslt>
  
  <p:xslt name="options">
    <p:with-input port="stylesheet" href="./options.xsl"/>
        <p:with-input port="source" pipe="result@lista-issues-2" />	
  </p:xslt>

  <sal:add-header>
    <p:with-input port="source" pipe="result@final-list" />	
  </sal:add-header>
  

  <p:store name="issue-list-serialization" >
      <p:with-option name="href" select="concat('../conf/index/', $entity, '.html')" />
  </p:store>

  <p:store name="issue-content-serialization"> 
     <p:with-option name="href" select="concat('../conf/index/', $entity, '.xml')"  />
     <p:with-input port="source" pipe="result@lista-issues-2" />	
  </p:store>

  <p:store name="issue-options-file" >
    <p:with-option name="href" select="concat('../conf/index/options-', $entity, '.xml')"    />
    <p:with-input port="source" pipe="result@options" />	
  </p:store>
  
  <p:store name="issue-report-file" >
    <p:with-option name="href" select="concat('../conf/index/', $entity, '-report.html')"    />
    <p:with-input port="source" pipe="result@issue-report" />	
  </p:store>

</p:declare-step>
