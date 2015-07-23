<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:key name="groups" match="notes/note" use="@cites"/>
 <xsl:template match="*/text()[normalize-space()]">
  <xsl:value-of select="normalize-space()"/>
 </xsl:template>
 <xsl:template match="*/text()[not(normalize-space())]" />
 <xsl:template match="record">

# <xsl:value-of select="l_author"/>, <xsl:value-of select="f_author"/>. <xsl:if test="a_title !=''">"<xsl:value-of select="a_title"/>"</xsl:if><xsl:if test="f_editor_1 !=''">in <xsl:value-of select="f_editor_1"/>&#160;<xsl:value-of select="l_editor_1"/></xsl:if><xsl:if test="f_editor_2 !=''"> and <xsl:value-of select="f_editor_2"/>&#160;<xsl:value-of select="l_editor_2"/> (eds)</xsl:if><xsl:if test="f_editor_1 !='' and f_editor_2 =''"> (ed.),</xsl:if><xsl:if test="f_editor_1 ='' and f_editor_2 !=''">,</xsl:if> *<xsl:value-of select="title"/>* <xsl:if test="city !=''">(<xsl:value-of select="city"/>: <xsl:value-of select="publisher"/>, <xsl:value-of select="year"/>)</xsl:if> <xsl:if test="volume !=''"><xsl:value-of select="volume"/>:<xsl:value-of select="issue"/></xsl:if> <xsl:if test="city =''">(<xsl:value-of select="year"/>)</xsl:if> <xsl:if test="p_start !=''">, pp. <xsl:value-of select="p_start"/>-<xsl:value-of select="p_end"/></xsl:if>. #
<xsl:for-each select="notes"><xsl:apply-templates select="."/></xsl:for-each>

## Citation List ##
<xsl:for-each select="notes/note[count(. | key('groups', @cites)[1]) = 1]">  <xsl:sort select="@cites" />
<xsl:if test="@cites !=''">
+ <xsl:value-of select="@cites" />  </xsl:if>
</xsl:for-each>
</xsl:template>

<xsl:template match="notes">
 <xsl:apply-templates>
  <xsl:sort select="@ref" data-type="number"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="note[@form='argument' and @type='p']">
### Argument: <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>

</xsl:template>

<xsl:template match="note[@form='argument' and @type='q']">
### Argument: "<xsl:value-of select="."/>  "  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>

</xsl:template>

<xsl:template match="note[@form='argument' and @type='s']">
### Argument: <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>

</xsl:template>

<xsl:template match="note[@form='assertion' and @type='p']">
<xsl:text>&#xa;&#xa;</xsl:text>#### <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='assertion' and @type='q']">
<xsl:text>&#xa;&#xa;</xsl:text>#### "<xsl:value-of select="."/>  "  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='assertion' and @type='s']">
<xsl:text>&#xa;&#xa;</xsl:text>#### *<xsl:value-of select="."/>*  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='evidence' and @type='p']">
+ E: <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='evidence' and @type='q']">
+ E: "<xsl:value-of select="."/>  "  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='evidence' and @type='s']">
+ E: *<xsl:value-of select="."/>*  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='definition' and @type='p']">
+ D: <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='definition' and @type='q']">
+ D: "<xsl:value-of select="."/>  " (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='definition' and @type='s']">
+ D: *<xsl:value-of select="."/>*  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='methodology' and @type='p']">
+ M: <xsl:value-of select="."/>  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='methodology' and @type='q']">
+ M: "<xsl:value-of select="."/>  " (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='methodology' and @type='s']">
+ M: *<xsl:value-of select="."/>*  (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">  via (<xsl:value-of select="@cites"/><xsl:if test="@p_cites !=''">, p. <xsl:value-of select="@p_cites"/></xsl:if>)</xsl:if>
</xsl:template>

<xsl:template match="note[@form='background' and @type='p']">
<xsl:text>&#xa;&#xa;</xsl:text>**Background: <xsl:value-of select="."/> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if>**
</xsl:template>

<xsl:template match="note[@form='background' and @type='q']">
<xsl:text>&#xa;&#xa;</xsl:text>**Background:"<xsl:value-of select="."/>"</font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''">via (<xsl:value-of select="@cites"/>)</xsl:if>**
</xsl:template>

<xsl:template match="note[@form='background' and @type='s']">
<xsl:text>&#xa;&#xa;</xsl:text>**Background: <xsl:value-of select="."/></font> (pp. <xsl:value-of select="@pg"/>) <xsl:if test="@cites !=''"> via (<xsl:value-of select="@cites"/>)</xsl:if>**
</xsl:template>

</xsl:stylesheet>
