module namespace svg-circle = 'http://com.jorge/report/circlesvg';

import module namespace math="http://exslt.org/math";

(:~
 : This function generates the welcome page.
 : @return HTML page
 :)
declare
(:
  %rest:path("arco.svg")
  %output:method("xml")
  %output:omit-xml-declaration("no")
  %output:doctype-public("-//W3C//DTD SVG 1.1//EN")
  %output:doctype-system("http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd")
  :)
  function svg-circle:view()
  as element() {
					<svg width="420px" height="220px"
							viewBox="0.00 0.00 420.00 220.00"
							xmlns="http://www.w3.org/2000/svg"
							xmlns:xlink="http://www.w3.org/1999/xlink"> 
											{svg-circle:piePart(310, 110, 100, 0.0,30.0, 		svg-circle:graphcolor(2, 1))}
											{svg-circle:piePart(310, 110, 100, 30.0,180.0, svg-circle:graphcolor(2, 2))}
											{svg-circle:piePart(310, 110, 100, 180.0,270.0, svg-circle:graphcolor(2, 3))}
											{svg-circle:piePart(310, 110, 100, 270.0,360.0, svg-circle:graphcolor(2, 4))}
							
											{svg-circle:pieChart(
															<data>
																	<entry position="1" value="50" key="uno" />
																	<entry position="2" value="10" key="dos" />
																	<entry position="3" value="70" key="tres" />
																	<entry position="4" value="90" key="cuatro" />
																	<entry position="5" value="100" key="cinco" />
															</data>,
															2)}
		 
											{svg-circle:barChart(<data>
																	<entry position="1" value="10" key="uno" />
																	<entry position="2" value="10" key="dos" />
																	<entry position="3" value="70" key="tres" />
																	<entry position="4" value="90" key="cuatro" />
																	<entry position="5" value="100" key="cinco" />
															</data>, 1)}
															
					</svg>
};


declare function svg-circle:getItemPositions($data) {
	
		<data>
								{
					for $item in $data/entry
					let $pos := index-of($data/entry/@key, $item/@key)
					return 			<entry position="{$pos}" value="{$item/@value}" key="{$item/@key}" />
								}																 
		</data>

};


declare function svg-circle:pieTitledChart($dataSrc, $color, $title) {

let $data := svg-circle:getItemPositions($dataSrc) 

let $total := sum($data/*/@value)
		 
let $pie := for $i in $data/*
					let $value := $i/@value
					let $pre := sum($data/*[@position < $i/@position]/@value)
					let $startAngle := round(($pre div $total) * 360) 
					let $endAngle := round( (($pre + $value) div $total) * 360)
					let $inArc := if(($endAngle - $startAngle ) >= 180 ) then "0" else "1"
				 let $startAngleRadians := ( xs:double($startAngle) * math:pi() ) div 180.0
		   let $endAngleRadians := (xs:double($endAngle) * math:pi() ) div 180.0 
		   
			return  svg-circle:piePart(110, 130, 100, $startAngle, $endAngle, svg-circle:graphcolor($color, number($i/@position)) )

let $leg := for $t in $data/*
					return <text xmlns="http://www.w3.org/2000/svg"
													x="220"
													y="{50+10 *$t /@position}"
													style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Franklin Gothic Medium Cond;-inkscape-font-specification:Franklin Gothic Medium Cond"
													>{string($t/@key)}</text> 

let $leg := for $t in $data/*
					return <text xmlns="http://www.w3.org/2000/svg"
													x="250"
													y="{50+10 *$t /@position}"
													style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Helvetica;-inkscape-font-specification:Franklin Gothic Medium Cond"
													>{string($t/@key)}</text> 
		
		let $cols := for $q in $data/*
			return 
				<path  xmlns="http://www.w3.org/2000/svg" d=" M 0,0  10,0 10,10 0,10 z "
					transform="scale(1 1) rotate(1) translate(230, {40+10 *$q/@position})"
					style="color:#0000ff;fill:{svg-circle:graphcolor($color, number($q/@position)) };fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
					/>
		
			let $join := <join>{$pie}{$leg}{$cols}<text xmlns="http://www.w3.org/2000/svg"
													x="20"
													y="20"
													style="font-size:12px;font-style:bold;font-variant:normal;font-weight:bold;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Arial;-inkscape-font-specification:Franklin Gothic Medium Cond"
													>{$title}</text></join>
			return $join/* 
};


declare function svg-circle:barChart($dataSrc, $color) {
	
 let $data := svg-circle:getItemPositions($dataSrc) 

	let $total := sum($data/*/@value)
				
	let $pie := for $i in $data/*
						let $value := $i/@value
						let $pre := sum($data/*[@position < $i/@position]/@value)
					 let $length :=   (( $value div  $total )  * 100 ) 
					 
						return  <path  d=" M 0,0  10,0 10,{$length} 0, {$length} z "
																		transform="scale(1 1) rotate(1) translate({30+ ( 20 * $i/@position)}, {100 - $length  })"
																		style="color:#0000ff;fill:{svg-circle:graphcolor($color, number($i/@position)) };fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
																		/>
					
	let $leg := for $t in $data/*
						return <text
														x="250"
														y="{30+10 *$t /@position}"
														style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Franklin Gothic Medium Cond;-inkscape-font-specification:Franklin Gothic Medium Cond"
														>{string($t/@key)}</text> 
		
		let $cols := for $q in $data/*
			return 
				<path  d=" M 0,0  10,0 10,10 0,10 z "
					transform="scale(1 1) rotate(1) translate(230, {20+10 *$q/@position})"
					style="color:#0000ff;fill:{svg-circle:graphcolor($color, number($q/@position)) };fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
					/>
		
			let $join := <join>{$pie}{$leg}{$cols}</join>
			return $join/* 
};


declare function svg-circle:pieChart($dataSrc, $color) {

let $data := svg-circle:getItemPositions($dataSrc) 

let $total := sum($data/*/@value)
		 
let $pie := for $i in $data/*
					let $value := $i/@value
					let $pre := sum($data/*[@position < $i/@position]/@value)
					let $startAngle := round(($pre div $total) * 360) 
					let $endAngle := round( (($pre + $value) div $total) * 360)
					let $inArc := if(($endAngle - $startAngle ) >= 180 ) then "0" else "1"
				 let $startAngleRadians := ( xs:double($startAngle) * math:pi() ) div 180.0
		   let $endAngleRadians := (xs:double($endAngle) * math:pi() ) div 180.0 
		   
			return  svg-circle:piePart(110, 110, 100, $startAngle, $endAngle, svg-circle:graphcolor($color, number($i/@position)) )

let $leg := for $t in $data/*
					return <text xmlns="http://www.w3.org/2000/svg"
													x="220"
													y="{30+10 *$t /@position}"
													style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Franklin Gothic Medium Cond;-inkscape-font-specification:Franklin Gothic Medium Cond"
													>{string($t/@key)}</text> 

let $leg := for $t in $data/*
					return <text xmlns="http://www.w3.org/2000/svg"
													x="250"
													y="{30+10 *$t /@position}"
													style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Franklin Gothic Medium Cond;-inkscape-font-specification:Franklin Gothic Medium Cond"
													>{string($t/@key)}</text> 
		
		let $cols := for $q in $data/*
			return 
				<path  xmlns="http://www.w3.org/2000/svg" d=" M 0,0  10,0 10,10 0,10 z "
					transform="scale(1 1) rotate(1) translate(230, {20+10 *$q/@position})"
					style="color:#0000ff;fill:{svg-circle:graphcolor($color, number($q/@position)) };fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
					/>
		
			let $join := <join>{$pie}{$leg}{$cols}</join>
			return $join/* 
};



declare function svg-circle:piePart($centerX, $centerY, $radius, $startAngle, $endAngle, $color) {
 
		let $inArc := if(($endAngle - $startAngle ) >= 180 ) then "0" else "1"
		let $startAngleRadians := ( xs:double($startAngle) * math:pi() ) div 180.0
		let $endAngleRadians := (xs:double($endAngle) * math:pi() ) div 180.0 
		  
			
			return 
			<path xmlns="http://www.w3.org/2000/svg"
		d=" M 0,0  {$radius * math:cos($startAngleRadians)},{$radius * math:sin($startAngleRadians)} A 100 100 0 0 {$inArc}  {$radius * math:cos($endAngleRadians)} {$radius * math:sin($endAngleRadians)} l   {$radius * math:cos($endAngleRadians)},{$radius * math:sin($endAngleRadians)} z " 
		transform="scale(1 1) rotate(1) translate({$centerX} {$centerY})"
		
		style="color:#0000ff;fill:{$color};fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:0;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"
      
		/>
	
	
};
	
(:
  return {
    x: centerX + (radius * math:cos(angleInRadians)),
    y: centerY + (radius * Math.sin(angleInRadians))
	let $coords := <coords><x>1,2</x><y>1,2</y></coords>
  };
:)
declare function svg-circle:polarToCartesian($centerX, $centerY, $radius, $angleInDegrees) {
 let $angleInRadians := ($angleInDegrees - 90) * 3.14 / 180.0
	let $coords := <coords    x="{$centerX + ($radius * math:cos(3.12))}" y="{$centerY + ($radius * math:sin(1.92))}"  ><x>{$centerX + ($radius * math:cos(3.12))}</x><y>{$centerY + ($radius * math:sin(1.92))}</y></coords>

	return $coords
};


(:
  let $largeArcFlag = $endAngle - $startAngle <= 180 ? "0" : "1";
			let $start := <coords><z>1,2</z><y>1,2</y></coords>
:)
declare function svg-circle:describeArc($x, $y, $radius, $startAngle, $endAngle){
	
    let $start := svg-circle:polarToCartesian($x, $y, $radius, $endAngle)
    let $end := svg-circle:polarToCartesian($x, $y, $radius, $startAngle)
				let $largeArcFlag := if($endAngle - $startAngle <= 180) then 0 else 1
    let $d := "m " || string($start/@x)  || "," || string($start/@y) ||  " a " ||  $radius  || "," ||  $radius ||" 0 0 " || 1 || " " || string($start/@x)  ||"," || string($start/@y ) || " l " || string($end/@x)  ||","
				|| string($end/@y ) || " z"
    
    return $d       
};


declare function svg-circle:graphcolor($type, $position) {
	svg-circle:graphcolors($type)/*[$position]/text()
}; 

declare function svg-circle:graphcolors($type) {
  let $color := <types>
		  <colors id="1">
		  <color>#333366</color>
		  <color>#666699</color>
		  <color>#9999af</color>
		  <color>#afafbf</color>
		  <color>#bfbfcf</color>
		  <color>#cfcfdf</color>
		  <color>#dfdfef</color>
		  <color>#efefff</color>
		  
		  
		  <color>#660000</color>
		  <color>#aa3333</color>
		  <color>#cc6666</color>
		  <color>#dd9999</color>
		  <color>#eeaaaa</color>
		  <color>#ccbbbb</color>
		  <color>#ddcccc</color>
		  <color>#ffdddd</color>
		  <color>#ffeeee</color>
		  <color>#ffffff</color>
		  </colors>
		  <colors id="3">
		  <color>#660000</color>
		  <color>#aa3333</color>
		  <color>#cc6666</color>
		  <color>#dd9999</color>
		  <color>#eeaaaa</color>
		  <color>#ccbbbb</color>
		  <color>#ddcccc</color>
		  <color>#ffdddd</color>
		  <color>#ffeeee</color>
		  <color>#ffffff</color>
		  <color>#660000</color>
		  <color>#a03333</color>
		  <color>#c06666</color>
		  <color>#d09999</color>
		  <color>#ffaaaa</color>
		</colors>
		<colors id="2">
		  <color>#660000</color>
		  <color>#aa3333</color>
		  <color>#cc6666</color>
		  <color>#dd9999</color>
		  <color>#eeaaaa</color>
		  <color>#ccbbbb</color>
		  <color>#ddcccc</color>
		  <color>#ffdddd</color>
		  <color>#ffeeee</color>
		  <color>#ffffff</color>
		  <color>#660000</color>
		  <color>#aa3333</color>
		  <color>#cc6666</color>
		  <color>#dd9999</color>
		  <color>#eeaaaa</color>
		  <color>#ccbbbb</color>
		  <color>#ddcccc</color>
		  <color>#ffdddd</color>
		  <color>#ffeeee</color>
		  <color>#ffffff</color>
		</colors>
		</types>
	return $color/*[@id=$type]
}; 

