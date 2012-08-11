Feature: Search items
Many items are lost but they can also be found

  # The final step of these two tests is currently failing; looks like a
  # Capybara bug, since it recognizes the text to compare is identical
  Scenario: Find a lost truck
    Given a "truck" lost by "Fox Tall" in "Chapter 3 in a vast white expanse" is in the database with the description:
    """
    New T-1000 pickup truck last seen being driven by a porcupine
    """
    When I search for a lost "truck"
    Then I should see:
    """
    Fox Tall
    --
    truck
    --
    Chapter 3 in a vast white expanse
    --
    New T-1000 pickup truck last seen being driven by a porcupine
    """

  Scenario: Find a found cup
    Given a "cup" found by "Why" in "A hotel buffet lunch" is in the database with the description:
    """
    Probably belongs to a guy who wears seashell necklaces
    """
    When I search for a found "cup"
    Then I should see:
    """
    Why
    --
    cup
    --
    A hotel buffet lunch
    --
    Probably belongs to a guy who wears seashell necklaces
    """