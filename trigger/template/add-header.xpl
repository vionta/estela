<?xml version="1.0" encoding="utf-8"?>
<p:declare-step
    name="add-header" 
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:sal="http://www.vionta.net/ns/xproc/1.0/salvora"
    type="sal:add-header" 
    version="3.0">

  <p:input port="source" primary="true" ><p:inline><void value="4" /></p:inline></p:input>
  
  <p:output port="result" primary="true" />

  <p:insert name="insert-header" match="//*:body" position="first-child"   >
    <p:with-input port="insertion" href="head.xml" />
  </p:insert>
  
  <p:insert name="insert-footer" match="//*:body" position="last-child"   >
    <p:with-input port="insertion" href="footer.xml" />
  </p:insert>

</p:declare-step>
