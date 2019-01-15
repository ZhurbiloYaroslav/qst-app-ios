//
//  QSTEvent.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//
//

import UIKit
import Foundation
import SwiftSoup

public class QSTEvent: NSObject {
    
    var id: Int
    var date: String
    var type: [EventType]
    var status: EventStatus = .Unread
    var title: String
    var htmlContent: String
    var textContent: String
    let defaultImage: [UIImage] = [UIImage()]
    var arrayWithImageLinks: [String]!
    
    init(id: Int, date: String, title: String, htmlContent: String,
         type: [EventType], status: EventStatus) {
        
        self.id = id
        self.date = date
        self.type = type
        self.status = status
        self.title = title
        self.htmlContent = htmlContent
        
        do {
            var arrayWithImageLinks = [String]()
            
            let doc: Document = try! SwiftSoup.parse(htmlContent)
            
            let els: Elements = try SwiftSoup.parse(htmlContent).select("img")
            for link: Element in els.array(){
                let linkSrc: String = try link.attr("src")
                let escapedLink = linkSrc.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if let escapedLink = escapedLink {
                    arrayWithImageLinks.append(escapedLink)
                }
            }
            arrayWithImageLinks.uniqInPlace()
            
            self.textContent = try doc.body()?.text() ?? ""
            self.arrayWithImageLinks = arrayWithImageLinks
            
        } catch {
            self.textContent = ""
            self.arrayWithImageLinks = [String]()
        }
    }
    
    func getStringWithDate() -> String {
        return date
    }
    
    convenience override init() {
        self.init(id: 0, date: "", title: "", htmlContent: "",
                  type: [.Undefined], status: .Unread)
    }
    
    convenience init(withResult resultDictionary: [String: Any]) {
        
        let id = resultDictionary["id"] as? Int ?? 0
        let date = resultDictionary["date"] as? String ?? ""
        let title = resultDictionary["title"] as? String  ?? ""
        let htmlContent = resultDictionary["content"] as? String  ?? ""
        let dictWithTypes = resultDictionary["categories"] as? [[String: Any]] ?? [[String: Any]]()
        
        var eventTypes = [EventType]()
        for dictionary in dictWithTypes {
            let newType = EventType.getTypeFrom(withResult: dictionary)
            eventTypes.append(newType)
        }
        
        let status = EventStatus.Unread
        
        self.init(id: id, date: date, title: title,
                  htmlContent: htmlContent,
                  type: eventTypes, status: status)
    }
    
    func getHTMLContent() -> String {
        
        guard let path = Bundle.main.path(forResource: "ArticleStyles", ofType: "css") else { return "" }
        let cssString = try! String(contentsOfFile: path).trimmingCharacters(in: .whitespacesAndNewlines)
        let doc: Document = try! SwiftSoup.parse(htmlContent)
        try! doc.head()?.append("<style>\(cssString)</style>")
        
        return try! doc.html()
    }
    
    
    func getFormattedDateFrom(stringWithDate: String, andTimezone timezone: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        if let formattedDate = dateFormatter.date(from: stringWithDate) {
            return formattedDate
        } else {
            return Date()
        }
    }
    
    enum EventType: String {
        case All = "All"
        case News = "News"
        case Competition = "Competitions"
        case Undefined = "Undefined"
        
        static func getTypeFrom(withResult resultDictionary: [String: Any]) -> EventType {
            
            guard let name = resultDictionary["name"] as? String
                else { return .Undefined }
            
            switch name {
            case "News", "Новости": return .News
            case "Competitions", "Конкурсы", "События": return .Competition
            default: return .Undefined
            }
        }
    }
    
    enum EventStatus: String {
        case All = "All"
        case Read = "Read"
        case Unread = "Unread"
        case Starred = "Starred"
    }
}

extension QSTEvent {
    
    public func getPostID() -> Int {
        return id
    }
    
    public func getDate() -> Date {
        let stringWithEventDate = date
        return Formatter.getDateFrom(stringWithEventDate)
    }
    
    public func getStringWithID() -> String {
        return String(describing: id)
    }
    
    public func getArrayWithImageURL() -> [URL] {
        var result = [URL]()
        for imageLinkString in arrayWithImageLinks {
            if let imageURL = URL(string: imageLinkString) {
                result.append(imageURL)
            }
        }
        return result
    }
}

