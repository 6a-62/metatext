// Copyright © 2020 Metabolist. All rights reserved.

import Foundation

class PreferencesViewModel: ObservableObject {
    let handle: String

    private let identityService: IdentityService

    init(identityService: IdentityService) {
        self.identityService = identityService
        handle = identityService.identity.handle
    }
}

extension PreferencesViewModel {
    func postingReadingPreferencesViewModel() -> PostingReadingPreferencesViewModel {
        PostingReadingPreferencesViewModel(identityService: identityService)
    }
}
