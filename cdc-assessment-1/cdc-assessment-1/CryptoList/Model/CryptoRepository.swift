//
//  CryptoRepository.swift
//  cdc-assessment-1
//
//  Created by Jacob Zhang on 2024/11/7.
//

import Foundation
import Combine

class CryptoRepository {
    func fetchCryptoList() -> Future<[CryptoModel], Error> {
        return Future { promise in
            if let path = Bundle.main.path(forResource: "crypto_list", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    let decodedResponse = try JSONDecoder().decode(CryptoListResponse.self, from: data)
                    promise(.success(decodedResponse.data))
                } catch {
                    promise(.failure(error))
                }
            } else {
                promise(.failure(NSError(domain: CDCStringConstants.notFound, code: -1, userInfo: nil)))
            }
        }
    }
}
