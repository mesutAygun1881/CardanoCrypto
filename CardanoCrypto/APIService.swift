//
//  APIService.swift
//  CardanoCrypto
//
//  Created by Mesut Aygün on 1.06.2021.
//https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?slug=cardano&CMC_PRO_API_KEY=ed4d6b07-cbba-4e75-8a5a-a6bd3bd6aaa8

import Foundation


final class APIService {
    
    //modelde kullanmak için shared tanımladık
    static let shared = APIService()
    
    private init(){}
    
    struct ApiUrl {
        static let apiKey = "ed4d6b07-cbba-4e75-8a5a-a6bd3bd6aaa8"
        static let apiKeyHeader = "X-CMC_PRO_API_KEY"
        static let baseUrl = "https://pro-api.coinmarketcap.com/v1/"
        static let ada = "cardano"
        static let endpoint = "cryptocurrency/quotes/latest"
    }
    
    enum APIError  : Error {
        case invalidURL
    }
    
    public func  getADAData(completion : @escaping (Result<AdaCoinData , Error>) -> Void){
        guard let url = URL(string: ApiUrl.baseUrl + ApiUrl.endpoint + "?slug=" + ApiUrl.ada) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        print("\(url.absoluteString)")
        var request = URLRequest(url: url)
        request.setValue(ApiUrl.apiKey, forHTTPHeaderField: ApiUrl.apiKeyHeader)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _ , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                return
            }
            do {
                
                let response = try JSONDecoder().decode(ApiResponse.self , from : data)
               
                guard let adaCoindata =  response.data.values.first else {
                    return
                }
               
                completion(.success(adaCoindata))
                
                
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}


