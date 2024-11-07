//
//  cryptoModel.swift
//  cdc-assessment-1
//
//  Created by Jacob Zhang on 2024/11/7.
//

import Foundation

struct CryptoModel: Decodable {
    let title: String
}

struct CryptoListResponse: Decodable {
    let data: [CryptoModel]
}
