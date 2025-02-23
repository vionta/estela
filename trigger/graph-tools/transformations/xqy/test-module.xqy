xquery version "3.0" encoding "UTF-8";

import module namespace test = 'http://vionta.net/eco/format-date' at './test-module-import.xqy';
import module namespace svg-circle = 'http://com.jorge/report/circlesvg' at './basic-charts.xqy';



<things-sorted count="{count(collection()//thing)}">
  {
    for $thing in collection()//thing
      order by @id
    return
      $thing
  }
{test:getItemPositions(<noimporta/>)}

{svg-circle:view()}

</things-sorted>