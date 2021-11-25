//
//  SearchActivityPresentationAdapter.swift
//  LazyFolksiOSApp
//
//  Created by Luis Francisco Piura Mejia on 23/11/21.
//

import LazyFolksEngine
import Combine

/// This class was created to decouple the `SearchActivityController` from the loaders
/// that means that even when `SearchActivityController` can perform fetch actions
/// it is agnostic from whom is doing the request

final class SearchActivityPresentationAdapter {
    private let loader: SearchActivityLoader
    private var cancellable: AnyCancellable?
    var presenter: SearchActivityPresenter?
    
    init(loader: @escaping SearchActivityLoader) {
        self.loader = loader
    }
    
    func searchActivity(type: String, participants: String, minPrice: String, maxPrice: String) {
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
