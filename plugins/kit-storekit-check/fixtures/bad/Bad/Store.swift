import StoreKit

// Fixture: the two traps kit-storekit-check looks for.
enum ProductID { static let monthly = "com.example.bad.pro.monthly" }

func isSubscribed(_ t: Transaction) -> Bool {
    let expiry = t.expirationDate ?? .distantFuture   // trap: nil expiry reads as subscribed forever
    return expiry > Date()
}
