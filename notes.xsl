<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" encoding="UTF-8"/>

<!-- Creates a rationalise list of citations -->
<xsl:key name="groups" match="notes/note" use="@cites"/>

<!-- Removes blank lines in notes list -->
<xsl:template match="*/text()[normalize-space()]">
<xsl:value-of select="normalize-space()"/>
</xsl:template>

<xsl:template match="*/text()[not(normalize-space())]" />

<!-- Main HTML Template -->
<xsl:template match="record">
<html>
  <body>
    <h2><xsl:value-of select="l_author"/>, <xsl:value-of select="f_author"/>. <xsl:if test="a_title !=''">"<xsl:value-of select="a_title"/>"</xsl:if><xsl:if test="f_editor_1 !=''">in <xsl:value-of select="f_editor_1"/>&#160;<xsl:value-of select="l_editor_1"/></xsl:if><xsl:if test="f_editor_2 !=''"> and <xsl:value-of select="f_editor_2"/>&#160;<xsl:value-of select="l_editor_2"/> (eds)</xsl:if><xsl:if test="f_editor_1 !='' and f_editor_2 =''"> (ed.),</xsl:if><xsl:if test="f_editor_1 ='' and f_editor_2 !=''">,</xsl:if> <i><xsl:value-of select="title"/></i> <xsl:if test="city !=''">(<xsl:value-of select="city"/>: <xsl:value-of select="publisher"/>, <xsl:value-of select="year"/>)</xsl:if> <xsl:if test="volume !=''"><xsl:value-of select="volume"/>:<xsl:value-of select="issue"/></xsl:if> <xsl:if test="city =''">(<xsl:value-of select="year"/>)</xsl:if> <xsl:if test="p_start !=''">, pp. <xsl:value-of select="p_start"/>-<xsl:value-of select="p_end"/></xsl:if>.</h2>
    <ul><xsl:for-each select="notes"><xsl:apply-templates select="."/></xsl:for-each></ul>
    <h3>Citation List</h3>
    <ul>
      <xsl:for-each select="notes/note[count(. | key('groups', @cites)[1]) = 1]">
    		<xsl:sort select="@cites" />
    		<xsl:if test="@cites !=''"><li><xsl:value-of select="@cites" /></li></xsl:if>
    	</xsl:for-each>
    </ul>
</body>
</html>
</xsl:template>

<!-- Sorts notes by assertion reference. Default is numeric -->
<xsl:template match="notes">
  <xsl:apply-templates>
     <xsl:sort select="@ref" data-type="number"/>
   </xsl:apply-templates>
</xsl:template>

<!-- Styles argument statements, black for paraphrase, blue for quotations and green for synthesis with notetaker thoughts -->
<xsl:template match="note[@form='argument' and @type='p']">
<p style="margin-left:-40px;">Argument: <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

<xsl:template match="note[@form='argument' and @type='q']">
<p style="margin-left:-40px;">Argument: <font style="color:blue;">"<xsl:value-of select="."/>" </font>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

<xsl:template match="note[@form='argument' and @type='s']">
<p style="margin-left:-40px;">Argument: <font style="color:green;"><xsl:value-of select="."/></font>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

<!-- Styles assertions / points, black for paraphrase, blue for quotations and green for synthesis with notetaker thoughts -->
<xsl:template match="note[@form='assertion' and @type='p']">
<p style="margin-left:-30px;"><xsl:value-of select="@ref"/>. <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

<xsl:template match="note[@form='assertion' and @type='q']">
<p style="margin-left:-30px;"><xsl:value-of select="@ref"/>. <font style="color:blue;">"<xsl:value-of select="."/>" </font>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

<xsl:template match="note[@form='assertion' and @type='s']">
<p style="margin-left:-30px;"><xsl:value-of select="@ref"/>. <font style="color:green;"><xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></font></p>
</xsl:template>

<!-- Styles pieces of evidence, black for paraphrase, blue for quotations and green for synthesis with notetaker thoughts -->
<xsl:template match="note[@form='evidence' and @type='p']">
<li><xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

<xsl:template match="note[@form='evidence' and @type='q']">
<li><font style="color:blue;">"<xsl:value-of select="."/>" </font>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

<xsl:template match="note[@form='evidence' and @type='s']">
<li><font style="color:green;"><xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></font></li>
</xsl:template>

<!-- Styles definitions, black for paraphrase, blue for quotations and green for synthesis with notetaker thoughts -->
<xsl:template match="note[@form='definition' and @type='p']">
  <li style="list-style-type:circle;"><xsl:value-of select="."/> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

<xsl:template match="note[@form='definition' and @type='q']">
  <li style="list-style-type:circle;"><font style="color:blue;">"<xsl:value-of select="."/>"</font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

<xsl:template match="note[@form='definition' and @type='s']">
<li style="list-style-type:circle;"><font style="color:green;"><xsl:value-of select="."/></font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''"> via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

<!-- Styles methodology statements, black for paraphrase, blue for quotations and green for synthesis with notetaker thoughts -->
<xsl:template match="note[@form='methodology' and @type='p']">
  <li style="list-style-type:square;"><xsl:value-of select="."/> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

<xsl:template match="note[@form='methodology' and @type='q']">
  <li style="list-style-type:square;"><font style="color:blue;">"<xsl:value-of select="."/>"</font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

<xsl:template match="note[@form='methodology' and @type='s']">
<li style="list-style-type:square;"><font style="color:green;"><xsl:value-of select="."/></font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''"> via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

<!-- Styles background/context statements, all bold, black for paraphrase, blue for quotations and green for synthesis with notetaker thoughts -->
<xsl:template match="note[@form='background' and @type='p']">
<p style="font-weight:bold;margin-left:-30px;">Background: <xsl:value-of select="."/> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

<xsl:template match="note[@form='background' and @type='q']">
<p style="font-weight:bold;margin-left:-30px;">Background: <font style="color:blue;">"<xsl:value-of select="."/>"</font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

<xsl:template match="note[@form='background' and @type='s']">
<p style="font-weight:bold;margin-left:-30px;">Background: <font style="color:green;"><xsl:value-of select="."/></font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''"> via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

</xsl:stylesheet>
