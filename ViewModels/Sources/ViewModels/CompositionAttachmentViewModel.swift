// Copyright © 2020 Metabolist. All rights reserved.

import Combine
import Foundation
import Mastodon
import ServiceLayer

public final class CompositionAttachmentViewModel: ObservableObject {
    public let attachment: Attachment

    init(attachment: Attachment) {
        self.attachment = attachment
    }
}
