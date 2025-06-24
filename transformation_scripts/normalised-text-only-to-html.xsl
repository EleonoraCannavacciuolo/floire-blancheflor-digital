<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="xml" indent="yes" encoding="UTF-8" />
  <xsl:param name="base-id"></xsl:param>

  <xsl:template match="/">
    <div class="edition-text">
      <xsl:apply-templates select="//tei:body"/>
    </div>
  </xsl:template>

  <!-- Template for body content -->
  <xsl:template match="tei:body">
    <div class="text">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Template for lines -->
<xsl:template match="tei:l">
  <p class="line">
    <xsl:attribute name="id">
        <xsl:text>l</xsl:text>
        <xsl:number count="tei:l" format="0000"  level="any"/>
      </xsl:attribute>

    <xsl:variable name="lineNumber">
      <xsl:number count="tei:l" level="any"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$lineNumber mod 5 = 0">
        <span class="ln">
          <xsl:value-of select="$lineNumber"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text disable-output-escaping="yes">
          &lt;span class="ln"&gt;&lt;/span&gt;
        </xsl:text> 
        
      </xsl:otherwise>
    </xsl:choose>

    <span class="line-text">
      <xsl:apply-templates/>
    </span>
  </p>
</xsl:template>

  <!-- Template for page breaks -->
  <xsl:template match="tei:pb">
    <hr/>
    <p class="pagebreak">Page <xsl:value-of select="@n"/></p>
  </xsl:template>

  <!-- Template for line breaks -->
  <xsl:template match="tei:lb">
    <br/>
  </xsl:template>

  <!-- Template for abbreviations -->
  <xsl:template match="tei:g">
    <span class="abbreviation">
      <xsl:attribute name="title">
        <xsl:value-of select="@ref"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Template for highlights -->
  <xsl:template match="tei:hi">
    <span class="highlight">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Template for punctuation -->
  <xsl:template match="tei:pc">
    <span class="punctuation">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Default text output -->
  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>

</xsl:stylesheet>
