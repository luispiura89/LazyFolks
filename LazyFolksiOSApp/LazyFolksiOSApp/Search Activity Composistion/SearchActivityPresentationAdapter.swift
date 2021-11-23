//
//  SearchActivityPresentationAdapter.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import LazyFolksEngine
import Combine

final class SearchActivityPresentationAdapter {
    private let loader: SearchActivityLoader
    private var cancellable: AnyCancellable?
    var presenter: SearchActivityPresenter?
    
    init(loader: @escaping SearchActivityLoader) {
        self.loader = loader
    }
    
    func searchActivity(type: String, participants: Int, minPrice: Double, maxPrice: Double) {
        presenter?.startSearchingActivity()
        cancellable = loader(type, participants, minPrice, maxPrice)
            .sink { [weak presenter] result in
                if case let .failure(error) = result {
                    presenter?.didFinishLoading(with: error)
                }
            } receiveValue: {  [weak presenter] activity in
                presenter?.didFinishLoading(with: activity)
            }
    }
}
