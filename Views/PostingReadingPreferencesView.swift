// Copyright © 2020 Metabolist. All rights reserved.

import Mastodon
import SwiftUI
import ViewModels

struct PostingReadingPreferencesView: View {
    @StateObject var viewModel: PostingReadingPreferencesViewModel

    var body: some View {
        Form {
            Section {
                Toggle("preferences.use-preferences-from-server",
                       isOn: $viewModel.preferences.useServerPostingReadingPreferences)
            }
            Section(header: Text("preferences.posting")) {
                VStack(alignment: .leading) {
                    Text("preferences.posting-default-visiblility")
                    Picker("", selection: $viewModel.preferences.postingDefaultVisibility,
                           content: {
                            Text("status.visibility.public").tag(Status.Visibility.public)
                            Text("status.visibility.unlisted").tag(Status.Visibility.unlisted)
                            Text("status.visibility.private").tag(Status.Visibility.private)
                           })
                        .pickerStyle(SegmentedPickerStyle())
                }
                Toggle("preferences.posting-default-sensitive",
                       isOn: $viewModel.preferences.postingDefaultSensitive)
            }
            .disabled(viewModel.preferences.useServerPostingReadingPreferences)
            Section(header: Text("preferences.reading")) {
                VStack(alignment: .leading) {
                    Text("preferences.reading-expand-media")
                    Picker("", selection: $viewModel.preferences.readingExpandMedia,
                           content: {
                            Text("preferences.expand-media.default").tag(Preferences.ExpandMedia.default)
                            Text("preferences.expand-media.show-all").tag(Preferences.ExpandMedia.showAll)
                            Text("preferences.expand-media.hide-all").tag(Preferences.ExpandMedia.hideAll)
                           })
                        .pickerStyle(SegmentedPickerStyle())
                }
                Toggle("preferences.reading-expand-spoilers",
                       isOn: $viewModel.preferences.readingExpandSpoilers)
            }
            .disabled(viewModel.preferences.useServerPostingReadingPreferences)
        }
        .navigationTitle("preferences.posting-reading")
        .alertItem($viewModel.alertItem)
    }
}

#if DEBUG
import PreviewViewModels

struct PostingReadingPreferencesViewView_Previews: PreviewProvider {
    static var previews: some View {
        PostingReadingPreferencesView(viewModel: .init(identification: .preview))
    }
}
#endif
