import SwiftUI

struct SceneStorageView: View {
    @SceneStorage("myText") private var editorText = ""
    var body: some View {
        TextEditor(text: $editorText)
            .padding(30)
            .font(.largeTitle)
    }
}
struct AppStorageView: View {
    @AppStorage("mytext") var editorText: String = "Sample Text"
    var body: some View {
        TextEditor(text: $editorText)
            .padding(30)
            .font(.largeTitle)
    }
}


struct CH_28: View {
    var body: some View {
        TabView {
            SceneStorageView()
                .tabItem {
                    Text("Scene")
                }
            AppStorageView()
                .tabItem {
                    Text("App")
                }
        }
    }
}

#Preview {
    CH_28()
}
