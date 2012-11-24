Feature: Merge Articles
  As an admin
  In order to remove articles on a duplicate topic
  I want to be able to merge articles on the same topic

Background: users and articles have been added to database

  Given the following users exist:
  | login                 | password    | email   | profile_id  | name    | state   |
  | admin_gordon          | aaaaaa      | a@a.com | 1           | gordon  | active  |
  | blog_publisher_john   | bbbbbb      | b@b.com | 2           | john    | active  |
  | contributor_mary      | cccccc      | c@c.com | 3           | mary    | active  |

  Given the following articles exist:
  | id  | title             | author              | body              | allow_comments  | published_at        |
  | 1   | Flying Parakeets  | admin_gordon        | Article 1 Content | true            | 2012-10-05 05:05:05 |
  | 2   | Flying Pigs       | blog_publisher_john | Article 2 Content | true            | 2012-10-05 05:05:05 |

#  Given comment for article 1 exists

#  Given the following comments exist:
#  | id  | type    | author              | body                | article_id  | published_at        |
#  | 1   | Comment | blog_publisher_john | Hi Random Comment 1 | 1           | 2012-10-05 05:10:05 |
#  | 2   | Comment | contributor_mary    | Hi Random Comment 2 | 2           | 2012-10-05 05:10:05 |

  Scenario: Cannot merge articles when not admin
    Given I am not an admin
    When I am on the edit article page
    Then I should not see the "merge articles" form

  Scenario: Merged article should contain text of both
    Given I am logged in as admin
    Then I should see "Flying Parakeets"
    When I follow "Flying Parakeets"
    When I fill in "article_id_merge" with "2"
    And I press "Merge"
    Then I should see "Article Content 1"
    And I should see "Article Content 2"

  Scenario: Merged article should have one author (from either of original)
    Given I am logged in as admin
    Given I am on the edit article page
    Then I should see "author 1"
    And I should not see "author 2"

  Scenario: Merged article should have the comments from both the originals
    Given I am logged in as admin
    Then I should see "Flying Parakeets"
    When I follow "Flying Parakeets"
    Then I should see "comment body 1"
    And I should see "comment body 2"

  Scenario: Merged article should have one title (from either of original)
    Given I am logged in as admin
    Then I should see "Flying Parakeets"
    When I follow "Flying Parakeets"
    Then I should see "title 1"
    And I should not see "title 2"

