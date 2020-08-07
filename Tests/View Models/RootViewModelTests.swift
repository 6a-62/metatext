// Copyright © 2020 Metabolist. All rights reserved.

import XCTest
import Combine
import CombineExpectations
@testable import Metatext

class RootViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testAddIdentity() throws {
        let sut = RootViewModel(environment: .fresh())
        let recorder = sut.$identityID.record()

        XCTAssertNil(try wait(for: recorder.next(), timeout: 1))

        let addIdentityViewModel = sut.addIdentityViewModel()

        addIdentityViewModel.addedIdentityID
            .sink(receiveValue: sut.newIdentitySelected(id:))
            .store(in: &cancellables)

        addIdentityViewModel.urlFieldText = "https://mastodon.social"
        addIdentityViewModel.goTapped()

        let identityID = try wait(for: recorder.next(), timeout: 1)!

        XCTAssertNotNil(identityID)
        XCTAssertNotNil(sut.mainNavigationViewModel(identityID: identityID))
    }
}
