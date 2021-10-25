<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    
    <xsl:variable name="baseURI">https://data.discovernewfields.org/</xsl:variable>
    <xsl:variable name="crm">http://www.cidoc-crm.org/cidoc-crm/</xsl:variable>

<xsl:template match="/">{"objects": [
    <xsl:for-each select="table[@name='ecatalogue']/tuple"><xsl:sort select="atom[@name='irn']" data-type="number"/>
        <xsl:variable name="irn"><xsl:value-of select="atom[@name='irn']"/></xsl:variable>
        <xsl:variable name="title"><xsl:value-of select="replace(atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/></xsl:variable>
      <!--  <xsl:variable name="dimensions" select="('Earthquake Box Dimensions','Housing Dimensions','IMA Number Applied','IMA Number Cannot Be Applied','IMA Number Incorrectly Applied','IMA Number Not Yet Applied','See Related Parts','Storage Boxe Dimensions','This work of art is not framed.','')"/>
        <xsl:variable name="dimensions2" select="('Base','Framed','Image Dimensions','Mount','Overall Image','Plate','Sheet')"/>-->{<!--
        
Header-->
        "<xsl:copy-of select="$irn"/>": {
            "@context": "https://linked.art/ns/v1/linked-art.json",
            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>",
            "type": "HumanMadeObject",
            "_label": "<xsl:copy-of select="$title"/>",<xsl:if test="(starts-with(atom[@name='TitObjectType'], 'Visual Work')) or (table[@name='ObjectTypes']/tuple/atom[@name='PhyMediaCategory'] != '')"><!--
                
Classification-->
            "classified_as": [<xsl:if test="starts-with(atom[@name='TitObjectType'], 'Visual Work')">
                {
                    "id": "http://vocab.getty.edu/aat/300133025",
                    "type": "Type",
                    "_label": "works of art"
                }<xsl:if test="contains(atom[@name='TitObjectType'], 'Drawings')">,
                {
                    "id": "http://vocab.getty.edu/aat/300033973",
                    "type": "Type",
                    "_label": "drawings (visual works)"
                }</xsl:if><xsl:if test="contains(atom[@name='TitObjectType'], 'Multimedia')">,
                {
                    "id": "http://vocab.getty.edu/aat/300047910",
                    "type": "Type",
                    "_label": "multimedia works"
                }</xsl:if><xsl:if test="contains(atom[@name='TitObjectType'], 'Needlework')">
                {
                    "id": "http://vocab.getty.edu/aat/300264072",
                    "type": "Type",
                    "_label": "needlework (visual works)"
                }</xsl:if><xsl:if test="contains(atom[@name='TitObjectType'], 'Paintings')">,
                {
                    "id": "http://vocab.getty.edu/aat/300033618",
                    "type": "Type",
                    "_label": "paintings (visual works)"
                }</xsl:if><xsl:if test="contains(atom[@name='TitObjectType'], 'Pastel')">,
                {
                    "id": "http://vocab.getty.edu/aat/300076922",
                    "type": "Type",
                    "_label": "pastels (visual works)"
                }</xsl:if><xsl:if test="contains(atom[@name='TitObjectType'], 'Performance')">,
                {
                    "id": "http://vocab.getty.edu/aat/300121445",
                    "type": "Type",
                    "_label": "performance art"
                }</xsl:if><xsl:if test="contains(atom[@name='TitObjectType'], 'Photograph')">,
                {
                    "id": "http://vocab.getty.edu/aat/300046300",
                    "type": "Type",
                    "_label": "photographs"
                }</xsl:if><xsl:if test="contains(atom[@name='TitObjectType'], 'Prints')">,
                {
                    "id": "http://vocab.getty.edu/aat/300041273",
                    "type": "Type",
                    "_label": "prints (visual works)"
                }</xsl:if><xsl:if test="contains(atom[@name='TitObjectType'], 'Sculpture')">,
                {
                    "id": "http://vocab.getty.edu/aat/300047090",
                    "type": "Type",
                    "_label": "sculpture (visual works)"
                }</xsl:if><xsl:if test="table[@name='ObjectTypes']/tuple/atom[@name='PhyMediaCategory'] != ''">,</xsl:if></xsl:if><xsl:for-each select="distinct-values(table[@name='ObjectTypes']/tuple/atom[@name='PhyMediaCategory'])">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>thesauri/type/<xsl:value-of select="lower-case(translate(replace(.,'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                    "type": "Type",
                    "_label": "<xsl:value-of select="."/>"
                }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
            ],</xsl:if><!--
                
Identifiers-->
            "identified_by": [
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/irn",
                    "type": "Identifier",
                    "_label": "IMA at Newfields Collections Database Number for the Object",
                    "content": <xsl:copy-of select="$irn"/>,
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404621",
                            "type": "Type",
                            "_label": "repository numbers"
                        }
                    ]
                },
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/object-number",
                    "type": "Identifier",
                    "_label": "IMA at Newfields Object Number for the Object",
                    "content": "<xsl:value-of select="atom[@name='TitAccessionNo']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300312355",
                            "type": "Type",
                            "_label": "accession numbers"
                        }
                    ]
                }<xsl:if test="atom[@name='TitPreviousAccessionNo'] != ''"><xsl:choose><xsl:when test="not(contains(atom[@name='TitPreviousAccessionNo'], '|')) and atom[@name='TitPreviousAccessionNo'] != 'No TR Number'">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/old-accession-number/1",
                    "type": "Identifier",
                    "_label": "Identifier Assigned to the Object by IMA at Newfields Prior to Acquisition",
                    "content": "<xsl:value-of select="atom[@name='TitPreviousAccessionNo']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404626",
                            "type": "Type",
                            "_label": "identification numbers"
                        }
                    ]
                }</xsl:when><xsl:when test="contains(atom[@name='TitPreviousAccessionNo'], '|')"><xsl:for-each select="tokenize(atom[@name='TitPreviousAccessionNo'],' \| ')"><xsl:if test="not(contains(., '|'))">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/old-accession-number-<xsl:value-of select="position()"/>",
                    "type": "Identifier",
                    "_label": "Identifier Assigned to the Object by IMA at Newfields Prior to Acquisition",
                    "content": "<xsl:value-of select="."/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404626",
                            "type": "Type",
                            "_label": "identification numbers"
                        }
                    ]
                }</xsl:if></xsl:for-each>
                </xsl:when><xsl:otherwise/></xsl:choose></xsl:if>,<!--
                    
Titles-->
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/title",
                    "type": "Name",
                    "_label": "Primary Title for the Object",
                    "content": "<xsl:copy-of select="$title"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404670",
                            "type": "Type",
                            "_label": "preferred terms"
                        }
                    ]
                }<xsl:if test="table[@name='AltTitles']"><xsl:for-each select="table[@name='AltTitles']/tuple">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/alt-title-<xsl:value-of select="position()"/>",
                    "type": "Name",
                    "_label": "Alternate Title for the Object",
                    "content": "<xsl:value-of select="atom[@name='TitAlternateTitles']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300417227",
                            "type": "Type",
                            "_label": "alternate titles"
                        }
                    ]
                }
            </xsl:for-each>
            </xsl:if><xsl:if test="atom[@name='TitSeriesTitle'] != ''">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/series-title",
                    "type": "Name",
                    "_label": "Title of the Series of Works of which the Object is a Part",
                    "content": "<xsl:value-of select="atom[@name='TitSeriesTitle']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300417214",
                            "type": "Type",
                            "_label": "series title"
                        }
                    ]
                }</xsl:if><xsl:if test="atom[@name='TitCollectionTitle'] != ''">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/portfolio-title",
                    "type": "Name",
                    "_label": "Title of the Portfolio of which the Object is a Part",
                    "content": "<xsl:value-of select="atom[@name='TitSeriesTitle']"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300417225",
                            "type": "Type",
                            "_label": "volume titles"
                        }
                    ]
                }</xsl:if>
        ]<xsl:if test="table[@name='Medium'] or table[@name='Support']">,<!--  
            
Materials-->
            "made_of": [<xsl:for-each select="distinct-values(table[@name='Medium']/tuple/atom[@name='PhyMedium'] | table[@name='Support']/tuple/atom[@name='PhySupport'])">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>thesauri/material/<xsl:value-of select="lower-case(translate(replace(.,'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                    "type": "Material",
                    "_label": "Material of Which the Object is Composed",
                    "content": "<xsl:value-of select="."/>"
                }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
            ]</xsl:if>,<!--

Production-->
            "produced_by": {
                "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/production",
                "type": "Production",
                "_label": "Production of the Object"<xsl:if test="table[@name='Creator1'] or table[@name='Creator2']/tuple/atom[@name='CreCreationCultureOrPeople']"><xsl:choose><xsl:when test="table[@name='Creator1']">,
                "carried_out_by": [<xsl:for-each select="table[@name='Creator1']/tuple[atom[@name='irn'] != '2741'] | table[@name='Creator1']/tuple[atom[@name='irn'] != '10661'] | table[@name='Creator1']/tuple[not(exists(atom[@name='CreCreatorAfterFollower']))]">
                    {
                        "id": "<xsl:copy-of select="$baseURI"/>actor/<xsl:copy-of select="$irn"/>",
                        "type": "Actor",
                        "_label": "<xsl:value-of select="atom[@name='SummaryData']"/>"
                    }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each></xsl:when><xsl:when test="table[@name='Creator2']/tuple[atom[@name='CreCreationCultureOrPeople']]">,
                "carried_out_by": [<xsl:for-each select="table[@name='Creator2']/tuple[atom[@name='CreCreationCultureOrPeople']]">
                    {
                    "id": "<xsl:copy-of select="$baseURI"/>thesauri/culture/<xsl:value-of select="lower-case(translate(replace(atom[@name='CreCreationCultureOrPeople'],'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                        "type": "Actor",
                        "_label": "<xsl:value-of select="atom[@name='CreCreationCultureOrPeople']"/>"
                    }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each></xsl:when><xsl:otherwise/></xsl:choose>
                ]</xsl:if><xsl:if test="atom[@name='CreDateCreated'] != '' or atom[@name='CreEarliestDate'] != '' or atom[@name='CreLatestDate'] != ''">,
                "timespan": {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/production/timespan",
                    "type": "TimeSpan",
                    "_label": "<xsl:choose><xsl:when test="atom[@name='CreDateCreated'] != ''"><xsl:value-of select="atom[@name='CreDateCreated']"/></xsl:when><xsl:when test="atom[@name='CreEarliestDate'] != '' or atom[@name='CreLatestDate'] != ''"><xsl:value-of select="atom[@name='CreEarliestDate']"/> - <xsl:value-of select="atom[@name='CreLatestDate']"/></xsl:when><xsl:otherwise>date unknown</xsl:otherwise></xsl:choose>"<xsl:if test="atom[@name='CreEarliestDate'] != '' and not(ends-with(atom[@name='CreEarliestDate'], '-'))">,
                    "begin_of_the_begin": "<xsl:choose><xsl:when test="string-length(atom[@name='CreEarliestDate']) &#60;= 5 and string-length(atom[@name='CreEarliestDate']) &#62; 0"><xsl:value-of select="format-number(atom[@name='CreEarliestDate'], '0000')"/>-01-01T00:00:00.000Z</xsl:when><xsl:when test="string-length(atom[@name='CreEarliestDate']) &#62;= 6"><xsl:value-of select="atom[@name='CreEarliestDate']"/>T00:00:00.000Z</xsl:when></xsl:choose>"</xsl:if><xsl:if test="atom[@name='CreLatestDate'] != '' and not(ends-with(atom[@name='CreLatestDate'], '-'))">,
                    "end_of_the_end": "<xsl:choose><xsl:when test="string-length(atom[@name='CreLatestDate']) &#60;= 5 and string-length(atom[@name='CreLatestDate']) &#62; 0"><xsl:value-of select="format-number(atom[@name='CreLatestDate'], '0000')"/>-12-31T23:59:59.999Z</xsl:when><xsl:when test="string-length(atom[@name='CreLatestDate']) &#62;= 6"><xsl:value-of select="atom[@name='CreLatestDate']"/>T23:59:59.999Z</xsl:when></xsl:choose>"</xsl:if>
                }</xsl:if>
            },<xsl:if test="(table[@name='Dimensions']/tuple[starts-with(atom[@name='PhyType'], 'Backing') or starts-with(atom[@name='PhyType'], 'Costume') or starts-with(atom[@name='PhyType'], 'Dimensions') or starts-with(atom[@name='PhyType'], 'Hanging') or starts-with(atom[@name='PhyType'], 'Image and Sheet') or starts-with(atom[@name='PhyType'], 'Installed') or starts-with(atom[@name='PhyType'], 'Length') or starts-with(atom[@name='PhyType'], 'Loom') or starts-with(atom[@name='PhyType'], 'Overall Dimensions') or starts-with(atom[@name='PhyType'], 'Rolled') or starts-with(atom[@name='PhyType'], 'Sight') or starts-with(atom[@name='PhyType'], 'Unframed')]) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Circumference']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Warp']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weft']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weight']) or (table[@name='Color'])"><!--

Dimensions-->
            "dimension": [<xsl:if test="(table[@name='Dimensions']/tuple[starts-with(atom[@name='PhyType'], 'Backing') or starts-with(atom[@name='PhyType'], 'Costume') or starts-with(atom[@name='PhyType'], 'Dimensions') or starts-with(atom[@name='PhyType'], 'Hanging') or starts-with(atom[@name='PhyType'], 'Image and Sheet') or starts-with(atom[@name='PhyType'], 'Installed') or starts-with(atom[@name='PhyType'], 'Length') or starts-with(atom[@name='PhyType'], 'Loom') or starts-with(atom[@name='PhyType'], 'Overall Dimensions') or starts-with(atom[@name='PhyType'], 'Rolled') or starts-with(atom[@name='PhyType'], 'Sight') or starts-with(atom[@name='PhyType'], 'Unframed')])"><xsl:for-each select="(table[@name='Dimensions']/tuple[starts-with(atom[@name='PhyType'], 'Backing') or starts-with(atom[@name='PhyType'], 'Costume') or starts-with(atom[@name='PhyType'], 'Dimensions') or starts-with(atom[@name='PhyType'], 'Hanging') or starts-with(atom[@name='PhyType'], 'Image and Sheet') or starts-with(atom[@name='PhyType'], 'Installed') or starts-with(atom[@name='PhyType'], 'Length') or starts-with(atom[@name='PhyType'], 'Loom') or starts-with(atom[@name='PhyType'], 'Overall Dimensions') or starts-with(atom[@name='PhyType'], 'Rolled') or starts-with(atom[@name='PhyType'], 'Sight') or starts-with(atom[@name='PhyType'], 'Unframed')])"><xsl:call-template name="dimensions"><xsl:with-param name="dim_type">dimension</xsl:with-param></xsl:call-template><xsl:if test="position() != last()">,</xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Circumference']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Warp']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weft']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weight']) or (table[@name='Color'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Circumference'])"><xsl:for-each select="table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Circumference']"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/circumference-<xsl:value-of select="position()"/>",
                    "type": "Dimension",
                    "_label": "Circumference of the Object",
                    "value": <xsl:choose><xsl:when test="atom[@name='PhyDiameter'] != ''"><xsl:value-of select="atom[@name='PhyDiameter']"/></xsl:when><xsl:when test="atom[@name='PhyHeight'] != ''"><xsl:value-of select="atom[@name='PhyHeight']"/></xsl:when><xsl:when test="atom[@name='PhyWidth'] != ''"><xsl:value-of select="atom[@name='PhyWidth']"/></xsl:when><xsl:when test="atom[@name='PhyDepth'] != ''"><xsl:value-of select="atom[@name='PhyDepth']"/></xsl:when></xsl:choose>,
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055623",
                            "type": "Type",
                            "_label": "circumference"
                        }
                    ]<xsl:call-template name="dim_unit"/>
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Warp']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weft']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weight']) or (table[@name='Color'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Warp'])"><xsl:for-each select="table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Warp']"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/warp-<xsl:value-of select="position()"/>",
                    "type": "Dimension",
                    "_label": "Warp of the Object",
                    "value": <xsl:choose><xsl:when test="atom[@name='PhyDiameter'] != ''"><xsl:value-of select="atom[@name='PhyDiameter']"/></xsl:when><xsl:when test="atom[@name='PhyHeight'] != ''"><xsl:value-of select="atom[@name='PhyHeight']"/></xsl:when><xsl:when test="atom[@name='PhyWidth'] != ''"><xsl:value-of select="atom[@name='PhyWidth']"/></xsl:when><xsl:when test="atom[@name='PhyDepth'] != ''"><xsl:value-of select="atom[@name='PhyDepth']"/></xsl:when></xsl:choose>,
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300227930",
                            "type": "Type",
                            "_label": "warp (textile components)"
                        }
                    ]<xsl:call-template name="dim_unit"/>
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weft']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weight']) or (table[@name='Color'])">,</xsl:if></xsl:if><xsl:if test="table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weft']"><xsl:for-each select="table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weft']"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/weft-<xsl:value-of select="position()"/>",
                    "type": "Dimension",
                    "_label": "Weft of the Object",
                    "value": <xsl:choose><xsl:when test="atom[@name='PhyDiameter'] != ''"><xsl:value-of select="atom[@name='PhyDiameter']"/></xsl:when><xsl:when test="atom[@name='PhyHeight'] != ''"><xsl:value-of select="atom[@name='PhyHeight']"/></xsl:when><xsl:when test="atom[@name='PhyWidth'] != ''"><xsl:value-of select="atom[@name='PhyWidth']"/></xsl:when><xsl:when test="atom[@name='PhyDepth'] != ''"><xsl:value-of select="atom[@name='PhyDepth']"/></xsl:when></xsl:choose>,
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300227934",
                            "type": "Type",
                            "_label": "weft (textile components)"
                        }
                    ]<xsl:call-template name="dim_unit"/>
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weight']) or (table[@name='Color'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weight'])"><xsl:for-each select="table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Weight']"><xsl:if test="atom[@name='PhyWeight'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/weight-<xsl:value-of select="position()"/>",
                    "type": "Dimension",
                    "_label": "Circumference of the Object",
                    "value": <xsl:value-of select="atom[@name='PhyWeight']"/>,
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300056240",
                            "type": "Type",
                            "_label": "weight (heaviness attribute)"
                        }
                    ]<xsl:call-template name="dim_unit"/>
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Color'])">,</xsl:if></xsl:if><xsl:if test="table[@name='Color']"><xsl:choose><xsl:when test="not(contains(table[@name='Color']/tuple/atom[@name='PhyColor'], '|'))">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/color-1",
                    "type": "Dimension",
                    "_label": "Color Visibly Identified by IMA staff on the Object",
                    "classified_as": [ 
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>thesauri/color/<xsl:value-of select="lower-case(translate(replace(table[@name='Color']/tuple/atom[@name='PhyColor'],'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                            "type": "Type",
                            "_label": "<xsl:value-of select="lower-case(table[@name='Color']/tuple/atom[@name='PhyColor'])"/>"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/colorness",
                            "type": "Type",
                            "_label": "Color"
                        }
                    ]
                }</xsl:when><xsl:otherwise><xsl:for-each select="tokenize(table[@name='Color']/tuple/atom[@name='PhyColor'],' \| ')">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/color-<xsl:value-of select="position()"/>",
                    "type": "Dimension",
                    "_label": "Color Visibly Identified by IMA staff on the Object",
                    "classified_as": [ 
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>thesauri/color/<xsl:value-of select="lower-case(translate(replace(.,'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                            "type": "Type",
                            "_label": "<xsl:value-of select="lower-case(.)"/>"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/colorness",
                            "type": "Type",
                            "_label": "Color"
                        }
                    ]
                }<xsl:if test="position() != last()">,</xsl:if></xsl:for-each></xsl:otherwise></xsl:choose></xsl:if>
            ],</xsl:if><!--
                
Owner--><xsl:choose><xsl:when test="atom[@name='TitObjectStatus'] = 'Accessioned' or contains(atom[@name='TitObjectStatus'], 'IMA-Owned') or atom[@name='TitObjectStatus'] = 'Partial Accession'">
            "current_owner": {
                "id": "http://vocab.getty.edu/ulan/500300517",
                "type": "Group",
                "_label": "Indianapolis Museum of Art at Newfields",
                "classified_as": [
                    {
                        "id": "http://vocab.getty.edu/aat/300312281",
                        "type": "Type",
                        "_label": "museums (institutions)"
                    }
                ],<!--
                    
Acquisition-->
                "acquired_title_through": [
                    {
                        "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/IMA-acquisition",
                        "type": "Acquisition",
                        "_label": "IMA at Newfields Acquisition of the Object",
                        "classified_as": [
                            {
                                "id": "http://vocab.getty.edu/aat/300157782",
                                "type": "Type",
                                "_label": "acquisition (collections management)"
                            }
                        ],
                        "took_place_at": [
                            {
                                "id": "http://vocab.getty.edu/tgn/7012924", 
                                "type": "Place", 
                                "_label": "Indianapolis, Indiana"
                            }
                        ]<xsl:if test="atom[@name='TitAccessionDate'] != ''">,
                        "timespan": {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/IMA-acquisition/timespan", 
                            "type": "TimeSpan", 
                            "_label": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>",<xsl:choose><xsl:when test="string-length(atom[@name='TitAccessionDate']) = 4">
                            "begin_of_the_begin": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>-01-01T00:00:00.000Z", 
                            "end_of_the_end": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>-12-31T00:00:00.000Z"</xsl:when><xsl:when test="string-length(atom[@name='TitAccessionDate']) = 8">
                            "begin_of_the_begin": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>01T00:00:00.000Z", 
                            "end_of_the_end": "<xsl:value-of select="atom[@name='TitAccessionDate']"/><xsl:if test="contains(atom[@name='TitAccessionDate'], '-02-')">28</xsl:if><xsl:if test="contains(atom[@name='TitAccessionDate'], '-01-') or contains(atom[@name='TitAccessionDate'], '-03-') or contains(atom[@name='TitAccessionDate'], '-05-') or contains(atom[@name='TitAccessionDate'], '-07-') or contains(atom[@name='TitAccessionDate'], '-08-') or contains(atom[@name='TitAccessionDate'], '-10-') or contains(atom[@name='TitAccessionDate'], '-12-')">31</xsl:if><xsl:if test="contains(atom[@name='TitAccessionDate'], '-04-') or contains(atom[@name='TitAccessionDate'], '-06-') or contains(atom[@name='TitAccessionDate'], '-09-') or contains(atom[@name='TitAccessionDate'], '-11-')">30</xsl:if>T00:00:00"</xsl:when><xsl:when test="string-length(atom[@name='TitAccessionDate']) = 10">
                            "begin_of_the_begin": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>T00:00:00.000Z", 
                            "end_of_the_end": "<xsl:value-of select="atom[@name='TitAccessionDate']"/>T00:00:00.000Z"</xsl:when></xsl:choose>
                        }</xsl:if>
                    }
                ]<!--
                    
Curatorial Department-->
            }</xsl:when><xsl:otherwise>"current_keeper": {
                "id": "http://vocab.getty.edu/ulan/500300517",
                "type": "Group",
                "_label": "Indianapolis Museum of Art at Newfields",
                "classified_as": [
                    {
                        "id": "http://vocab.getty.edu/aat/300312281",
                        "type": "Type",
                        "_label": "museums (institutions)"
                    }
                ]
            }</xsl:otherwise></xsl:choose><xsl:if test="atom[@name='PhyCollectionArea'] != ''">,
            "member_of": [
                {
                    "id": "<xsl:copy-of select="$baseURI"/>collection/<xsl:value-of select="lower-case(translate(replace(substring-before(atom[@name='PhyCollectionArea'], '-'),'[^a-zA-Z0-9 ]',''), ' ', '-'))"/>",
                    "type": "Set",
                    "_label": "Collection of IMA at Newfields' <xsl:value-of select="substring-after(atom[@name='PhyCollectionArea'], '-')"/> Department",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300025976",
                            "type": "Type",
                            "_label": "collections (object groupings)"
                        }
                    ]
                }<!--
                    
Current Location-->
            ]</xsl:if><xsl:if test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] != 'see related parts'"><xsl:choose><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel1'] = 'On Loan'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/on-loan",
                "type": "Place",
                "_label": "On Loan"
                }</xsl:when><xsl:when test="contains(tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'], 'Galler') or contains(tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'], 'Suite')">,
            "current_location": {
            "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/<xsl:value-of select="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel3']"/>",
                "type": "Place",
                "_label": "<xsl:value-of select="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2']"/>",
                "clasified_as": [
                    {
                        "id": "http://vocab.getty.edu/aat/300240057",
                        "type": "Type",
                        "_label": "galleries (display spaces)"
                    }
                ]
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Efroymson Family Entrance'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/F02",
                "type": "Place",
                "_label": "Efroymson Family Entrance Pavilion"
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Nature Park'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/ANP",
                "type": "Place",
                "_label": "Virginia B. Fairbanks Art &amp; Nature Park"
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Grounds'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/G",
                "type": "Place",
                "_label": "Newfields Grounds"
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Asian Visible Storage'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/K241",
                "type": "Place",
                "_label": "Leah and Charles Reddish Gallery - Asian Visible Storage",
                "clasified_as": [
                    {
                        "id": "http://vocab.getty.edu/aat/300240057",
                        "type": "Type",
                        "_label": "galleries (display spaces)"
                    }
                ]
            }</xsl:when><xsl:when test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'Westerley'">,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/westerley",
                "type": "Place",
                "_label": "Westerley"
            }</xsl:when><xsl:otherwise>,
            "current_location": {
                "id": "<xsl:copy-of select="$baseURI"/>thesauri/location/storage",
                "type": "Place",
                "_label": "IMA Storage"
            }</xsl:otherwise></xsl:choose></xsl:if><xsl:if test="tuple[@name='LocCurrentLocationRef']/atom[@name='LocLevel2'] = 'see related parts'"></xsl:if><xsl:if test="atom[@name='SumCreditLine'] != '' or atom[@name='CreProvenance'] != '' or atom[@name='TitTitleNotes'] != '' or atom[@name='PhyConvertedDims'] != '' or atom[@name='PhyMediumAndSupport'] != '' or atom[@name='PhyDescription'] != '' or atom[@name='CrePrimaryInscriptions'] != '' or atom[@name='CreCreationNotes'] != '' or table[@name='Rights']">,<!--
            
Linquistic Objects-->
            "referred_to_by": [<xsl:if test="atom[@name='SumCreditLine'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/credit-line",
                    "type": "LinguisticObject",
                    "_label": "IMA at Newfields Credit Line for the Object",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='SumCreditLine'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300026687",
                            "type": "Type",
                            "_label": "acknowledgments"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='CreProvenance'] != '' or atom[@name='TitTitleNotes'] != '' or atom[@name='PhyConvertedDimes'] != '' or atom[@name='PhyMediumAndSupport'] != '' or atom[@name='PhyDescription'] != '' or atom[@name='CrePrimaryInscriptions'] != '' or atom[@name='CreCreationNotes'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='CreProvenance'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/provenance-statement",
                    "type": "LinguisticObject",
                    "_label": "IMA Provenance Statement about the Object",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='CreProvenance'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055863",
                            "type": "Type",
                            "_label": "provenance (history of ownership)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='TitTitleNotes'] != '' or atom[@name='PhyConvertedDims'] != '' or atom[@name='PhyMediumAndSupport'] != '' or atom[@name='PhyDescription'] != '' or atom[@name='CrePrimaryInscriptions'] != '' or atom[@name='CreCreationNotes'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='TitTitleNotes'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/title-statement",
                    "type": "LinguisticObject",
                    "_label": "Notes about the Title(s) Associated with the Object",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='TitTitleNotes'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300417212",
                            "type": "Type",
                            "_label": "title statements"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='PhyConvertedDims'] != '' or atom[@name='PhyMediumAndSupport'] != '' or atom[@name='PhyDescription'] != '' or atom[@name='CrePrimaryInscriptions'] != '' or atom[@name='CreCreationNotes'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyConvertedDims'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/dimension-statement",
                    "type": "LinguisticObject",
                    "_label": "Notes about the Dimensions of the Object",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='PhyConvertedDims'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300266036",
                            "type": "Type",
                            "_label": "dimensions"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='PhyMediumAndSupport'] != '' or atom[@name='PhyDescription'] != '' or atom[@name='CrePrimaryInscriptions'] != '' or atom[@name='CreCreationNotes'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyMediumAndSupport'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/materials-statement",
                    "type": "LinguisticObject",
                    "_label": "Notes about the Materials of Which the Object is Composed",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='PhyMediumAndSupport'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300010358",
                            "type": "Type",
                            "_label": "materials (substances)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='PhyDescription'] != '' or atom[@name='CrePrimaryInscriptions'] != '' or atom[@name='CreCreationNotes'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyDescription'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/description",
                    "type": "LinguisticObject",
                    "_label": "Description of the Object",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='PhyDescription'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300411780",
                            "type": "Type",
                            "_label": "descriptions (documents)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='CrePrimaryInscriptions'] != '' or atom[@name='CreCreationNotes'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='CrePrimaryInscriptions'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/mark-description",
                    "type": "LinguisticObject",
                    "_label": "Mark Description of the Object",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='CrePrimaryInscriptions'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300028744",
                            "type": "Type",
                            "_label": "marks (symbols)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="atom[@name='CreCreationNotes'] != '' or table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="atom[@name='CreCreationNotes'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/creation-notes",
                    "type": "LinguisticObject",
                    "_label": "IMA at Newfields Creation Notes about the Object",
                    "content": "<xsl:value-of select="replace(replace(atom[@name='CreCreationNotes'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300027200",
                            "type": "Type",
                            "_label": "notes (documents)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="table[@name='Rights']">,</xsl:if></xsl:if><xsl:if test="table[@name='Rights']">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/rights-statement",
                    "type": "LinguisticObject",
                    "_label": "Rights Statement",
                    "content": "<xsl:value-of select="replace(replace(table[@name='Rights']/tuple[1]/atom[@name='RigAcknowledgement'], '\n', '\\n'), '&quot;', '\\&quot;')"/>",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055547",
                            "type": "Type",
                            "_label": "legal concepts"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }<xsl:if test="table[@name='Rights']/tuple[1]/atom[@name='RigAcknowledgement'] = 'Public Domain'">,
                {
                    "id": "https://creativecommons.org/publicdomain/mark/1.0/",
                    "type": "LinguisticObject",
                    "_label": "Public Domain",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055547",
                            "type": "Type",
                            "_label": "legal concepts"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }</xsl:if><xsl:if test="table[@name='Rights']/tuple[1]/atom[@name='RigAcknowledgement'] = 'No Known Rights Holder'">,
                {
                    "id": "http://rightsstatements.org/vocab/NKC/1.0/",
                    "type": "LinguisticObject",
                    "_label": "No Known Copyright",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055547",
                            "type": "Type",
                            "_label": "legal concepts"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }</xsl:if><xsl:if test="contains(table[@name='Rights']/tuple[1]/atom[@name='RigAcknowledgement'], '©')">,
                {
                    "id": "http://rightsstatements.org/vocab/InC/1.0/",
                    "type": "LinguisticObject",
                    "_label": "In Copyright",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300055547",
                            "type": "Type",
                            "_label": "legal concepts"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300418049",
                            "type": "Type",
                            "_label": "brief texts"
                        }
                    ]
                }</xsl:if></xsl:if>
            ]</xsl:if><xsl:if test="(atom[@name='AssIsParent'] = 'Yes' and table[@name='Children']) or (table[@name='Dimensions']/tuple[atom[@name=
                'PhyType'] = 'Framed Dimensions']) or (table[@name='Dimensions']/tuple[starts-with(atom[@name=
                'PhyType'], 'Sheet Dimensions')]) or (table[@name='Dimensions']/tuple[contains(atom[@name='PhyType'] , 'Image Dimensions')]) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Mount Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])">,<!--

Parts-->
            "part": [<xsl:if test="atom[@name='AssIsParent'] = 'Yes' and table[@name='Children']"><xsl:for-each select="table[@name='Children']/tuple">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>",
                    "type": "HumanMadeObject",
                    "_label": "<xsl:value-of select="replace(atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/>"
                }<xsl:if test="table[@name='Grandchildren']"><xsl:for-each select="table[@name='Grandchildren']/tuple">,
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:value-of select="atom[@name='irn']"/>",
                    "type": "HumanMadeObject",
                    "_label": "<xsl:value-of select="replace(atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/>"
                }</xsl:for-each></xsl:if><xsl:if test="position() != last()">,</xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Framed Dimensions']) or (table[@name='Dimensions']/tuple[starts-with(atom[@name=
                    'PhyType'], 'Sheet Dimensions')]) or (table[@name='Dimensions']/tuple[contains(atom[@name='PhyType'], 'Image Dimensions')]) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Mount Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Framed Dimensions'])"><xsl:for-each select="table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Framed Dimensions']"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/frame-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Frame for the Object",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300189814",
                            "type": "Type",
                            "_label": "frames (protective furnishings)"
                        }
                    ],
                    "dimension": [<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">frame</xsl:with-param></xsl:call-template>
                    ]
                }</xsl:if><xsl:if test="position() != last()">,</xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[starts-with(atom[@name='PhyType'], 'Sheet Dimensions')]) or (table[@name='Dimensions']/tuple[contains(atom[@name=
                    'PhyType'], 'Image Dimensions')]) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Mount Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[contains(atom[@name='PhyType'], 'Sheet Dimensions')])"><xsl:for-each select="table[@name='Dimensions']/tuple[starts-with(atom[@name=
                        'PhyType'], 'Sheet Dimensions')]"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/sheet-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Sheet (support) for the Object",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300189648",
                            "type": "Type",
                            "_label": "sheets (paper artifacts)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300014844",
                            "type": "Type",
                            "_label": "supports (artists' materials)"
                        }
                    ],
                    "dimension": [<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">sheet</xsl:with-param></xsl:call-template>
                    ]
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[contains(atom[@name='PhyType'], 'Image Dimensions')]) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Mount Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[contains(atom[@name='PhyType'], 'Image Dimensions')])"><xsl:for-each select="table[@name='Dimensions']/tuple[contains(atom[@name='PhyType'], 'Image Dimensions')]"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/image-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Image part of the Object",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300264387",
                            "type": "Type",
                            "_label": "images (object genre)"
                        }
                    ],
                    "dimension": [<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">image</xsl:with-param></xsl:call-template>
                    ]
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Mount Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])"><xsl:for-each select="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Base Dimensions'])"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/base-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Base part of the Object",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300001656",
                            "type": "Type",
                            "_label": "bases (object components)"
                        }
                    ],
                    "dimension": [<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">base</xsl:with-param></xsl:call-template>
                    ]
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Mount Dimensions']) or (table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Mount Dimensions'])"><xsl:for-each select="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Mount Dimensions'])"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/mount-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Mount part of the Object",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300131087",
                            "type": "Type",
                            "_label": "mounts (framing and mounting equipment)"
                        }
                    ],
                    "dimension": [<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">mount</xsl:with-param></xsl:call-template>
                    ]
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])">,</xsl:if></xsl:if><xsl:if test="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])"><xsl:for-each select="(table[@name='Dimensions']/tuple[atom[@name='PhyType'] = 'Plate Dimensions'])"><xsl:if test="atom[@name='PhyHeight'] != '' or atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">
                {
                    "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/plate-<xsl:value-of select="position()"/>",
                    "type": "HumanMadeObject",
                    "_label": "Plate part of the Object",
                    "classified_as": [
                        {
                            "id": "http://vocab.getty.edu/aat/300404443",
                            "type": "Type",
                            "_label": "plates (reproduction object genre)"
                        }
                    ],
                    "dimension": [<xsl:call-template name="dimensions"><xsl:with-param name="dim_type">plate</xsl:with-param></xsl:call-template>
                    ]
                }<xsl:if test="position() != last()">,</xsl:if></xsl:if></xsl:for-each></xsl:if>
            ]</xsl:if><xsl:if test="(atom[@name='AdmPublishWebNoPassword'] = 'Yes') and (table[@name='Homepage']/tuple[atom[@name='EleIdentifier'] != ''])">,<!--
                
Homepage-->
            "subject_of": [
                {
                    "id": "http://collection.imamuseum.org/artwork/<xsl:for-each select="table[@name='Homepage']/tuple[atom[@name='EleIdentifier'] != '']"><xsl:value-of select="atom[@name='EleIdentifier']"/></xsl:for-each>/",
                    "type": "LinguisticObject",
                    "_label": "Homepage for the Object",
                    "classified_as": [
                        {
                            "id": "http://vocab/getty.edu/aat/300264578",
                            "type": "Type",
                            "_label": "Web pages (documents)"
                        },
                        {
                            "id": "http://vocab.getty.edu/aat/300266277",
                            "type": "Type",
                            "_label": "home pages"
                        }
                    ],
                    "format": "text/html"
                }
            ]</xsl:if>
        }
    }<xsl:if test="position() != last()">,
    </xsl:if>
        </xsl:for-each>
]}</xsl:template>

<!--Dimensions Template-->
<xsl:template name="dimensions"><xsl:param name="dim_type"/><xsl:variable name="irn"><xsl:value-of select="ancestor::tuple/atom[@name='irn']"/></xsl:variable><xsl:variable name="title"><xsl:value-of select="replace(ancestor::tuple/atom[@name='TitMainTitle'], '&quot;', '\\&quot;')"/></xsl:variable><xsl:if test="atom[@name='PhyHeight'] != ''">
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/<xsl:value-of select="$dim_type"/>-<xsl:value-of select="position()"/>/height",
                            "type": "Dimension",
                            "_label": "<xsl:value-of select="atom[@name='PhyType']"/> of the Object",
                            "value": <xsl:value-of select="atom[@name='PhyHeight']"/>,
                            "classified_as": [
                                {
                                    "id": "http://vocab.getty.edu/aat/300055644",
                                    "type": "Type",
                                    "_label": "height"
                                }
                            ]<xsl:call-template name="dim_unit"/>
                        }<xsl:if test="atom[@name='PhyWidth'] != '' or atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyWidth'] != ''">
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/<xsl:value-of select="$dim_type"/>-<xsl:value-of select="position()"/>/width",
                            "type": "Dimension",
                            "_label": "<xsl:value-of select="atom[@name='PhyType']"/> of the Object",
                            "value": <xsl:value-of select="atom[@name='PhyWidth']"/>,
                            "classified_as": [
                                {
                                    "id": "http://vocab.getty.edu/aat/300055647",
                                    "type": "Type",
                                    "_label": "width"
                                }
                            ]<xsl:call-template name="dim_unit"/>
                        }<xsl:if test="atom[@name='PhyDepth'] != '' or atom[@name='PhyDiameter'] != ''">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyDepth'] != ''">
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/<xsl:value-of select="$dim_type"/>-<xsl:value-of select="position()"/>/depth",
                            "type": "Dimension",
                            "_label": "<xsl:value-of select="atom[@name='PhyType']"/> of the Object",
                            "value": <xsl:value-of select="atom[@name='PhyDepth']"/>,
                            "classified_as": [
                                {
                                    "id": "http://vocab.getty.edu/aat/300072633",
                                    "type": "Type",
                                    "_label": "depth (size/dimension)"
                                }
                            ]<xsl:call-template name="dim_unit"/>
                        }<xsl:if test="atom[@name='PhyDiameter'] != ''">,</xsl:if></xsl:if><xsl:if test="atom[@name='PhyDiameter'] != ''">
                        {
                            "id": "<xsl:copy-of select="$baseURI"/>object/<xsl:copy-of select="$irn"/>/<xsl:value-of select="$dim_type"/>-<xsl:value-of select="position()"/>/diameter",
                            "type": "Dimension",
                            "_label": "<xsl:value-of select="atom[@name='PhyType']"/> of the Object",
                            "value": <xsl:value-of select="atom[@name='PhyDiameter']"/>,
                            "classified_as": [
                                {
                                    "id": "http://vocab.getty.edu/aat/300055624",
                                    "type": "Type",
                                    "_label": "diameter"
                                }
                            ]<xsl:call-template name="dim_unit"/>
                        }</xsl:if></xsl:template>

<!--Dimensions Unit Template-->
<xsl:template name="dim_unit">
    <xsl:if test="atom[@name='PhyUnitLength'] = 'in.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379100",
                                "type": "Type",
                                "_label": "inches"
                            }</xsl:if><xsl:if test="atom[@name='PhyUnitLength'] = 'cm.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379098",
                                "type": "Type",
                                "_label": "centimeters"
                            }</xsl:if><xsl:if test="atom[@name='PhyUnitWeight'] = 'lbs.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379254",
                                "type": "Type",
                                "_label": "pounds (units for weight)"
                            }</xsl:if><xsl:if test="atom[@name='PhyUnitWeight'] = 'oz.'">,
                            "unit": {
                                "id": "http://vocab.getty.edu/aat/300379229",
                                "type": "Type",
                                "_label": "ounces (units for weight)"
                            }</xsl:if></xsl:template>
</xsl:stylesheet>