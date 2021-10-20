<?xml version="1.0" encoding="UTF-8"?>

<!--

Apply `rdf:about` identifier attributes to elements which have child <id> nodes.

-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>


<!-- RDF wrapper. -->
<xsl:template match="/">
    <rdf:RDF>
        <xsl:apply-templates select="@*|node()"/>
    </rdf:RDF>
</xsl:template>

<!-- Copy nodes. -->
<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

<!-- Migrate <id> text to parent attribute. -->
<xsl:template match="*[id]">
    <xsl:copy>
        <xsl:attribute name="rdf:about">
            <xsl:value-of select="./id"/>
        </xsl:attribute>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>

<!-- Remove unwanted node(s). -->
<xsl:template match="id"/>

<!-- Clean up blank space. -->
<xsl:template match="text()">
    <xsl:value-of select="normalize-space()" />
</xsl:template>

</xsl:stylesheet>
