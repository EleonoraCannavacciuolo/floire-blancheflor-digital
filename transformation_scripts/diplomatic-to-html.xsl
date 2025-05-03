<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="xml" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>Diplomatic Edition - Floire et Blancheflor</title>
        <link rel="stylesheet" href="../style.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
      </head>
      <body>
        <header>
          <h1>Floire et Blancheflor - Diplomatic Edition</h1>
          <nav>
            <ul>
              <li><a href="../index.html">Home</a></li>
              <li><a href="../xii.html">12th Century Version</a></li>
              <li><a href="../xiii.html">13th Century Version</a></li>
            </ul>
          </nav>
        </header>

        <main>
          <section id="edition-text">
            <xsl:apply-templates select="//tei:body"/>
          </section>
        </main>

        <footer>
          <p>© 2025 Eleonora Cannavacciuolo. Digital Humanities Project.</p>
        </footer>
      </body>
    </html>
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
      <xsl:apply-templates/>
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
