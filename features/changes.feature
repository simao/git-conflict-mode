Feature: Editing conflicts

  Scenario: Using "their" changes
    When I turn on git-conflict-mode
    And I insert:
    """
    <<<<<<< HEAD:file.txt
    Hello world
    =======
    Goodbye
    >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt

    More code
    """
    And I go to the front of the word "Hello"
    And I press "C-c C-g ut"
    Then I should see:
    """
    Goodbye

    More code
    """

  Scenario: Using "mine" changes
    When I turn on git-conflict-mode
    And I insert:
    """
    <<<<<<< HEAD:file.txt
    Hello world

    More code
    =======
    Goodbye
    >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt

    More code
    """
    And I go to the front of the word "Hello"
    And I press "C-c C-g um"
    Then I should see:
    """
    Hello world

    More code
    """

