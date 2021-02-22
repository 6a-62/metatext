// Copyright © 2021 Metabolist. All rights reserved.

import Kingfisher
import UIKit

final class AnimatedTextAttachment: NSTextAttachment {
    var imageView = AnimatedImageView()
    var imageBounds: CGRect?

    override func image(forBounds imageBounds: CGRect,
                        textContainer: NSTextContainer?,
                        characterIndex charIndex: Int) -> UIImage? {
        self.imageBounds = imageBounds

        return nil // rendered by AnimatingLayoutManager or AnimatedAttachmentLabel
    }
}
