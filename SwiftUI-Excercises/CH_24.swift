enum DurationError: Error {
    case tooLong
    case tooShort
}

func doSomething() async {
    print("Start")
    do {
        try await takesTooLong(delay: 25)
    } catch DurationError.tooShort {
        print("too short")
    } catch DurationError.tooLong {
        print("too long")
    } catch {
        print("unknown")
    }

    print("wait")
    print("End")
}
func takesTooLong(delay: UInt32) async throws {
    if delay < 5 {
        throw DurationError.tooShort
    } else if delay > 20 {
        throw DurationError.tooLong
    }
    
    sleep(delay)
    print("async task at \(Date())")
}

import SwiftUI

struct CH_24: View {
    
    var body: some View {
        Button(action: {
            Task {
                await doSomething()
            }
        }) {
            Text("Label")
        }
    }
}

#Preview {
    CH_24()
}
