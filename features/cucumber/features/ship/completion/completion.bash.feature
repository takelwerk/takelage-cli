@ship
@ship.completion
@ship.completion.bash

Feature: I can print bash ship autocompletion code

  Scenario: Print bash ship completion code
    When I successfully run `ship-cli completion bash`
    Then the output should contain "complete -F _ship ship"
