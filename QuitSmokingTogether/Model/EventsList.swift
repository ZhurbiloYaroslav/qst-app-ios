//
//  EventsList.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 24.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class EventsList {
    
    static var arrayWithEvents: [Event] = [Event]()
    
    static func getFirstEventWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> Event {
        if getAllEventsWithType(type, andStatus: status).count > 0 {
            return getAllEventsWithType(type, andStatus: status)[0]
        } else {
            return Event()
        }
    }
    
    static func getAllEventsWithType(_ type: Event.EventType, andStatus status: Event.EventStatus) -> [Event] {
        var resultArrayWithEvents = [Event]()
        
        for event in getArrayWithEvents() {
            if event.type == type, event.status == status {
                resultArrayWithEvents.append(event)
            }
        }
        return resultArrayWithEvents
    }
    
    static func getArrayWithEvents() -> [Event] {
        return [
            Event(type: .Competiton, status: .Unread,
                  title: "Финал конкурса \"Бросим курить вместе\" 31 мая 2017 года!",
                  text: """
                Победители конкурса "Бросим курить вместе"!\n
                \n
                1-е место Александра Ковалёва (Краматорск). Приз - 2000 грн.\n
                2-е место Алиса (Краматорск). Приз - 1000 грн.\n
                3-е место Таня Кротикова (Рыбинск) - 800 грн.\n
                4-е место Аня Торбина (Рыбинск). Приз - 500 грн.\n
                5-е место Людмила Лучинина. Приз -200 грн.\n
                \n
                Участвуйте в наших акциях, избавляйтесь от зависимостей и открывайте новые страницы вашей жизни.\n
                \n
                Ваш Алексей Коваль.
                """,
                  arrayWithImagesURL: [
                    "https://quitsmokingtogether.ru/foto/fotoconkurs/fotokonkyrs6/Sf-0WLeRbBk.jpg",
                    "https://quitsmokingtogether.ru/foto/fotoconkurs/fotokonkyrs6/ycElwGzvAYs.jpg",
                    "https://quitsmokingtogether.ru/foto/fotoconkurs/fotokonkyrs6/7bXqhwFLdmE.jpg",
                    "https://quitsmokingtogether.ru/foto/fotoconkurs/fotokonkyrs6/ZTz1hQXKA7I.jpg",
                    "https://quitsmokingtogether.ru/foto/fotoconkurs/fotokonkyrs6/56ofhX0x7Ls.jpg",
                    ]
            ),
            Event(type: .News, status: .Unread, title: "\"Quit Smoking Together\" action was held in Kyiv",
                  text: "The activists dressed as branded cigarettes handed out CDs with Alexey Koval's book \"Quit Smoking Together\". The photos show how it all went :) ",
                  arrayWithImagesURL: [
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8571.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8562.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8560.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8546.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8543.JPG"
                ]
            ),
            Event(type: .News, status: .Unread, title: "\"Quit Smoking Together\" action was held in Kyiv",
                  text: "The activists dressed as branded cigarettes handed out CDs with Alexey Koval's book \"Quit Smoking Together\". The photos show how it all went :) ",
                  arrayWithImagesURL: [
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8571.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8562.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8560.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8546.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8543.JPG"
                ]
            ),
            Event(type: .News, status: .Unread, title: "\"Quit Smoking Together\" action was held in Kyiv",
                  text: "The activists dressed as branded cigarettes handed out CDs with Alexey Koval's book \"Quit Smoking Together\". The photos show how it all went :) ",
                  arrayWithImagesURL: [
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8571.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8562.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8560.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8546.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8543.JPG"
                ]
            ),
            Event(type: .News, status: .Unread, title: "\"Quit Smoking Together\" action was held in Kyiv",
                  text: "The activists dressed as branded cigarettes handed out CDs with Alexey Koval's book \"Quit Smoking Together\". The photos show how it all went :) ",
                  arrayWithImagesURL: [
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8571.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8562.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8560.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8546.JPG",
                    "http://quitsmokingtogether.org/foto/2017/09/kyiv27/IMG_8543.JPG"
                ]
            ),
        ]
    }
}
