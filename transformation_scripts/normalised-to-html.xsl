<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">

  <xsl:output method="xml" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

  <xsl:variable name="gallicaBase" select="//tei:idno[@type='gallica']"/>


  <xsl:template match="/">
    
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>Floire et Blancheflor : édition interprétative</title>
        <link rel="stylesheet" href="../style.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
      </head>
      <body>
        <aside id="page-index">
          <ul>
            <xsl:for-each select="//tei:pb">
              <!-- Sort by numeric part -->
              <xsl:sort select="number(translate(@n, 'rv ', ''))" data-type="number"/>
              <!-- Then by side: r before v -->
              <xsl:sort select="contains(@n, 'v')" data-type="number"/>

              <li>
                <a href="#page-{@n}">
                  <xsl:value-of select="@n"/>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </aside>
        <div class="wrapper">
        <header>
          <h1><em>Floire et Blancheflor</em> : édition interprétative</h1>
          <nav>
            <ul>
              <li><a href="../index.html">Home</a></li>
              <li><a href="../xii.html">Version du XIIe siècle</a></li>
              <li><a href="../xiii.html">Version du XIIIe siècle</a></li>
            </ul>
          </nav>
        </header>
        <main class="with-sidebar">
          <section id="edition-text">
            <xsl:apply-templates select="//tei:body"/>
          </section>
        </main>

        <footer>
          <p>© 2025 Eleonora Cannavacciuolo, Université de Genève</p>
        </footer>
        
      </div>

      <button id="scrollToTop" title="Go to top"><i class="fa-solid fa-arrow-up"></i></button>

      <xsl:text disable-output-escaping="yes">
        &lt;script src="../js/scrollToTop.js"&gt;&lt;/script&gt;
      </xsl:text>
      
      </body>
    </html>
  </xsl:template>

  <!-- Template for body content -->
  <xsl:template match="tei:body">
    <div class="text">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

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
    <xsl:variable name="pageID" select="@n"/>
    <xsl:variable name="folio" select="@facs"/>
    <xsl:variable name="url" select="concat($gallicaBase, $folio)"/>
      <hr id="page-{$pageID}"/>
      <div class="position-label pagebreak" id="page-{$pageID}">
        <a href="{$url}" target="_blank">
          <xsl:value-of select="@n"/> a
        </a>
      </div>
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

    <!-- Template for column breaks -->
  <xsl:template match="tei:cb">
    <xsl:variable name="cbNumber">
      <xsl:number count="tei:cb" from="tei:pb" level="any"/>
    </xsl:variable>
    <div class="position-label column-break">
      <xsl:value-of select="substring('abcdefghijklmnopqrstuvwxyz', $cbNumber + 1, 1)"/>
    </div>
  </xsl:template>


  <!-- Default text output -->
  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>


  <xsl:template match="tei:hi[@rend='lettrine']">
    <span class="lettrine">
      <xsl:apply-templates/>
   </span>
  </xsl:template>

<xsl:template match="tei:hi[@rend='rubric']">
  <span class="rubric">
    <xsl:apply-templates/>
  </span>
</xsl:template>

</xsl:stylesheet>


