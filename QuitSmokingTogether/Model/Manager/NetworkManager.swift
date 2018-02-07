//
//  NetworkManager.swift
//  QuitSmokingTogether
//
//  Created by Yaroslav Zhurbilo on 03.02.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Alamofire

// MARK: Values that need to change!!!
extension NetworkManager {
    
    static fileprivate var currentServer: Server {
        return .development // MARK: Change it!
    }
    
    enum Server {
        case production
        case development
        
        var baseAddress: String {
            switch self {
                
            // MARK: Change Addresses of the SERVERS
            case .production: return ""
            case .development: return "http://qst.1gb.ua/"
            }
        }
    }
}

class NetworkManager: NSObject {
    
    func get(_ path: Request, completionHandler: @escaping CompletionHandlerWithData)  {
        
        guard let url = path.getURL() else {
            let errorMessages = [NetworkError.badURL]
            let resultData = ResultData.withErrors(errorMessages)
            return completionHandler(resultData)
        }
        
        Alamofire.request(url).responseJSON { response in
            let resultData = self.parseResultDataWith(response, andPath: path)
            completionHandler(resultData)
        }
    }
    
    func parseResultDataWith(_ response: DataResponse<Any>, andPath path: Request) -> ResultData {
        
        switch path {
        case .events:
            return getArrayWithEventsFrom(response)
        default:
            let errorMessages = [NetworkError.undefinedPath]
            return ResultData.withErrors(errorMessages)
        }
    }
    
}

extension NetworkManager {
    
    func getArrayWithEventsFrom(_ response: DataResponse<Any>) -> ResultData {
        
        guard let arrayWithEventsResult = response.result.value as? [(Dictionary<String, Any>)]  else {
            return ResultData.withErrors([NetworkError.undefined])
        }
        
        var arrayWithEvents = [Event]()
        for dictWithResult in arrayWithEventsResult {
            let event = Event(withResult: dictWithResult)
            arrayWithEvents.append(event)
        }
        
        return ResultData.withEvents(arrayWithEvents)
        
    }
}

extension NetworkManager {
    
    enum Request {
        case events
        
        var address: String {
            switch self {
            case .events:
                return "wp-json/wp/v2/posts?_embed"
            }
        }
        
        func getURL() -> URL? {
            var addressString = NetworkManager.currentServer.baseAddress
            addressString += "en/"
            addressString += self.address
            return URL(string: addressString)
        }
    }
}



