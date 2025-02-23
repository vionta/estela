<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:cc="http://creativecommons.org/ns#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:svg="http://www.w3.org/2000/svg"
	xmlns="http://www.w3.org/2000/svg"
	xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
	xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
    version="3.0"
	>

	<xsl:output method="xml" indent="yes" encoding="UTF-8"></xsl:output>
		<xsl:template  match="/" >
			<svg
				xmlns:dc="http://purl.org/dc/elements/1.1/"
				xmlns:cc="http://creativecommons.org/ns#"
				xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
				xmlns:svg="http://www.w3.org/2000/svg"
				xmlns="http://www.w3.org/2000/svg"
				xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
				xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
				viewBox="0 0 450.09448819 150.3622047"
				  >	
				 <g
					inkscape:label="Datos"
					inkscape:groupmode="layer"
					id="layer1"
					transform="translate(-90.68765,-57.62685)" >
						<rect
						 style="opacity:0.744;fill:#708ade;fill-opacity:1;stroke:none;stroke-width:1.60000002;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
						 id="meses"
						 width="{85.959179 + 4 *  /fechas/@topdays}"
						 height="13.66357"
						 x="101.25478" 
						 y="136.31613" />
				<xsl:apply-templates  />
				 <path
							style="opacity:0.744;fill:#bbbb00;fill-opacity:1;stroke:none;stroke-width:1.60000002;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
							d="m {(100.02967 + (4 * /fechas/@currentdays))} ,133 10,-10 10,10 z"
							id="currentdate"
							inkscape:connector-curvature="0"
							sodipodi:nodetypes="ccccccc" />
				</g>
				 
				 
				 
				 
		</svg>
	</xsl:template>
   
   <xsl:template match="fecha"> 
		<path
			style="opacity:0.744;fill:#006e18;fill-opacity:1;stroke:none;stroke-width:1.60000002;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
			d="m {(100.02967 + (4* @days))} ,108.43359 c -5.28223,-2e-4 -9.56437,3.87688 -9.56412,8.65944 -0.0452,2.25444 0.57853,3.52104 1.18588,4.81263 l 8.33371,11.34483 8.16237,-11.34483 c 0.91804,-1.58432 1.44089,-2.83345 1.44342,-4.81263 2.5e-4,-4.78155 -4.28015,-8.65822 -9.56126,-8.65944 z"
			id="path{@days}"
			inkscape:connector-curvature="0"
			sodipodi:nodetypes="ccccccc" />
			<text
				xml:space="preserve"
				style="font-style:normal;font-weight:normal;font-size:8.75px;line-height:125%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;"
				x="{(15.959179 +  (3.2* @days))}"
				y="{(145.01231 +  (2.5* @days))}"
				id="text{@days}"
				sodipodi:linespacing="125%"
				transform="matrix(0.78411928,-0.62061015,0.62061015,0.78411928,0,0)"
				inkscape:transform-center-x="-5.8083771"
				inkscape:transform-center-y="16.667517"
				>
					<tspan sodipodi:role="line" id="tspan4160"
							style="font-size:8.75px;"><xsl:value-of  select="@name" /></tspan>
			</text>
     	
			<text
				xml:space="preserve"
				style="font-style:normal;font-weight:normal;font-size:8.75px;line-height:125%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1"
				x="-200.32614"
				y="{(105.37103 +  (4*@days))}"
				id="text{@days}-8"
				sodipodi:linespacing="125%"
				transform="matrix(0.01682167,-0.99985851,0.99985851,0.01682167,0,0)"
				inkscape:transform-center-x="-16.094779"
				inkscape:transform-center-y="6.0394942">
					<tspan sodipodi:role="line" id="tspan4160-4"
							x="-200.32614" y="{(105.37103 +  (4*@days))}"
							style="font-size:8.75px"><xsl:value-of  select="@date" /></tspan></text>  
	</xsl:template>
    
	<xsl:template match="text()">
	</xsl:template>
					
   </xsl:stylesheet>
