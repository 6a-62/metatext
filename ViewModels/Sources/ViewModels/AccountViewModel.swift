// Copyright © 2020 Metabolist. All rights reserved.

import Combine
import Foundation
import Mastodon
import ServiceLayer

public struct AccountViewModel: CollectionItemViewModel {
    public let events: AnyPublisher<AnyPublisher<CollectionItemEvent, Error>, Never>

    private let accountService: AccountService
    private let identification: Identification
    private let eventsSubject = PassthroughSubject<AnyPublisher<CollectionItemEvent, Error>, Never>()

    init(accountService: AccountService, identification: Identification) {
        self.accountService = accountService
        self.identification = identification
        events = eventsSubject.eraseToAnyPublisher()
    }
}

public extension AccountViewModel {
    var headerURL: URL {
        if !identification.appPreferences.shouldReduceMotion, identification.appPreferences.animateHeaders {
            return accountService.account.header
        } else {
            return accountService.account.headerStatic
        }
    }

    var isLocal: Bool { accountService.isLocal }

    var domain: String? { accountService.domain }

    var displayName: String {
        accountService.account.displayName.isEmpty ? accountService.account.acct : accountService.account.displayName
    }

    var accountName: String { "@".appending(accountService.account.acct) }

    var isLocked: Bool { accountService.account.locked }

    var relationship: Relationship? { accountService.relationship }

    var identityProofs: [IdentityProof] { accountService.identityProofs }

    var fields: [Account.Field] { accountService.account.fields }

    var note: NSAttributedString { accountService.account.note.attributed }

    var emoji: [Emoji] { accountService.account.emojis }

    var followingCount: Int { accountService.account.followingCount }

    var followersCount: Int { accountService.account.followersCount }

    var isSelf: Bool { accountService.account.id == identification.identity.account?.id }

    func avatarURL(profile: Bool = false) -> URL {
        if !identification.appPreferences.shouldReduceMotion,
           (identification.appPreferences.animateAvatars == .everywhere
                || identification.appPreferences.animateAvatars == .profiles && profile) {
            return accountService.account.avatar
        } else {
            return accountService.account.avatarStatic
        }
    }

    func urlSelected(_ url: URL) {
        eventsSubject.send(
            accountService.navigationService.item(url: url)
                .map { CollectionItemEvent.navigation($0) }
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher())
    }

    func followingSelected() {
        eventsSubject.send(
            Just(.navigation(.collection(accountService.followingService())))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher())
    }

    func followersSelected() {
        eventsSubject.send(
            Just(.navigation(.collection(accountService.followersService())))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher())
    }

    func reportViewModel() -> ReportViewModel {
        ReportViewModel(accountService: accountService, identification: identification)
    }

    func follow() {
        ignorableOutputEvent(accountService.follow())
    }

    func unfollow() {
        ignorableOutputEvent(accountService.unfollow())
    }

    func hideReblogs() {
        ignorableOutputEvent(accountService.hideReblogs())
    }

    func showReblogs() {
        ignorableOutputEvent(accountService.showReblogs())
    }

    func block() {
        ignorableOutputEvent(accountService.block())
    }

    func unblock() {
        ignorableOutputEvent(accountService.unblock())
    }

    func mute() {
        ignorableOutputEvent(accountService.mute())
    }

    func unmute() {
        ignorableOutputEvent(accountService.unmute())
    }

    func pin() {
        ignorableOutputEvent(accountService.pin())
    }

    func unpin() {
        ignorableOutputEvent(accountService.unpin())
    }

    func set(note: String) {
        ignorableOutputEvent(accountService.set(note: note))
    }

    func domainBlock() {
        ignorableOutputEvent(accountService.domainBlock())
    }

    func domainUnblock() {
        ignorableOutputEvent(accountService.domainUnblock())
    }
}

private extension AccountViewModel {
    func ignorableOutputEvent(_ action: AnyPublisher<Never, Error>) {
        eventsSubject.send(action.map { _ in .ignorableOutput }.eraseToAnyPublisher())
    }
}
