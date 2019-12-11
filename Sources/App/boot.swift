import Vapor
import VaporCron

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // your code here
    try VaporCron.schedule(CleanupJob.self, on: app)
}
