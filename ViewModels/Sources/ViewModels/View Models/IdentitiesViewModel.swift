// Copyright © 2020 Metabolist. All rights reserved.

import Combine
import Foundation
import ServiceLayer

public final class IdentitiesViewModel: ObservableObject {
    public let currentIdentityId: Identity.Id
    @Published public private(set) var identities = [Identity]()
    @Published public var alertItem: AlertItem?
    public let identityContext: IdentityContext

    private var cancellables = Set<AnyCancellable>()

    public init(identityContext: IdentityContext) {
        self.identityContext = identityContext
        currentIdentityId = identityContext.identity.id

        identityContext.service.identitiesPublisher()
            .assignErrorsToAlertItem(to: \.alertItem, on: self)
            .assign(to: &$identities)
    }
}
