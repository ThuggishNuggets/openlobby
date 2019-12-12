import FluentSQLite
import Vapor

final class Lobby: SQLiteModel  {

    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt

    var id: Int?
    
    var publicID: String
    var level: String
    var playercount: Int
    var discordLink: String

    var createdAt: Date?
    var updatedAt: Date?

    init(id: Int? = nil, publicID: String, level: String, playercount: Int, discordLink: String) {
        self.id = id
        self.publicID = publicID
        self.level = level
        self.playercount = playercount
        self.discordLink = discordLink
    }
}

extension Lobby: Content {}
extension Lobby: Migration {}
extension Lobby: Parameter {}
