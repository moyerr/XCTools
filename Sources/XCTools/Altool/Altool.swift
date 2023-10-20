import Sh

public struct Altool {
    let credential: any AltoolCredential

    public init(credential: some AltoolCredential) {
        self.credential = credential
    }
}
