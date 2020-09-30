// Copyright © 2020 Metabolist. All rights reserved.

import Foundation
import GRDB

public struct AccountList: Codable, FetchableRecord, PersistableRecord {
    let id: UUID

    public init() {
        id = UUID()
    }
}

extension AccountList {
    static let joins = hasMany(AccountListJoin.self).order(AccountListJoin.Columns.index)
    static let accounts = hasMany(
        AccountRecord.self,
        through: joins,
        using: AccountListJoin.account)

    var accounts: QueryInterfaceRequest<AccountInfo> {
        AccountInfo.request(request(for: Self.accounts))
    }
}