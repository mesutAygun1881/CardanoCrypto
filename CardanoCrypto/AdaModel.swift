//
//  AdaModel.swift
//  CardanoCrypto
//
//  Created by Mesut Aygün on 1.06.2021.
//

import Foundation

struct ApiResponse : Codable {
    let data : [Int : AdaCoinData]
}


struct AdaCoinData : Codable {
    let id : Int
    let name : String
    let symbol : String
    let date_added : String
    let tags : [String]
    let quote : [String : Quote]
}
struct Quote : Codable {
    let price : Float
    let volume_24h : Float
    let market_cap : Double
}

/*{
 "status": {
   "timestamp": "2021-06-01T15:36:46.340Z",
   "error_code": 0,
   "error_message": null,
   "elapsed": 17,
   "credit_count": 1,
   "notice": null
 },
 "data": {
   "2010": {
     "id": 2010,
     "name": "Cardano",
     "symbol": "ADA",
     "slug": "cardano",
     "num_market_pairs": 274,
     "date_added": "2017-10-01T00:00:00.000Z",
     "tags": [
       "mineable",
       "dpos",
       "pos",
       "platform",
       "research",
       "smart-contracts",
       "staking",
       "binance-chain"
     ],
     "max_supply": 45000000000,
     "circulating_supply": 31948309440.7478,
     "total_supply": 45000000000,
     "is_active": 1,
     "platform": null,
     "cmc_rank": 4,
     "is_fiat": 0,
     "last_updated": "2021-06-01T15:35:13.000Z",
     "quote": {
       "USD": {
         "price": 1.69481361688012,
         "volume_24h": 3999501911.6855702,
         "percent_change_1h": -1.83631119,
         "percent_change_24h": 2.03489062,
         "percent_change_7d": 10.51599579,
         "percent_change_30d": 27.23123333,
         "percent_change_60d": 39.05410697,
         "percent_change_90d": 37.60001168,
         "market_cap": 54146429876.47906,
         "last_updated": "2021-06-01T15:35:13.000Z"
       }
     }
   }
 }
}**/
