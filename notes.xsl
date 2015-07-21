<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" encoding="UTF-8"/>
<xsl:key name="groups" match="notes/note" use="@cites"/>
<xsl:template match="record">
<!-- The Main Transformation-->
<html>
  <body>
    <h2><xsl:value-of select="author"/>, <xsl:if test="a_title !=''">"<xsl:value-of select="a_title"/>", </xsl:if> <i><xsl:value-of select="title"/></i>&#160;<xsl:if test="city !=''">
    (<xsl:value-of select="city"/>: <xsl:value-of select="publisher"/>, <xsl:value-of select="year"/>)
    </xsl:if><xsl:value-of select="volume"/>:<xsl:value-of select="issue"/>
    <xsl:if test="city =''">(<xsl:value-of select="year"/>)</xsl:if><xsl:if test="p_start !=''">, pp. <xsl:value-of select="p_start"/>-<xsl:value-of select="p_end"/></xsl:if>.</h2>
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

!-- Sorts notes by reference number, reconnecting evidence and definitions to appropriate assertions

<xsl:template match="notes">
  <xsl:apply-templates>
     <xsl:sort select="@ref" data-type="number"/>
   </xsl:apply-templates>
</xsl:template>

!-- Styles main article or chapter argument, placing quotations in blue and syntheses of article-text and note-taker thoughts in green

<xsl:template match="note[@form='argument' and @type='p']">
<p style="margin-left:-40px;">Argument: <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>
<xsl:template match="note[@form='argument' and @type='q']">
<p style="margin-left:-40px;">Argument: <font style="color:blue;">"<xsl:value-of select="."/>" </font>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>
<xsl:template match="note[@form='argument' and @type='s']">
<p style="margin-left:-40px;">Argument: <font style="color:green;"><xsl:value-of select="."/></font>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>

!-- Styles all assertions as flush with left margin, and no bullet, placing quotations in blue and syntheses of article-text and note-taker thoughts in green

<xsl:template match="note[@form='assertion' and @type='p']">
<p style="margin-left:-30px;"><xsl:value-of select="@ref"/>. <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>
<xsl:template match="note[@form='assertion' and @type='q']">
<p style="margin-left:-30px;"><xsl:value-of select="@ref"/>. <font style="color:blue;">"<xsl:value-of select="."/>" </font>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></p>
</xsl:template>
<xsl:template match="note[@form='assertion' and @type='s']">
<p style="margin-left:-30px;"><xsl:value-of select="@ref"/>. <font style="color:green;"><xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></font></p>
</xsl:template>

!-- Styles all pieces of evidence with a black circle bullet, placing quotations in blue and syntheses of article-text and note-taker thoughts in green

<xsl:template match="note[@form='evidence' and @type='p']">
<li><xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>
<xsl:template match="note[@form='evidence' and @type='q']">
<li><font style="color:blue;">"<xsl:value-of select="."/>" </font>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>
<xsl:template match="note[@form='evidence' and @type='s']">
<li><font style="color:green;"><xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></font></li>
</xsl:template>

!-- Styles all definitions with a white circle bullet, placing quotations in blue and syntheses of article-text and note-taker thoughts in green

<xsl:template match="note[@form='definition' and @type='p']">
  <li style="list-style-type:circle;"><xsl:value-of select="."/> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>
<xsl:template match="note[@form='definition' and @type='q']">
  <li style="list-style-type:circle;"><font style="color:blue;">"<xsl:value-of select="."/>"</font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>
<xsl:template match="note[@form='definition' and @type='s']">
<li style="list-style-type:circle;"><font style="color:green;"><xsl:value-of select="."/></font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''"> via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

!-- Styles all methodologies with a square, placing quotations in blue and syntheses of article-text and note-taker thoughts in green

<xsl:template match="note[@form='methodology' and @type='p']">
  <li style="list-style-type:square;"><xsl:value-of select="."/> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>
<xsl:template match="note[@form='methodology' and @type='q']">
  <li style="list-style-type:square;"><font style="color:blue;">"<xsl:value-of select="."/>"</font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>
<xsl:template match="note[@form='methodology' and @type='s']">
<li style="list-style-type:square;"><font style="color:green;"><xsl:value-of select="."/></font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''"> via (<xsl:value-of select="@cites"/>)</xsl:if></li>
</xsl:template>

</xsl:stylesheet>
