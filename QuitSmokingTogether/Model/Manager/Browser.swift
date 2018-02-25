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
        
        case AppInItunes = "http://quitsmokingtogether.org/"
        case Soft4Status = "https://soft4status.com"
        
        case Map_QST = "https://goo.gl/maps/ey8wMPzhm392"
        
        case Surf_LinkedIn_Yaroslav = "https://www.linkedin.com/in/zhurbilo-yaroslav/"
        case Surf_LinkedIn_Vlad = "https://www.linkedin.com/in/ivlad003/"
        
        case Surf_QSTWebsite = "http://quitsmokingtogether.org"
    }
}
