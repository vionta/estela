xquery version "3.0" encoding "UTF-8";



declare function local:getItemPositions($data) {
<datados>
</datados>
};

<things-sorted count="{count(collection()//thing)}">
  {
    for $thing in collection()//thing
      order by @id
    return
      $thing
  }

{local:getItemPositions(<noimporta/>)}
</things-sorted>