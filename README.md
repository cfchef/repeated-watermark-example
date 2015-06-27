# Repeating Watermark with ColdFusion & Java

Here's an example...

```coldfusion
<cfscript>
	
x = createObject("component", "Watermark").init();
x.addTextWatermark("test", expandPath("./your_image.jpg"), expandPath("./another_name.jpg"));
</cfscript>
Done.

<cfoutput>
	<br><br><br>
	<div style="padding: 5px; background-color: ##ccc;">
	<span><img src="your_image.jpg"></span>
	<span><img src="another_name.jpg"></span>
	</div>
</cfoutput>
```
