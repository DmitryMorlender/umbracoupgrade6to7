<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:user="urn:my-scripts" xmlns:umbraco.library="urn:umbraco.library" version="1.0" exclude-result-prefixes="xsl msxsl user umbraco.library">
<xsl:output method="html" media-type="text/html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="DTD/xhtml1-strict.dtd" cdata-section-elements="script style" indent="yes" encoding="utf-8"/>
<xsl:param name="records"/>
<xsl:template match="/">
<table style="border-collapse:collapse;border:1px solid black;">
<xsl:for-each select="$records//fields/child::*">
<xsl:sort select="@sortorder" data-type="number"/>
<tr style="border:1px solid black;">
<td valign="top" style="border:1px solid black;padding:5px;font-family:Verdana,Helvetica,Arial,sans-serif;font-size:11px;">
<strong>
<xsl:value-of select="./caption"/>
</strong>
</td>
<td valign="top" style="border:1px solid black;padding:5px;font-family:Verdana,Helvetica,Arial,sans-serif;font-size:11px;">
<xsl:choose>
<xsl:when test="contains(.//value, '/umbraco/plugins/umbracoContour/files/')">
<a href="http://{umbraco.library:RequestServerVariables('SERVER_NAME')}{.//value}">
<xsl:value-of select="substring-after(substring-after(.//value, '/files/'), '/')"/>
</a>
</xsl:when>
<xsl:otherwise>
<xsl:for-each select="./values/value">
<xsl:if test="position() > 1">
<br/>
</xsl:if>
<xsl:value-of select="umbraco.library:ReplaceLineBreaks(.)"/>
</xsl:for-each>
</xsl:otherwise>
</xsl:choose>
</td>
</tr>
</xsl:for-each>
</table>
</xsl:template>
</xsl:stylesheet>