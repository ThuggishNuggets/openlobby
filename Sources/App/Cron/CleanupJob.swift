import Vapor
import VaporCron

struct CleanupJob: VaporCronSchedulable {
    static var expression: String { return "*/5 * * * *" } // every 5 minutes
    
    static func task(on container: VaporCronContainer) -> Future<Void> {
        print("Cleanup Running!")
        // this is how you could get a connection to the database
        return container.withPooledConnection(to: .sqlite) { conn in
            // here you sould do whatever you want cause you already have a connection to database
            return Lobby.query(on: conn).all().flatMap { lobbies in
                return lobbies.map { lobby in
                    let updatedAt = lobby.updatedAt ?? Date()
                    if Date() > updatedAt.addingTimeInterval(900) {
                        return lobby.delete(on: conn)
                    }
                    return lobby.save(on: conn).transform(to: ())
                }.flatten(on: container)
             }
        }
    }
}