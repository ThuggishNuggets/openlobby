import Vapor

final class LobbyController {

    // view with lobbies
    func list(_ req: Request) throws -> Future<View> {
        return Lobby.query(on: req).all().flatMap { lobbies in
            let data = ["lobbylist": lobbies]
            return try req.view().render("list", data)
        }
    }

    func view(_ req: Request) throws -> Future<View> {
        return try req.parameters.next(Lobby.self).flatMap { lobby in
            let data = ["lobby": lobby]
            return try req.view().render("lobby", data)
        }
    }

    // create a new lobby
    func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Lobby.self).flatMap { lobby in
            return lobby.create(on: req).map { lobby in
                print("Lobby created!")
                return req.redirect(to: "/gtfo/\(lobby.id!)")
            }
        }
    }

    // update a lobby, delete when player count is 4
    func update(_ req: Request) throws -> Future<Response> {
        return try req.parameters.next(Lobby.self).flatMap { lobby in
            return try req.content.decode(LobbyForm.self).flatMap { lobbyForm in
                guard lobbyForm.playercount < 4 else {
                    return lobby.delete(on: req).map { _ in
                        return req.redirect(to: "/gtfo")
                    }
                }
                
                lobby.playercount = lobbyForm.playercount

                return lobby.save(on: req).map { _ in
                    return req.redirect(to: "/gtfo/\(lobby.id!)")
                }
            }
        }
    }

    // delete a lobby
    func delete(_ req: Request) throws -> Future<Response> {
        return try req.parameters.next(Lobby.self).flatMap { lobby in
            return lobby.delete(on: req).map { _ in
                return req.redirect(to: "/gtfo")
            }
        }
    }
}

struct LobbyForm: Content {
    var playercount: Int
}
