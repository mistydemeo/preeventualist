Feature: Submit items
Many people lose items
And other people find items
It should be possible to submit items to the database.

	Scenario: Submit some found skills
		When "Why" submits a found "Ruby skills" found at "Wixl park" with the description:
		"""
		I can give you Ruby skills!
		Come visit poignantguide.net!
		"""
		Then I should see "Thanks for submitting your Ruby skills!"

	Scenario: Submit a lost ham
		When "Elf" submits a lost "ham" seen in "Ambrose Caverns" with the description:
		"""
		A bit leaky but very loving
		"""
		Then I should see "Thanks for submitting your ham!"