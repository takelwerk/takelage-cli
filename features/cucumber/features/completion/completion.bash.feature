@completion
@completion.bash

Feature: I can print bash autocompletion code

  Scenario: Print bash completion code
    When I successfully run `tau-cli completion bash`
    Then the output should contain "complete -F _tau tau"
