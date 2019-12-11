import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let lobbyController = LobbyController()
    
    router.get("gtfo", use: lobbyController.list)

    router.get("gtfo", Lobby.parameter, use: lobbyController.view)

    router.post("gtfo", use: lobbyController.create)
    router.post("gtfo", Lobby.parameter, use: lobbyController.update)
    router.post("gtfo", Lobby.parameter, "delete", use: lobbyController.delete)
}
