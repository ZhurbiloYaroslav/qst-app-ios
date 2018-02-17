//
//  Browser.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 21.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Foundation

class Browser {
    
    static func openURLWith(_ urlAddress: UrlAdress) {
        
        if let url = URL(string: urlAddress.rawValue), UIApplication.shared.canOpenURL(url){
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        } else {
            print("can't open")
        }
    }
    
    func getDataFrom(_ urlAddress: UrlAdress, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if let url = URL(string: urlAddress.rawValue), UIApplication.shared.canOpenURL(url){
            URLSession.shared.dataTask(with: url) { data, response, error in
                completion(data, response, error)
                }.resume()
        }
    }
    
    enum UrlAdress: String {
        //TODO: Change address to the App
        case Call_Phone = "tel://+380502022302"
        case Call_Skype = "skype:alexeykovalua"
        case Call_Viber = "viber://add?number=380502022302"
        case Call_WhatsApp = "https://api.whatsapp.com/send?phone=380502022302&text=Hello Alex, I need your help in quit smoking!"
        
        case Mail_Alexeykovalua = "mailto:quitsmokingtogether@gmail.com"
        
        case AppInItunes = "https://soft4status.com/"
        case Soft4Status = "https://soft4status.com"
        
        case Map_QST = "https://goo.gl/maps/ey8wMPzhm392"
        
        case Donate_100_UAH = """
        https://www.liqpay.ua/api/3/checkout?data=eyJ2ZXJzaW9uIjozLCJhY3Rpb24iOiJwYXlkb25hdGUiLCJwdWJsaWNfa2V5IjoiaTcwNzM2MjY2OTcyIiwiYW1vdW50IjoiNSIsImN1cnJlbmN5IjoiVVNEIiwiZGVzY3JpcHRpb24iOiJEb25hdGlvbiIsInR5cGUiOiJkb25hdGUiLCJsYW5ndWFnZSI6ImVuIn0%3D&signature=tqGq7%2F0Bngx6geeEzhlJbL5osm8%3D
        """
    }
}
