<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform
    version="1.0"
    xmlns:ol="http://ns.editeur.org/onix/3.0/reference"
    xmlns:os="http://ns.editeur.org/onix/3.0/short"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

    <xsl:variable name="table" select="document('OnixTable.xml')"/>

    <xsl:template match="*">
        <xsl:choose>
            <xsl:when test="namespace-uri(.) = 'http://ns.editeur.org/onix/3.0/short'">
                <xsl:variable name="short" select="local-name()"/>
                <xsl:variable name="long">
                    <xsl:choose>
                        <xsl:when test="$table/map/element[@short = $short]">
                            <xsl:value-of select="$table/map/element[@short = $short]/@long"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$short"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:element name="ol:{$long}">
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*"/>
                    <xsl:apply-templates/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="@*|text()|comment()|processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

</xsl:transform>
