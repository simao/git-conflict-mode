Feature: Navigating conflicts

  Scenario: Navigating to next conflict
    When I turn on git-conflict-mode
    And I insert:
    """
    <<<<<<< HEAD:file.txt
    Hello world
    =======
    Goodbye
    >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt

    <<<<<<< HEAD:file.txt
    Another Conflict
    =======
    Goodbye again
    >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
    """
    And I go to the front of the word "Hello"
    And I press "<F11>"
    Then the cursor should be before "Another Conflict"

  Scenario: Navigating to next unexisting conflict
    When I turn on git-conflict-mode
    And I insert:
    """
    Hello world
    """
    And I go to the front of the word "Hello"
    And I press "<F11>"
    Then I should see message "There is no next conflict"

  Scenario: Navigating to previous conflict
    When I turn on git-conflict-mode
    And I insert:
    """
    <<<<<<< HEAD:file.txt
    Hello world
    =======
    Goodbye
    >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt

    <<<<<<< HEAD:file.txt
    Another Conflict
    =======
    Goodbye again
    >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
    """
    And I go to the front of the word "again"
    And I press "S-<F11>"
    Then the cursor should be before "Hello world"


  Scenario: Navigating to "their changes"
    When I turn on git-conflict-mode
    And I insert:
    """
    <<<<<<< HEAD:file.txt
    Hello world
    =======
    Goodbye
    >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
    """
    And I go to the front of the word "world"
    And I press "<F12>"
    Then the cursor should be before "Goodbye"