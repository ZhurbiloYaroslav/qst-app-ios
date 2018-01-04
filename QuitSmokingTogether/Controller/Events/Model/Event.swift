//
//  Event.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 30.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//
//

import UIKit
import Foundation
import SwiftSoup

public class Event: NSObject {
    
    var id: Int
    var date: Date
    var type: EventType = .Undefined
    var status: EventStatus = .Unread
    var title: String
    var htmlContent: String
    var textContent: String
    let defaultImage: [UIImage] = [UIImage()]
    var arrayWithImageLinks: [String] {
        return parseImagesAndContentFromHTML()
    }
    
    init(id: Int, date: Date, title: String, htmlContent: String, textContent: String,
         type: EventType, status: EventStatus) {
        
        self.id = id
        self.date = date
        self.type = type
        self.status = status
        self.title = title
        self.htmlContent = htmlContent
        self.textContent = textContent
    }
    
    convenience override init() {
        self.init(id: 0, date: Date(), title: "Template", htmlContent: "", textContent: "",
                  type: .Undefined, status: .Unread)
    }
    
    func parseImagesAndContentFromHTML() -> [String] {
        do {
            var arrayWithImageLinks = [String]()
            
            let doc: Document = try! SwiftSoup.parse(htmlContent)
            textContent = try doc.body()?.text() ?? ""
            
            let els: Elements = try SwiftSoup.parse(htmlContent).select("img")
            for link: Element in els.array(){
                let linkSrc: String = try link.attr("src")
                arrayWithImageLinks.append(linkSrc)
            }
            
            arrayWithImageLinks.uniqInPlace()
            
            return arrayWithImageLinks
        } catch {
            return [String]()
        }
    }
    
    convenience init(withResult resultDictionary: [String: Any]) {
        
        let renderedIitle = resultDictionary["title"] as? [String: Any] ?? [String: Any]()
        let title = renderedIitle["rendered"] as? String  ?? ""
        let renderedContent = resultDictionary["content"] as? [String: Any] ?? [String: Any]()
        let htmlContent = renderedContent["rendered"] as? String  ?? ""
        
        let id = resultDictionary["id"] as? Int ?? 0
        
        let textContent = htmlContent
        let dateString = resultDictionary["date"] as? String ?? ""
        let date = Date()
        let status = EventStatus.Unread
        let type = EventType.News
        
        self.init(id: id, date: date, title: title,
                  htmlContent: htmlContent, textContent: textContent,
                  type: type, status: status)
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
        case Competition = "Competition"
        case Undefined = "Undefined"
    }
    
    enum EventStatus: String {
        case All = "All"
        case Read = "Read"
        case Unread = "Unread"
        case Starred = "Starred"
    }
}

