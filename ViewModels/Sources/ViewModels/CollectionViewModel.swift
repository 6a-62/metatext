// Copyright © 2020 Metabolist. All rights reserved.

import Combine
import Foundation

public protocol CollectionViewModel {
    var updates: AnyPublisher<CollectionUpdate, Never> { get }
    var title: AnyPublisher<String, Never> { get }
    var titleLocalizationComponents: AnyPublisher<[String], Never> { get }
    var expandAll: AnyPublisher<ExpandAllState, Never> { get }
    var alertItems: AnyPublisher<AlertItem, Never> { get }
    var loading: AnyPublisher<Bool, Never> { get }
    var events: AnyPublisher<CollectionItemEvent, Never> { get }
    var shouldAdjustContentInset: Bool { get }
    var nextPageMaxId: String? { get }
    var preferLastPresentIdOverNextPageMaxId: Bool { get }
    func request(maxId: String?, minId: String?)
    func viewedAtTop(indexPath: IndexPath)
    func select(indexPath: IndexPath)
    func canSelect(indexPath: IndexPath) -> Bool
    func viewModel(indexPath: IndexPath) -> CollectionItemViewModel
    func toggleExpandAll()
}
