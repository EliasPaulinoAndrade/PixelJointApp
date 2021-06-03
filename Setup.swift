import ProjectDescription

let setup = Setup(
    requires: [],
    actions: [
        .homebrew(packages: ["sourcery", "swiftlint"]),
    ]
)
