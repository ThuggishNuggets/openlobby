import FluentSQLite
import Vapor

final class Lobby: SQLiteModel  {

    typealias ID = Int

    static let createdAtKey: TimestampKey? = \.createdAt
    static let updatedAtKey: TimestampKey? = \.updatedAt

    var id: Int?
    
    var publicID: String
    var playercount: Int

    var createdAt: Date?
    var updatedAt: Date?

    init(id: Int? = nil, publicID: String, playercount: Int) {
        self.id = id
        self.publicID = publicID
        self.playercount = playercount
    }
}

extension Lobby: Content {}
extension Lobby: Migration {}
extension Lobby: Parameter {}
