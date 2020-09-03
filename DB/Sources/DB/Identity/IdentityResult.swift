// Copyright © 2020 Metabolist. All rights reserved.

import Foundation
import GRDB
import Mastodon

struct IdentityResult: Codable, Hashable, FetchableRecord {
    let identity: StoredIdentity
    let instance: Identity.Instance?
    let account: Identity.Account?
    let pushSubscriptionAlerts: PushSubscription.Alerts
}
