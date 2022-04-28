import cromulent

from cromulent.model import factory, Actor, Production, BeginningOfExistence, EndOfExistence, TimeSpan, Place
from cromulent.model import InformationObject, Phase, VisualItem 
from cromulent.vocab import Painting, Drawing,Miniature,add_art_setter, PrimaryName, Name, CollectionSet, instances, Sculpture 
from cromulent.vocab import aat_culture_mapping, AccessionNumber, Height, Width, SupportPart, Gallery, MuseumPlace 
from cromulent.vocab import BottomPart, Description, RightsStatement, MuseumOrg, Purchase
from cromulent.vocab import Furniture, Mosaic, Photograph, Coin, Vessel, Graphic, Enamel, Embroidery, PhotographPrint
from cromulent.vocab import PhotographAlbum, PhotographBook, PhotographColor, PhotographBW, Negative, Map, Clothing, Furniture
from cromulent.vocab import Sample, Architecture, Armor, Book, DecArts, Implement, Jewelry, Manuscript, SiteInstallation, Text, Print
from cromulent.vocab import TimeBasedMedia, Page, Folio, Folder, Box, Envelope, Binder, Case, FlatfileCabinet
from cromulent.vocab import HumanMadeObject,Tapestry,LocalNumber
from cromulent.vocab import Type,Set
from cromulent.vocab import TimeSpan, Actor, Group, Acquisition, Place
from cromulent.vocab import Production, TimeSpan, Actor
from cromulent.vocab import LinguisticObject,DigitalObject, DigitalService



"""
Dictionary of Object Types defined in Linked Art
"""


objTypes = {
"Painting": Painting(),
"Sculpture": Sculpture(),
"Drawing": Drawing(),
"Miniature": Miniature(),
"Tapestry": Tapestry(),
"Furniture": Furniture(),
"Furnishings": DecArts(),
"Mosaic": Mosaic(),
"Photograph": Photograph(),
"Coin": Coin(),
"Vessel": Vessel(),
"Graphic": Graphic(),
"Enamel": Enamel(),
"Embroidery": Embroidery(),
"PhotographPrint": PhotographPrint(),
"PhotographAlbum": PhotographAlbum(),
"PhotographBook": PhotographBook(),
"PhotographColor": PhotographColor(),
"PhotographBW": PhotographBW(),
"Negative": Negative(),
"Map": Map(),
"Clothing": Clothing(),
"Sample": Sample(),
"Architecture": Architecture(),
"Armor": Armor(),
"Book": Book(),
"DecArts": DecArts(),
"Implement": Implement(),
"Jewelry": Jewelry(),
"Manuscript": Manuscript(),
"SiteInstallation": SiteInstallation(),
"Text": Text(),
"Print": Print(),
"TimeBasedMedia": TimeBasedMedia(),
"Page": Page(),
"Folio": Folio(),
"Folder": Folder(),
"Box": Box(),
"Envelope": Envelope(),
"Binder": Binder(),
"Case": Case(),
"FlatfileCabinet": FlatfileCabinet()
}

def createObjProp(obj,docProp):
    objProp = {"creator":[]}

    for prop in obj["atom"]: 
        propName = prop["@name"]
        propValue = ""
        if "#text" in prop:
            propValue = prop["#text"]
        if propName in list(docProp.keys()):
            propId = docProp[propName]
            objProp[propId] = propValue
 

    # alternative titles

    for table in obj["table"]:
        if table["@name"] == "AltTitles": 
            alt_title = table["tuple"]["atom"]["#text"]
            objProp["alt_title"] = alt_title
        

        if table["@name"] == "Creator1": 
            crerole = creid = crename = ""
            if "atom" in table["tuple"]:
                for atom in table["tuple"]["atom"]:
                    if atom["@name"] == "CreRole":
                        crerole = atom["#text"]
                    if atom["@name"] == "irn":
                        creid = atom["#text"]
                    if atom["@name"] == "SummaryData":
                        crename = atom["#text"]
            creator = {"id":creid,"name":crename,"role":crerole}
            objProp["creator"].append(creator)
    
    return objProp

def objPrimaryname(objProp,object_uri):
    primaryname = None
    title = objProp["title"]
    id = str(objProp["id"])
    primaryname = PrimaryName( object_uri + "/primary-name",
                                value=title)
    return primaryname

def objAlternatename(objProp,object_uri):
    alternateName = None
    if "alt_title" in objProp:
        alt_title = objProp["alt_title"]
        alternatename = AlternateName(object_uri +  "/alternate-name",value=alt_title)
    return alternateName

def objHomepage(objProp,object_uri):

    homepage = None
    homepageId = objProp["homepage"]
    if homepageId != "":
        homepage = LinguisticObject(homepageId, label="Homepage for the Object")
        homepage.classified_as = Type("http://vocab/getty.edu/aat/300264578", label="Web pages (documents)")
        homepage.classified_as = Type("http://vocab.getty.edu/aat/300266277", label="home pages")
        homepage.format = "text/html"
    return homepage


def objProvenance(objProp,object_uri):

    prov = None
    if "created_provenance" in objProp:
        provenance = objProp["created_provenance"]
        if provenance !="":
            prov = LinguisticObject(object_uri + "/provenance-statement", 
                            value=provenance,
                            label="Provenance Statement about the Object"
                           )
            prov.classified_as = Type("http://vocab.getty.edu/aat/300055863", label="provenance (history of ownership)")
            prov.classified_as = Type("http://vocab.getty.edu/aat/300418049", label="brief texts")
        return prov


def objAccession(objProp, object_uri):
    accession = None
    accession_number = objProp["accession_number"]
    if accession_number != "":
        accession = AccessionNumber(accession_number,value=accession_number)
    return accession

def objLocalnumber(objProp,object_uri):
    localnumber = None
    id = str(objProp["id"])
    if id != "":
        localnumber = LocalNumber(id,value=id)
    return localnumber

def objCollection(objProp,object_uri):
    coll = None
    if "collection" in objProp:
        collection = objProp["collection"]
        coll = Set(object_uri +"/collection/" + collection, 
                   label= collection)
        coll.classified_as = Type("http://vocab.getty.edu/aat/300025976", 
                              label="collections (object groupings)")
    return coll



def objCredit(objProp,object_uri):
    credit = None
    propCredit = "credit_line"
    
    if propCredit in objProp:
        credit_line = objProp[propCredit]
        if credit_line != "":
            credit = LinguisticObject(object_uri + "/credit-line", 
                            value=credit_line,
                            label="Credit Line for the Object"
                           )
            credit.classified_as = Type("http://vocab.getty.edu/aat/300026687", label="acknowledgements")
            credit.classified_as = Type("http://vocab.getty.edu/aat/300418049", label="brief texts")
    return credit



def objProduction(objProp,object_uri):

    prod = None

    date_created = "date_created"
    created_earliest = "date_created_earliest"
    created_latest = "date_created_latest"

    if date_created in objProp:
        prod = Production(object_uri + "/production", label="Production of the Object")    
    
        labelTimespan = "date unknown"
        if objProp[date_created] != "":
            labelTimespan = objProp[date_created]
   
        timespan = TimeSpan(object_uri + "/production/timespan", label=labelTimespan)
        
        if created_earliest in objProp:
            timespan.begin_of_the_begin = objProp[created_earliest]
        if created_latest in objProp:
            timespan.end_of_the_end = objProp[created_latest]
    
        prod.timespan = timespan

        propCreator = "creator" 
        
        if propCreator in objProp:
            
            
            creatorList = objProp[propCreator]

            for creator in creatorList:
                id = label = ""
                for prop in creator:
                    if "id" == prop:
                        id = creator["id"]
                    if "name" == prop:
                        label = creator["name"]
                if label != "":   
                    actor = Actor(id,label)
                    prod.carried_out_by = actor
            
    return prod

def objCurrentowner(objProp,object_uri):
    current_owner = None
    if  "current_owner" in objProp and objProp["current_owner"]["name"] != "":
        cowner = objProp["current_owner"]["name"]
        current_owner = Group( "http://vocab.getty.edu/ulan/500300517",label=cowner)
        current_owner.classified_as = Type( "http://vocab.getty.edu/aat/300312281",label="museums (institutions)")
        
        
        acquisition = objAcquisition(objProp,object_uri)
        if acquisition is not None:
            current_owner.acquired_title_through = acquisition 
    return current_owner 

def objAcquisition(objProp,object_uri):
    acquisition = None
    if "accession_date" in objProp and objProp["accession_date"] != "":
        acquisition = Acquisition(object_uri + "/IMA-acquisition", label = "Acquisition of the Object")
        acquisition.classified_as = Type("http://vocab.getty.edu/aat/300157782",
                                         label="acquisition (collections management)")
        
        if "name_location" in objProp["current_owner"]:
            acquisition.took_place_at = Place("http://vocab.getty.edu/tgn/7012924", 
                                              label=objProp["current_owner"]["name_location"]) 
        acquisition.timespan = objAcquisitionTimespan(object_uri,objProp["accession_date"])
    return acquisition

def objAcquisitionTimespan(object_uri,accession_date):
    timespan = None
    end = begin = ""
    accession_date = str(accession_date)
    if len(accession_date) == 4:
        begin = accession_date + "-01-01T00:00:00.000Z"
        end = accession_date + "-12-31T00:00:00.000Z"
        
    elif len(accession_date) == 8:
        begin = accession_date + "01T00:00:00.000Z"
        end = accession_date 
        if '-02-' in accession_date:
            end = end + "28"
        if ('-01-','-03-','-05-','-07-','-08-','-09-','-10-','-12-') in accession_date:
            end = end + "31"
        if ('-04-','-06-','-09-','-11-'):
            end = end + "30"      
        end = end + "T00:00:00"
         
    elif len(accession_date) == 10:
        begin = accession_date + "T00:00:00.000Z"
        end = accession_date + "T00:00:00.000Z"    
    else:
        begin = end = ""
        
    timespan = TimeSpan(object_uri + "/IMA-acquisition/timespan", label=accession_date)
        
    if begin != "":
        timespan.begin_of_the_begin = begin
    if end != "":
        timespan.end_of_the_end = end
    return timespan
    

def objCustody(objProp,object_uri):
    
    custody = None

    if "current_status" in objProp and objProp["current_status"] != "" :
        current_status = objProp["current_status"]
        current_owner = checkCurrentOwner(current_status)
    
        if current_owner == False:
            name = objProp["current_owner"]["name"]
            type = objProp["current_owner"]["type"]
            label = objProp["current_owner"]["type_label"]
            
            custody = Group(label=name)
            custody.classified_as = Type(type, 
                                     label=label)
    return custody


def objDigitalObject(objProp,object_uri):
    vi = None
    url = objProp["image_url"]
    vi = VisualItem(url, label="Digital image of artwork")

    do = DigitalObject(url,label="Image of artwork")
    do.classified_as = Type("http://vocab.getty.edu/aat/300215302","Digital Image")
    do.access_point = DigitalObject(url)

    if "iiif" in url.lower():
        ds = DigitalService()
        ds.access_point = DigitalObject(url)
        ds.conforms_to = InformationObject("http://iiif.io/api/image")
        do.digitally_available_via = ds
        
    vi.digitally_shown_by = do

    return vi
    

def createObjDesc(objProp,objTypes,object_uri):
    objLA = None
    objLA = HumanMadeObject() # linked art object

    for otype in objTypes:
        if otype in objProp["classification"]:
            objLA = objTypes[otype]        
            break
            
    objLA.id = object_uri
    objLA._label =  objProp["title"]
    
    # DIGITAL OBJECT
    if "image_url" in objProp and objProp["image_url"] != "":
        dig = objDigitalObject(objProp,object_uri)
        if dig is not None:
            objLA.representation = []
            objLA.representation.append(dig)


    # IDENTIFIED_BY 
    accession = objAccession(objProp,object_uri)
    localnumber = objLocalnumber(objProp,object_uri)
    primaryname = objPrimaryname(objProp,object_uri)
    
    listIds = (accession,localnumber,primaryname)
    identified_by = False
    for id in listIds:
        if id is not None:
            identified_by = True
            break
    if identified_by == True:
        objLA.identified_by = []
        
        for id in listIds:
            if id is not None:
                objLA.identified_by.append(id)
    
    # REFERRED_TO_BY
    objLA.referred_to_by = None
    prov = objProvenance(objProp,object_uri)
    credit = objCredit(objProp,object_uri)
    referred_to_by = False
    if prov is not None or credit is not None:
        referred_to_by = True
    if referred_to_by == True:
        objLA.referred_to_by = []
    if prov is not None:
        objLA.referred_to_by.append(prov) # provenance 
    if credit is not None:
        objLA.referred_to_by.append(credit) # credit line
    
    # SUBJECT_OF 
    objLA.subject_of = None 
    homepage = None  
    homepage = objHomepage(objProp,object_uri)
    if homepage is not None:
        objLA.subject_of = homepage # home page
        
    # PRODUCED_BY
    objLA.produced_by = None 
    if "creator" in objProp:
        prod = None
        prod = objProduction(objProp,object_uri)
        if prod is not None:
            objLA.produced_by = prod # production

    # MEMBER_OF
    objLA.member_of = None 
    if "collection" in objProp:
        coll = None
        coll = objCollection(objProp,object_uri)
        if coll is not None:
            objLA.member_of = coll # collection

    # CURRENT_KEEPER
    objLA.current_owner = None 
    custody = None
    custody = objCustody(objProp,object_uri)
    if custody is not None:
        objLA.current_owner = custody
    
    # CURRENT_OWNER
    if "current_owner" in objProp and objProp["current_owner"] != "":
        current_owner = objCurrentowner(objProp,object_uri)
        if current_owner is not None:
            objLA.current_owner = current_owner
          
    return objLA

def checkCurrentOwner(current_status):
    currentowner = False
    if current_status != "":
        checkObjStatus = ('Accessioned','Partial Accession')
        for status in checkObjStatus:
            if status == current_status:
                currentowner = True
            if 'IMA-Owned' in current_status:
                currentowner = True
    return currentowner
