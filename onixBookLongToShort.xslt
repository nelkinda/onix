<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform
    version="1.0"
    xmlns:ol="http://ns.editeur.org/onix/3.0/reference"
    xmlns:os="http://ns.editeur.org/onix/3.0/short"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://ns.editeur.org/onix/3.0/short"
>

    <xsl:variable name="table" select="document('OnixTable.xml')"/>

    <xsl:template match="*">
        <xsl:choose>
            <xsl:when test="namespace-uri(.) = 'http://ns.editeur.org/onix/3.0/reference'">
                <xsl:variable name="long" select="local-name()"/>
                <xsl:variable name="short">
                    <xsl:choose>
                        <xsl:when test="$table/map/element[@long = $long]">
                            <xsl:value-of select="$table/map/element[@long = $long]/@short"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$long"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:element name="{$short}">
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
