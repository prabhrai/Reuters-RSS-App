//
//  XMLParser.swift
//  RSSFeed
//
//  Created by PS on 3/27/17.
//  Copyright © 2017 PrabhdeepSingh. All rights reserved.
//

import UIKit


// check this
@objc protocol XMLParserDelegate {
    func parsingWasFinished()
}

// Inheritance and Protocol adherance
class XMLParser: NSObject, Foundation.XMLParserDelegate {
    // Holds the parsed XML we want to keep as a collection of Dictionaries
    var arrParsedData = [Dictionary<String,String>]()
    
    // This is what we are parsing now (why not just point to an element of arrParsedData? Because
    // we add everything here and only put those we care about into arrParsedData
    
    var currentDataDictionary = Dictionary<String,String>()
    // Name of the element we're examining (really, should this be local to a method?)

    var currentElement = ""
    // Value of the element above
    
    var foundCharacters = ""
    
    func returnDataAsString()->String {
        var rv: String = ""
        var count = 0
        for x in arrParsedData {
            rv += "\n\tNext Element: \(count):"
            count += 1
            for (key,value) in x {
                rv += "\t\tkey: \"\(key)\" value: \"\(value)\"\n"
            }
        }
        return rv
    }
    
    func startParsingWithContentsOfURL(_ rssURL: URL) {
        // use Command-click to see that the convenience init returns an optional
        let parser = Foundation.XMLParser(contentsOf: rssURL)!
    
        print ("\(rssURL)")
        print("at \(#file), line \(#line) : started parsing")
        
        parser.delegate = self
        parser.parse()
    
    
    }
    // MARK: parser delegate
    
    // to link with the@objc above
    var delegate: XMLParserDelegate?
    
    private func parserDidEndDocument(_ parser: XMLParser) {
        delegate?.parsingWasFinished()


    }
    
    // MARK: various overloads of parser()
     // why are we not consistent with Dictionary<NSObject,AnyObject> here? because this is autofill
    internal func parser(_ parser: Foundation.XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,attributes attributeDict: [String : String]) {
        currentElement = elementName
        print("at \(#file), line \(#line) : current element is \(currentElement)")
    }
    
     func parser(_ parser: XMLParser, foundCharacters string: String?) {
        // this first part is stupid--if you are == "Title" you are always != <anything else>
        // I think this fixes it
        
        if let extractedString = string {
            if (currentElement == "title" && extractedString != "Appcoda") ||
                currentElement == "link" || currentElement == "pubDate" {
                foundCharacters += extractedString
            }
            if currentElement == "Title" {
                print("at \(#file), line \(#line) : current element is \(currentElement)")
                
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String,
                        namespaceURI: String?, qualifiedName qName: String?) {
        
        if !foundCharacters.isEmpty {
        
            if elementName == "link" {
                // see the guide--\n\t\t are added by default
                foundCharacters = (foundCharacters as NSString).substring(from: 3)
                //                            println("at \(__FILE__), line \(__LINE__), foundChar is \"\(foundCharacters)\"")
            }
            currentDataDictionary[currentElement] = foundCharacters
            foundCharacters = ""
            // end of each entry is the date
            if currentElement == "pubDate" {
                arrParsedData.append(currentDataDictionary)
            }
            
        }
    }
    
     func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        //print("at \(#file), line \(#line) : \(parseError.description)")

    }
    
     func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        //print("at \(#file), line \(#line) : \(validationError.description)"
    }
    
}

 
 
 
 
