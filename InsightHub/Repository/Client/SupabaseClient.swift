import Foundation
import Supabase

class Supabase {
    static let client = SupabaseClient(
        supabaseURL: URL(string: EnvironmentVariable.supabaseUrl)!,
        supabaseKey: EnvironmentVariable.supabaseKey
    )
}
