//
//  CryptoListViewModel.swift
//  cdc-assessment-1
//
//  Created by Jacob Zhang on 2024/11/7.
//

import Foundation
import Combine

class CryptoListViewModel: ObservableObject {
    @Published var cryptoList: [CryptoModel] = []
    @Published var hasError: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let repository = CryptoRepository()

    func loadCryptoData() {
        repository.fetchCryptoList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    self.hasError = true
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] cryptoList in
                self?.cryptoList = cryptoList
            })
            .store(in: &cancellables)
    }
}
