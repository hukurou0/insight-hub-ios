# Insight Hub iOS

## Requirements

- Xcode 16.2
- Swift 6 or later
- Homebrew
  - [SwiftFormat](https://github.com/nicklockwood/SwiftFormat): A code formatter dedicated for Swift
  - [Python 3](https://www.python.org/) or later: Use this for running [git-format-staged](https://github.com/hallettj/git-format-staged)

## Supports

- iOS 17 or later
- iPadOS 17 or later

## Development

### Setup

> [!CAUTION]
> If you want to communicate to API for development purpose, you need to follow [this instruction](https://github.com/hukurou0/insight-hub/tree/master/api) to start the localhost.

1. Clone this repository

    ```shell
    git clone https://github.com/hukurou0/insight-hub-ios.git
    ```

2. Run setup command

    This command sets up pre-commit hook to run `swiftformat` before you commit.

    ```shell
    make setup
    ```

3. Open Xcode

    ```shell
    xed .
    ```

4. Let's start development!

    Press `cmd + R` to run this app.
