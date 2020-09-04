// Copyright © 2020 Metabolist. All rights reserved.

import DB
import Foundation
import HTTP
import Keychain
import Mastodon
import UserNotifications

public struct AppEnvironment {
    let session: Session
    let webAuthSessionType: WebAuthSession.Type
    let keychain: Keychain.Type
    let userDefaults: UserDefaults
    let userNotificationClient: UserNotificationClient
    let inMemoryContent: Bool
    let identityFixture: IdentityFixture?

    public init(session: Session,
                webAuthSessionType: WebAuthSession.Type,
                keychain: Keychain.Type,
                userDefaults: UserDefaults,
                userNotificationClient: UserNotificationClient,
                inMemoryContent: Bool,
                identityFixture: IdentityFixture?) {
        self.session = session
        self.webAuthSessionType = webAuthSessionType
        self.keychain = keychain
        self.userDefaults = userDefaults
        self.userNotificationClient = userNotificationClient
        self.inMemoryContent = inMemoryContent
        self.identityFixture = identityFixture
    }
}

public extension AppEnvironment {
    static func live(userNotificationCenter: UNUserNotificationCenter) -> Self {
        Self(
            session: Session(configuration: .default),
            webAuthSessionType: LiveWebAuthSession.self,
            keychain: LiveKeychain.self,
            userDefaults: .standard,
            userNotificationClient: .live(userNotificationCenter),
            inMemoryContent: false,
            identityFixture: nil)
    }
}
