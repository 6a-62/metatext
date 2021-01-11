// Copyright © 2020 Metabolist. All rights reserved.

import Foundation
import Mastodon
import ServiceLayer

public enum CollectionItemEvent {
    case ignorableOutput
    case navigation(Navigation)
    case attachment(AttachmentViewModel, StatusViewModel)
    case compose(inReplyTo: StatusViewModel?, redraft: Status?)
    case report(ReportViewModel)
    case share(URL)
}
